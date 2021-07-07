# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils vala xdg meson

DESCRIPTION="Native Linux App for UI and UX Design built in Vala and Gtk "
HOMEPAGE="https://github.com/akiraux/akira"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/akiraux/${PN}.git"
else
	SRC_URI="https://github.com/akiraux/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${P^}"
fi

RESTRICT="mirror test"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	>=dev-libs/granite-5.3.0
	app-arch/libarchive
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libgee
	dev-libs/libxml2
	sys-devel/gettext
	x11-libs/goocanvas:2.0
	x11-libs/gtksourceview:4
"
RDEPEND="${DEPEND}"

src_prepare() {
	xdg_environment_reset
	vala_src_prepare
	default
}

src_install() {
	meson_src_install
	dosym "${EPREFIX}/usr/bin/com.github.akiraux.akira" "${EPREFIX}/usr/bin/akira"
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
