# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="A simple library to fetch data from the iTunes Store API"
HOMEPAGE="https://github.com/sleepyfran/itunespy"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sleepyfran/${PN}.git"
else
	SRC_URI="https://github.com/sleepyfran/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"
