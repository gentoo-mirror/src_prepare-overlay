# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

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

DEPEND="
	~dev-libs/olm-${PV}[-python(-)]
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

PATCHES=(
	"${FILESDIR}"/python-olm-3.2.15-move-metadata-to-pyproject.patch
)

src_prepare() {
	pushd "${WORKDIR}/olm-${PV}" > /dev/null || die
	eapply "${PATCHES[@]}"
	eapply_user
	popd > /dev/null || die
}
