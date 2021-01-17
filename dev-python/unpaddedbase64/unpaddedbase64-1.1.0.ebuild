# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Encode and decode Base64 without "=" padding."
HOMEPAGE="https://github.com/matrix-org/python-unpaddedbase64"
SRC_URI="https://github.com/matrix-org/python-unpaddedbase64/archive/v"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S=""${WORKDIR}"/python-"${PF}""
