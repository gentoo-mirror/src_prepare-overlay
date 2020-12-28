# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit gnome2-utils meson python-single-r1 xdg-utils

DESCRIPTION="A minimal terminal for GNOME"
HOMEPAGE="https://gitlab.gnome.org/ZanderBrown/kgx"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/ZanderBrown/${PN}.git"
else
	SRC_URI="https://gitlab.gnome.org/ZanderBrown/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="
	!test? ( test )
	mirror
"
LICENSE="GPL-3"
SLOT="0"
IUSE="doc generic +gtop test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.58.0
	>=dev-libs/libpcre2-10.32
	>=x11-libs/vte-0.54.4
	dev-libs/appstream-glib[introspection]
	dev-util/desktop-file-utils
	dev-util/meson
	gnome-base/gsettings-desktop-schemas
	gui-libs/libhandy:0.0
	x11-libs/gtk+:3
	gtop? (
		>=gnome-base/libgtop-2.38.0
	)
"
RDEPEND="
	${DEPEND}
"

src_configure() {
	local emesonargs=(
		-Dgeneric=$(usex generic true false)
		-Dgir=false
		-Dgtk_doc=$(usex doc true false)
		-Dgtk_doc=false
		-Dgtop=$(usex gtop true false)
		-Dtests=$(usex test true false)
		-Dvapi=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${ED}"/usr/share/appdata
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_environment_reset
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
