# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN//-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Universal markup converter"
HOMEPAGE="https://pandoc.org"
SRC_URI="https://github.com/jgm/${MY_PN}/releases/download/${PV}/${MY_P}-linux-amd64.tar.gz"

RESTRICT="mirror bindist"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	!app-text/${MY_PN}
"

S="${WORKDIR}/${MY_P}"

QA_PRESTRIPPED="
	usr/bin/${MY_PN}
	usr/bin/${MY_PN}-citeproc
"

src_unpack() {
	default

	# manpages are gzipped
	find . -name "*.gz" | xargs gunzip
}

src_install() {
	cd "${S}/bin" || die
	dobin "${MY_PN}"
	dobin "${MY_PN}-citeproc"

	cd "${S}/share/man/man1" || die
	doman "${MY_PN}.1"
	doman "${MY_PN}-citeproc.1"
}
