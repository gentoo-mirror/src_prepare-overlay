# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

# no tests
RESTRICT="test"
LICENSE="AGPL-3"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:=
	dev-libs/json-glib
	>=gui-libs/libhandy-0.91.0:1
	net-libs/libsoup:2.4
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
"

pkg_setup() {
	vala_setup
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_savelist
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_savelist
}
