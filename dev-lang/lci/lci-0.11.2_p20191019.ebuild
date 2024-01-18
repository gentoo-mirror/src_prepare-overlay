# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit cmake python-any-r1

DESCRIPTION="LOLCODE interpreter written in C"
HOMEPAGE="http://www.lolcode.org/"
COMMIT="58ed46a5b20a628f9da07088466acc45cda291cc"
SRC_URI="https://github.com/justinmeza/lci/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/lci-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc test"
RESTRICT="!test? ( test )"

DEPEND="test? ( ${PYTHON_DEPS} )"
BDEPEND="
	doc? (
		app-text/doxygen
	)
"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_compile() {
	cmake_src_compile
	if use doc; then
		HTML_DOCS="${BUILD_DIR}/html"
		cmake_src_compile docs
	fi
}

src_install() {
	cmake_src_install
	einstalldocs
}
