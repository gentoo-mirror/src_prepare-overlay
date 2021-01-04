# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Simple, modern file watching and code reload in python."
HOMEPAGE="https://github.com/samuelcolvin/watchgod"
SRC_URI="https://github.com/samuelcolvin/watchgod/archive/v"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
