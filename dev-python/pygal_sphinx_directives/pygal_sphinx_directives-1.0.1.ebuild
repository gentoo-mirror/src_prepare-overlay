# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Pygal sphinx integration"
HOMEPAGE="https://pypi.org/project/pygal_sphinx_directives/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
# There are no tests
RESTRICT="test"

# 1.7.2021: 3.10 blocked by pygal
RDEPEND="
	dev-python/pygal[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"
