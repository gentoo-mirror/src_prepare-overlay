# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Full Syntax Tree for python to make writing refactoring code a realist task"
HOMEPAGE="http://baron.pycqa.org"
SRC_URI="https://github.com/PyCQA/baron/archive/"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/rply[${PYTHON_USEDEP}]"
