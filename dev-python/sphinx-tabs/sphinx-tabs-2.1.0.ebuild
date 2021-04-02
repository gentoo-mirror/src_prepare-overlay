# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Tabbed views for Sphinx"
HOMEPAGE="https://sphinx-tabs.readthedocs.io"
SRC_URI="https://github.com/executablebooks/sphinx-tabs/archive/refs/tags/v"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/sphinx-2.0.0
	dev-python/pygments
"
