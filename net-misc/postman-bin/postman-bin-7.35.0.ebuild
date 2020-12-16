# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"

inherit desktop pax-utils xdg

DESCRIPTION="Supercharge your API workflow"
HOMEPAGE="https://www.postman.com"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}-amd64.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip test"

S="${WORKDIR}/${MY_PN^}/app"

src_install() {
	mkdir -p "${ED%}/opt/${MY_PN}" || die
	cp -r . "${ED%}/opt/${MY_PN}" || die

	newicon -s 128 "resources/app/assets/icon.png" "${MY_PN}.png"
	dosym "../../opt/${MY_PN}/${MY_PN^}" "/usr/bin/${MY_PN}"
	make_desktop_entry "${MY_PN}" "${MY_PN^}" "${MY_PN}" "Development;IDE;"

	pax-mark m "${ED%}/opt/${MY_PN}/${MY_PN^}"
}
