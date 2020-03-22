# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1

DESCRIPTION="A simple app to get songs from youtube in mp3 format"
HOMEPAGE="https://github.com/deepjyoti30/ytmdl"

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

src_prepare() {
	# Excerpt from https://pypi.org/project/bs4
	# "The official name of PyPI’s Beautiful Soup Python package is beautifulsoup4.
	#  This package ensures that if you type pip install bs4 by mistake you will end up with Beautiful Soup."
	# ;-)
	sed -i 's/bs4/beautifulsoup4/' setup.py
	distutils-r1_src_prepare
}

RDEPEND="
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/ffmpeg-python[${PYTHON_USEDEP}]
	dev-python/itunespy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	net-misc/downloader-cli[${PYTHON_USEDEP}]
	net-misc/youtube-dl[${PYTHON_USEDEP}]
"
