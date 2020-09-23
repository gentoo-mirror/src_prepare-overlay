# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{6..9})
inherit distutils-r1

DESCRIPTION="Plyer is a platform-independent Python wrapper for platform-dependent APIs"
HOMEPAGE="https://github.com/kivy/plyer"
SRC_URI="https://github.com/kivy/plyer/archive/"${PV}".tar.gz -> "${PF}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
