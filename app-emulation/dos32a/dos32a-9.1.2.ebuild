# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Free replacement for DOS4GW."
HOMEPAGE="https://dos32a.narechk.net/content/main.html"

LICENSE="Apache-1.1-sans-Apache"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

#SRC_URI="http://download.narechk.net/dos32a-912-bin.zip http://download.narechk.net/dos32a-912-src.zip"
SRC_URI="http://download.narechk.net/dos32a-912-bin.zip"

IUSE="+binary"

BDEPEND="
	app-arch/unzip
"

RDEPEND=""

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	if ! use binary; then
		die "Building DOS32A from source is not yet supported. Come back when we have an adequate DOS toolchain."
	else
		unzip -jd . "${DISTDIR}"/dos32a-912-bin.zip binw/*
	fi
}

src_install() {
	insinto /usr/share/dos32a
	doins *.exe
}
