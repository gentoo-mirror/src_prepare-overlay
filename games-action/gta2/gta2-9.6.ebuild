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
	sys-apps/grep"

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
}

src_install() {
	insinto /usr/share/games
	doins -r gta2
	dobin "${FILESDIR}/gta2"
	dobin "${FILESDIR}/gta2_manager"
}
