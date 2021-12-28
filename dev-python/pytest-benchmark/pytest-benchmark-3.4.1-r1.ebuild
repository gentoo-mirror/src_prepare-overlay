# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1 multiprocessing

DESCRIPTION="py.test fixture for benchmarking code"
HOMEPAGE="https://github.com/ionelmc/pytest-benchmark"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/aspectlib[${PYTHON_USEDEP}]
	dev-python/elasticsearch-py[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
	dev-python/pygal[${PYTHON_USEDEP}]
	dev-python/pygaljs[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		${RDEPEND}
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests --install pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme

PATCHES=( "${FILESDIR}/python3_10_test.patch" )

# Test success is affected by terminal width
EPYTEST_DESELECT=( tests/test_cli.py::test_help tests/test_cli.py::test_help_compare )

python_test() {
	epytest -n "$(makeopts_jobs "${MAKEOPTS}" "$(get_nproc)")"
}
