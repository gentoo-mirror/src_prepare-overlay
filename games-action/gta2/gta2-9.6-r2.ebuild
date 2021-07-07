# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

REQUIRED_USE="abi_x86_32"
inherit run-wine windows-helper

DESCRIPTION="And remember - respect is everything!"
HOMEPAGE="https://www.rockstargames.com/gta2/homepage.html"
SRC_URI="https://archive.org/download/pc_gta2/GTA2_full.zip"

LICENSE="Rockstar_freeware_GTA2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+abi_x86_32"

BDEPEND+="
	app-arch/unzip
	media-gfx/icoutils
	media-gfx/imagemagick
"

RDEPEND+="
	app-emulation/winetricks
	app-shells/bash:0
"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	unzip -jd . "${DISTDIR}"/GTA2_full.zip GTA2/GTA2.exe
	RESPONSE_FILE=$(windowshelper_convert_normal_path_to_windows_path "${FILESDIR}/gta2.iss")
	runwine_prepare_for_wine_run
	wine GTA2.exe /s /f1"${RESPONSE_FILE}" /f2"C:\iss.log"
	INSTALL_PATH="${WINEPREFIX}/drive_c/Program Files/Rockstar Games/gta2"
	wrestool -x -t14 -n 128 -o . "${INSTALL_PATH}/gta2 manager.exe" || die
	wrestool -x -t14 -o . "${INSTALL_PATH}/gta2.exe" || die
	convert 'gta2 manager.exe_14_128_2057.ico' gta2_manager.png
	convert 'gta2.exe_14_101_2057.ico' gta2.png
}

src_install() {
	insinto /usr/share/games
	doins -r "${INSTALL_PATH}"
	insinto /usr/share/pixmaps
	doins gta2_manager.png
	doins gta2.png
	insinto /usr/share/applications
	doins "${FILESDIR}/gta2.desktop"
	doins "${FILESDIR}/gta2_manager.desktop"
	dobin "${FILESDIR}/gta2"
	dobin "${FILESDIR}/gta2_manager"
}
