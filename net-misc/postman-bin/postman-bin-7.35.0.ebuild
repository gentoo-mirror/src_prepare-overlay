# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Supercharge your API workflow"
HOMEPAGE="https://www.postman.com"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}-amd64.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

S="${WORKDIR}/${MY_PN^}/app"

src_install() {
	mkdir -p "${ED%/}/opt/${MY_PN}"
	cp -r . "${ED%/}/opt/${MY_PN}"
	newicon -s 128 resources/app/assets/icon.png ${MY_PN}.png
	dobin "${FILESDIR}/${MY_PN}"
	make_desktop_entry "postman" \
		"Postman" \
		"postman" \
		"Development;IDE;"
	pax-mark m "${ED%/}/opt/${MY_PN}/${MY_PN^}"
}
