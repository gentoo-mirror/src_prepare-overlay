# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="TETR.IO desktop client"
HOMEPAGE="https://tetr.io/"
SRC_URI="https://tetr.io/about/desktop/builds/TETR.IO%20Setup.tar.gz"

LICENSE="non-free"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "../../opt/${PN}/tetrio-desktop" "/usr/bin/tetrio-desktop"
	make_desktop_entry "tetrio-desktop" "TETR.IO Desktop" "" "Game;ArcadeGame"
	fperms +x "/opt/${PN}/tetrio-desktop"
	insinto "/usr/share/licenses/${PN}"
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

