# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 eutils xdg-utils

DESCRIPTION="A GUI front-end for youtube-dl"
HOMEPAGE="https://tartube.sourceforge.io"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/axcore/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/axcore/${PN}/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="+atomicparsley"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
"
RDEPEND="
	${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	net-misc/youtube-dl
	x11-libs/gtk+:3
	atomicparsley? ( media-video/atomicparsley )
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
