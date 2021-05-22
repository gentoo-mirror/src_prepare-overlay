# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..8} )
inherit distutils-r1

DESCRIPTION="A list-like type"
HOMEPAGE="https://github.com/DanielStutzbach/blist http://stutzbachenterprises.com/blist/"
SRC_URI="https://github.com/DanielStutzbach/blist/archive/v"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
