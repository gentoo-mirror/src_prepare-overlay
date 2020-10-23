# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="Modern IRC client written in GTK"
HOMEPAGE="https://srain.im/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/SrainApp/${PN}.git"
else
	SRC_URI="https://github.com/SrainApp/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

RDEPEND="
	>=dev-libs/glib-2.38:2
	>=x11-libs/gtk+-3.20.0:3
	net-libs/glib-networking
	app-crypt/libsecret
	net-libs/libsoup
	x11-libs/libnotify
"
DEPEND="
	${RDEPEND}
	>=sys-devel/gettext-0.19.8
	dev-libs/libconfig
"

DOCS=(
	README.rst
)

src_prepare() {
	default
	xdg_environment_reset
}

src_configure(){
	local myconf=(
		$(use_enable debug)
	)
	econf "${myconf[@]}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
