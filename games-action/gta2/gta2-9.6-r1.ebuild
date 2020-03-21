# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="And remember - respect is everything!"
HOMEPAGE="https://www.rockstargames.com/gta2/homepage.html"
SRC_URI="https://archive.org/download/pc_gta2/GTA2_full.zip"

LICENSE="Rockstar_freeware_GTA2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	app-arch/unzip
	sys-apps/sed
	sys-apps/coreutils
	sys-apps/grep
	media-gfx/icoutils
	media-gfx/imagemagick"

RDEPEND="
	app-emulation/wine-vanilla[abi_x86_32]
	app-emulation/winetricks
	app-shells/bash"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	unzip ${DISTDIR}/GTA2_full.zip
	export WINEPREFIX="$(pwd)/wineprefix"
	export WINEARCH="win32"
	export RESPONSE_FILE=$(readlink -f ${FILESDIR}/gta2.iss | sed 's_^_Z:_;s_/_\\_g')
	export WINEDEBUG="-all"
	export HID_DEVICES=($(ls /dev | grep ^hid | sed 's_^_/dev/_'))
	einfo "Adding temporary pseudo rw to /dev/input"
	addpredict /dev/input
	for hid_device in ${HID_DEVICES[@]}; do
		einfo "Adding temporary pseudo rw to ${hid_device}"
		addpredict ${hid_device}
	done
	wine GTA2/GTA2.exe /s /f1"${RESPONSE_FILE}" /f2"C:\iss.log"
	mv ${WINEPREFIX}/drive_c/Program\ Files/Rockstar\ Games/GTA2 gta2
	wrestool -x -t14 -n 128 -o . gta2/gta2\ manager.exe
	wrestool -x -t14 -o . gta2/gta2.exe
	convert 'gta2 manager.exe_14_128_2057.ico' gta2_manager.png
	convert 'gta2.exe_14_101_2057.ico' gta2.png
}

src_install() {
	insinto /usr/share/games
	doins -r gta2
	insinto /usr/share/pixmaps
	doins gta2_manager.png
	doins gta2.png
	insinto /usr/share/applications
	doins "${FILESDIR}/gta2.desktop"
	doins "${FILESDIR}/gta2_manager.desktop"
	dobin "${FILESDIR}/gta2"
	dobin "${FILESDIR}/gta2_manager"
}
