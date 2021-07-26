# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN//-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Universal markup converter"
HOMEPAGE="https://pandoc.org"

BASE_URI="https://github.com/jgm/${MY_PN}/releases/download"

SRC_URI="amd64? ( ${BASE_URI}/${PV}/${MY_P}-linux-amd64.tar.gz )
	arm64? ( ${BASE_URI}/${PV}/${MY_P}-linux-arm64.tar.gz )"
	#https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-arm64.tar.gz

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
"

src_unpack() {
	default

	# manpages are gzipped
	find . -name "*.gz" | xargs gunzip
}

src_install() {
	cd "${S}/bin" || die
	dobin "${MY_PN}"

	cd "${S}/share/man/man1" || die
	doman "${MY_PN}.1"
}
