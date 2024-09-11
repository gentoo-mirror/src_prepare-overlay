# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A mod that makes Quake faster paced, harder, gorier and more violent."
HOMEPAGE="https://www.moddb.com/mods/quake-15"
SRC_URI="
	https://www.moddb.com/downloads/mirror/173517/114/5090a373c5249e55e509808983481a04 -> Q15_PublicBeta1.7z
	https://www.moddb.com/downloads/mirror/173707/114/f7627345043efdfcd9e27d4906a382ac -> Q15_patch2.7z
"
S="${WORKDIR}"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

RDEPEND=">=games-fps/darkplaces-20170829_beta1"
DEPEND="app-arch/p7zip"

src_install() {
	insinto "/usr/share/quake1"
	doins -r quake15
}

pkg_postinst() {
	echo
	elog "In order to play this mod run Quake with -game option:"
	elog "    darkplaces -game quake15"
	echo
}
