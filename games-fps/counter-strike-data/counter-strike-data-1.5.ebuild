# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit wise

DESCRIPTION="Freeware release of Counter-Strike 1.5"
HOMEPAGE="https://web.archive.org/web/20031231214931/http://www.counter-strike.net/"
WISE_INSTALLER="csv15full.exe"
SRC_URI+="
	https://archive.org/download/counter-strike-1.5/${WISE_INSTALLER}
"

LICENSE="UNKNOWN"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

RDEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_unpack() {
	wise_unpack_installers
}

src_install() {
	insinto "/usr/share"
	doins -r wise_output/cstrike
}

pkg_postinst() {
	echo
	elog "In order to play this mod run FreeCS"
	echo
}
