# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A simple app to get songs from youtube in mp3 format"
HOMEPAGE="https://github.com/deepjyoti30/ytmdl"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/deepjyoti30/${PN}.git"
else
	SRC_URI="https://github.com/deepjyoti30/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/ffmpeg-python[${PYTHON_USEDEP}]
	dev-python/itunespy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pycountry[${PYTHON_USEDEP}]
	dev-python/pydes[${PYTHON_USEDEP}]
	dev-python/python-musicbrainz-ngs[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/simber[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/youtube-search[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	net-misc/downloader-cli[${PYTHON_USEDEP}]
	net-misc/youtube-dl[${PYTHON_USEDEP}]
"

src_prepare() {
	# https://pypi.org/project/bs4
	sed -i 's/bs4/beautifulsoup4/' setup.py

	distutils-r1_src_prepare
}
