# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="POSIX IPC primitives for Python"
HOMEPAGE="http://semanchuk.com/philip/posix_ipc/"
SRC_URI="http://semanchuk.com/philip/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror test"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}"
