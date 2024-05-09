# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Free replacement for DOS4GW."
HOMEPAGE="https://web.archive.org/web/20210726190857/https://dos32a.narechk.net/index_en.html"
SRC_URI="
	https://github.com/grepwood/${PN}/releases/download/${P//.}/${P//.}-bin.zip
"
S=${WORKDIR}
LICENSE="Apache-1.1-sans-Apache"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

BDEPEND="
	app-arch/unzip
"
src_unpack() {
	unzip -jd . "${DISTDIR}"/dos32a-912-bin.zip binw/*
}

src_install() {
	insinto /usr/share/dos32a
	doins *.exe
}
