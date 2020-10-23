# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN^}"

inherit desktop xdg

DESCRIPTION="A sandbox tower defense game"
HOMEPAGE="https://mindustrygame.github.io"
SRC_URI="https://github.com/Anuken/${MY_PN}/releases/download/v${PV}/${MY_PN}.jar -> ${P}.jar"

RESTRICT="mirror strip"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	>=virtual/jdk-1.7:*
"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}.jar" "${S}/${MY_PN}.jar" || die
}

# src_prepare() {
# 	cp "${P}.jar" "${MY_PN}.jar"
# }

src_install() {
	insinto "/opt/${MY_PN}"
	doins "${MY_PN}.jar"

	make_wrapper "${PN}" "java -jar /opt/${MY_PN}/${MY_PN}.jar"
	make_desktop_entry "${PN}" "${MY_PN}" "${PN}" "Game;StrategyGame;"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
