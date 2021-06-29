# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# 29.6.2021: 3.10 blocked by aiohttps and pbr
PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Aioresponses is a helper for mock/fake web requests in python aiohttp package. "
HOMEPAGE="https://github.com/pnuckowski/aioresponses"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

# All tests require internet access
PROPERTIES="test_network"
RESTRICT="
	test
	!test? ( test )
"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		  ${RDEPEND}
		  dev-python/ddt[${PYTHON_USEDEP}]
		  dev-python/pytest-cov[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	dev-python/pbr[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )
"

distutils_enable_tests pytest

python_compile_all() {
	use doc && emake -C docs -j1 html
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
