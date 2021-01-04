# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="FST for python to make writing refactoring code a realistic task"
HOMEPAGE="http://redbaron.pycqa.org"
SRC_URI="https://github.com/PyCQA/redbaron/archive/"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/baron[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
"
