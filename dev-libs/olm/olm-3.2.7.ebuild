# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
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
IUSE="python test"
REQUIRED_USE="doc? ( python )"

DEPEND="
	python? (
		>=dev-python/cffi-1.0.0[${PYTHON_USEDEP}]
		dev-python/future[${PYTHON_USEDEP}]
		test? (
			dev-python/aspectlib[${PYTHON_USEDEP}]
			dev-python/pytest-benchmark[${PYTHON_USEDEP}]
			dev-python/pytest-cov[${PYTHON_USEDEP}]
			dev-python/pytest-flake8[${PYTHON_USEDEP}]
			dev-python/pytest-isort[${PYTHON_USEDEP}]
		)
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx "${S}"/python/docs

DOCS=( "${S}/docs/" )

src_prepare() {
	cmake_src_prepare
	if use python; then
		pushd python || die
		distutils-r1_src_prepare
		popd || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DOLM_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
	if use python; then
		pushd python || die
		distutils-r1_src_configure
		popd || die
	fi
}

src_compile() {
	cmake_src_compile
	if use python; then
		pushd python || die
		# Let python build find the already built libolm
		export LIBRARY_PATH="${BUILD_DIR}/"
		distutils-r1_src_compile
		popd || die
	fi
}

src_install() {
	cmake_src_install
	if use python; then
		pushd python || die
		distutils-r1_src_install
		popd || die
	fi
	einstalldocs
}

src_test() {
	emake test
	if use python; then
		pushd python || die
		LD_LIBRARY_PATH="${BUILD_DIR}:${LD_LIBRARY_PATH}" distutils-r1_src_test
		popd || die
	fi
}
