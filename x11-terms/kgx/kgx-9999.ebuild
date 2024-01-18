# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

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
IUSE="doc generic test"

DEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.58.0
	>=dev-libs/libpcre2-10.32
	>=gnome-base/libgtop-2.38.0
	>=x11-libs/vte-0.54.4
	dev-libs/appstream-glib[introspection]
	dev-util/desktop-file-utils
	gnome-base/gsettings-desktop-schemas
	gui-libs/libhandy:1
	x11-libs/gtk+:3
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
		-Dtests=$(usex test true false)
		-Dvapi=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${ED}/usr/share/appdata" || die
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_environment_reset
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_pkg_postrm
}
