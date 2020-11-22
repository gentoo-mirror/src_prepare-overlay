# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools wrapper

DESCRIPTION="Open-source Chez Scheme implementation from Cisco"
HOMEPAGE="https://cisco.github.io/ChezScheme/"
SRC_URI="https://github.com/cisco/ChezScheme/releases/download/v${PV}/csv${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror test"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="threads"

PATCHES=(
	"${FILESDIR}"/chezscheme-tinfo.patch
)

S="${WORKDIR}"/"csv${PV}"

src_configure() {
	local myconf=(
		$(usex threads '--threads' '')
		--installbin=/usr/bin
		--installlib=/usr/lib64
		--installman=/usr/share/man
		--installprefix=/usr
		--temproot="${D}"
	)
	sh ./configure "${myconf[@]}"
}

src_install() {
	default

	make_wrapper "chez" "${EPREFIX}/usr/bin/scheme"
	make_wrapper "${PN}" "${EPREFIX}/usr/bin/scheme"
}
