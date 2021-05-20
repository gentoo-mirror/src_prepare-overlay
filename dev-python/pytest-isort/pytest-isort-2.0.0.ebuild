# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="py.test plugin to check import ordering using isort"
HOMEPAGE="https://github.com/stephrdev/pytest-isort"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/isort[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		  ${RDEPEND}
	)
"

distutils_enable_tests pytest

DOCS=( "README.rst" )
