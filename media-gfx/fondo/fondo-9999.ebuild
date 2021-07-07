# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg

DESCRIPTION="Wallpaper App for Linux "
HOMEPAGE="https://github.com/calo001/fondo"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/calo001/${PN}.git"
else
	SRC_URI="https://github.com/calo001/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="AGPL-3"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-libs/granite
	x11-libs/gtk+:3
	net-libs/libsoup
	dev-libs/json-glib
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	xdg_environment_reset
	vala_src_prepare
	default
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
