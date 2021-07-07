# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="TETR.IO desktop client"
HOMEPAGE="https://tetr.io/"
SRC_URI="https://tetr.io/about/desktop/builds/TETR.IO%20Setup.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "../../opt/${PN}/tetrio-desktop" "/usr/bin/tetrio-desktop"
	make_desktop_entry "tetrio-desktop" "TETR.IO Desktop" "" "Game;ArcadeGame"
	fperms +x "/opt/${PN}/tetrio-desktop"
	insinto "/usr/share/licenses/${PN}"
}
