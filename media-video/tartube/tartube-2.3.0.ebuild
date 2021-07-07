# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit xdg distutils-r1

DESCRIPTION="A GUI front-end for youtube-dl"
HOMEPAGE="https://tartube.sourceforge.io"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/axcore/${PN}.git"
else
	SRC_URI="https://github.com/axcore/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="+atomicparsley +ffmpeg"

RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	net-misc/youtube-dl
	x11-themes/adwaita-icon-theme
	atomicparsley? (
		media-video/atomicparsley
	)
	ffmpeg? (
		media-video/ffmpeg
	)
"

DOCS=(
	AUTHORS
	CHANGES
	README.rst
)

src_prepare() {
	export TARTUBE_PKG_STRICT=1

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update

	elog "You may need to set path to (system) youtube-dl"
	elog "in Tartube's System preferences"
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
