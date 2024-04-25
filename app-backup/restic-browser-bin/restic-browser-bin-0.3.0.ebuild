# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN="${PN/-bin/}"
COMMIT="39cb5d785a56395f083ff468beaeba4290e7f800"
ICON="${PN}_icon_${COMMIT}.png"

DESCRIPTION="A GUI to browse and restore restic backup repositories"
HOMEPAGE="https://github.com/emuell/restic-browser"
SRC_URI="
	https://github.com/emuell/${MY_PN}/releases/download/v${PV}/${MY_PN}-v${PV}-linux.zip ->  ${P}.zip
	https://raw.githubusercontent.com/emuell/${MY_PN}/${COMMIT}/src-tauri/icons/icon.png -> ${ICON}
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-backup/restic
	net-libs/webkit-gtk:4
"
BDEPEND="app-arch/unzip"

QA_PREBUILT="*"

src_unpack() {
	unpack "${P}.zip"
	unpack "${WORKDIR}/${MY_PN}.tar"
}

src_install() {
	dobin "${MY_PN}"
	newicon "${DISTDIR}/${ICON}" "${MY_PN}"
	make_desktop_entry "${MY_PN}" Restic-Browser "${MY_PN}"
}
