# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 xdg-utils

DESCRIPTION="A screencast tool to display your keys inspired by Screenflick"
HOMEPAGE="https://www.thregr.org/~wavexx/software/screenkey/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/screenkey/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://www.thregr.org/~wavexx/software/${PN}/releases/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3+"
SLOT="0"
IUSE=""

BDEPEND="
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-python/setuptools-git[${PYTHON_USEDEP}]
"
RDEPEND="
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	sys-devel/gettext
"

src_prepare() {
	xdg_environment_reset
	default
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
