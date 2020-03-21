# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="A simple downloader written in Python with an awesome progressbar"
HOMEPAGE="https://github.com/deepjyoti30/downloader-cli"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/deepjyoti30/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/deepjyoti30/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	>=dev-python/urllib3-1.25.7[${PYTHON_USEDEP}]
"
