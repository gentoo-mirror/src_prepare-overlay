# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The X Binary Package System"
HOMEPAGE="https://voidlinux.org/xbps"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/void-linux/xbps.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/void-linux/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="!test? ( test ) mirror"
LICENSE="BSD"
SLOT="0"
IUSE="debug doc lto static test"

COMMON_DEPEND="
	>=app-arch/libarchive-3.3.3[lz4,zstd]
"
BDEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig
	doc? (
		 app-doc/doxygen
		 media-gfx/graphviz
	)
"
DEPEND="
	sys-libs/zlib
	test? (
		>=dev-libs/atf-0.15
	)
"
RDEPEND="
	${COMMON_DEPEND}
"

src_configure() {
	local myconf=(
		$(use_enable debug fulldebug)
		$(use_enable doc api-docs)
		$(use_enable lto)
		$(use_enable static)
		$(use_enable test tests)
	)
	econf "${myconf[@]}"
}

pkg_postinst() {
	elog "WARNING! Use with caution!"
	elog "XBPS may break your system."
}
