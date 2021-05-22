# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="An aspect-oriented programming, monkey-patch and decorators library."
HOMEPAGE="https://github.com/ionelmc/python-aspectlib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/fields[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/sphinx-py3doc-enhanced-theme[${PYTHON_USEDEP}]
	test? (
		  ${RDEPEND}
		  dev-python/process-tests[${PYTHON_USEDEP}]
		  www-servers/tornado[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	dev-python/sphinx
"

distutils_enable_tests pytest

PATCHES=( "${FILESDIR}/Remove-tornado-6-test-constraint.patch" )

python_compile_all() {
	if use doc; then
		sphinx-build -b html docs docs/_build/html || die
	fi
	sphinx-build -b man docs docs/_build/man || die
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	doman docs/_build/man/*
	distutils-r1_python_install_all
}
