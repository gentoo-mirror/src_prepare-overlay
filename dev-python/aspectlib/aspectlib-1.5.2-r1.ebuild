# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1 pypi

DESCRIPTION="An aspect-oriented programming, monkey-patch and decorators library."
HOMEPAGE="https://github.com/ionelmc/python-aspectlib"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/fields[${PYTHON_USEDEP}]"
DEPEND="
	doc? (
		dev-python/sphinx-py3doc-enhanced-theme[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs

PATCHES=(
	"${FILESDIR}/Fix-tests-for-python3_10-and-above.patch"
	"${FILESDIR}/Remove-tornado-6-test-constraint.patch"
)
