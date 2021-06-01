# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="Speed up Python's shutil.copyfile by using sendfile system call"
HOMEPAGE="https://github.com/desbma/pyfastcopy"
SRC_URI="https://github.com/desbma/pyfastcopy/archive/"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64"
