# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="A simple audio playback Python extension"
HOMEPAGE="https://github.com/hamiltron/py-simple-audio"
SRC_URI="https://github.com/hamiltron/py-simple-audio/archive/"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S=""${WORKDIR}"/py-simple-audio-"${PV}""
