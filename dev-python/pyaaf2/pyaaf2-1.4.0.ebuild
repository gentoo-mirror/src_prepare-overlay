# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6..9})

inherit distutils-r1

DESCRIPTION="Read and write Advanced Authoring Format (AAF) files"
HOMEPAGE="http://pyaaf.readthedocs.io/"
SRC_URI="https://github.com/markreidvfx/pyaaf2/archive/v"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
