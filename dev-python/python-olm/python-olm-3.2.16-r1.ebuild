# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="python CFFI bindings for the olm cryptographic ratchet library"
HOMEPAGE="
	https://gitlab.matrix.org/matrix-org/olm
	https://pypi.org/project/python-olm/
"
SRC_URI="https://gitlab.matrix.org/matrix-org/olm/-/archive/${PV}/olm-${PV}.tar.bz2"
S="${WORKDIR}/olm-${PV}/python/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# special case where only python bindings were modified
DEPEND="
	|| (
		~dev-libs/olm-${PV}
		~dev-libs/olm-3.2.15[-python(-)]
	)
	dev-python/cffi[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# deselect tests using benchmark fixtures
	"tests/group_session_test.py::TestClass::test_encrypt"
	"tests/group_session_test.py::TestClass::test_decrypt"
)

src_prepare() {
	pushd "${WORKDIR}/olm-${PV}" > /dev/null || die
	if [[ ${#PATCHES} > 0 ]]; then
		eapply "${PATCHES[@]}"
	fi
	eapply_user
	popd > /dev/null || die
}
