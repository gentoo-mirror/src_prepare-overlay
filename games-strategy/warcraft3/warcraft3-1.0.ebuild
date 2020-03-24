# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE=""

LICENSE="Warcraft3_EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	sys-apps/sed
	sys-apps/coreutils
	sys-apps/grep
	sys-apps/gawk
	sys-process/procps
	media-gfx/icoutils
	media-gfx/imagemagick
	x11-misc/xvfb-run
	x11-wm/openbox"

RDEPEND="
	app-emulation/wine-vanilla[abi_x86_32]
	app-emulation/winetricks
	app-shells/bash"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	if [ -z ${CDKEY} ] || [ -z ${CDROM_ROOT} ]; then
		eerror "Missing CDKEY and CDROM_ROOT environment variables. Without them, Warcraft 3 cannot be installed."
		exit
	fi
	export WINEPREFIX="$(pwd)/wineprefix"
	export WINEARCH="win32"
	export WINEDEBUG="-all"
	export HID_DEVICES=($(ls /dev | grep ^hid | sed 's_^_/dev/_'))
	einfo "Adding temporary pseudo rw to /dev/input"
	addpredict /dev/input
	for hid_device in ${HID_DEVICES[@]}; do
		einfo "Adding temporary pseudo rw to ${hid_device}"
		addpredict ${hid_device}
	done
	cat <<EOF > run_installer_in_openbox.sh
#!/usr/bin/env bash
set -euo pipefail
cd ${CDROM_ROOT}
wine install.exe &
EOF
	chmod +x run_installer_in_openbox.sh
	CDKEY=${CDKEY} CDROM_ROOT=${CDROM_ROOT} ${FILESDIR}/install_wc3_linux.sh
	mv ${WINEPREFIX}/drive_c/Program\ Files/Warcraft\ III warcraft3
	wrestool -x -t14 -n WAR3.ICO -o . warcraft3/War3.exe
	wrestool -x -t14 -n WORLDEDIT_ICON -o . warcraft3/WorldEdit.exe
	convert War3.exe_14_WAR3.ICO_0.ico warcraft3.png
	convert WorldEdit.exe_14_WORLDEDIT_ICON.ico warcraft3_worldedit.png
	mv warcraft3-8.png warcraft3.png
	mv warcraft3_worldedit-8.png warcraft3_worldedit.png
}

src_install() {
	insinto /usr/share/games
	doins -r warcraft3
	insinto /usr/share/pixmaps
	doins warcraft3.png
	doins warcraft3_worldedit.png
	insinto /usr/share/applications
	doins "${FILESDIR}/warcraft3.desktop"
	doins "${FILESDIR}/warcraft3_worldedit.desktop"
	dobin "${FILESDIR}/warcraft3"
	dobin "${FILESDIR}/warcraft3_worldedit"
}
