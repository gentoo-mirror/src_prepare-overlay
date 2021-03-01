# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_OPTIONAL=1

inherit cmake distutils-r1

DESCRIPTION="An implementation of the Double Ratchet cryptographic ratchet in C++"
HOMEPAGE="https://git.matrix.org/git/olm/about/"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.matrix.org/matrix-org/${PN}.git"
else
	SRC_URI="https://gitlab.matrix.org/matrix-org/${PN}/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0/$(ver_cut 1)"
IUSE="python"

DEPEND="
	python? (
		dev-python/cffi[${PYTHON_USEDEP}]
		dev-python/future[${PYTHON_USEDEP}]
	)
"

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	cmake_src_prepare
	use python && (cd python; distutils-r1_src_prepare)
}

src_configure() {
	local mycmakeargs=(
		-DOLM_TESTS=OFF
		-DBUILD_SHARED_LIBS=ON
	)
	cmake_src_configure
	use python && (cd python; distutils-r1_src_configure)
}

src_compile() {
	cmake_src_compile
	export LIBRARY_PATH="${S}/$(get_libdir)/" # Let python build find the already built libolm
	use python && (cd python; distutils-r1_src_compile)
}

src_install() {
	cmake_src_install
	use python && (cd python; distutils-r1_src_install)
}

src_test(){
	emake test
}
