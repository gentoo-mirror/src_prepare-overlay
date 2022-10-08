# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="A drawing application for the GNOME desktop"
HOMEPAGE="https://github.com/maoschanz/drawing"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/maoschanz/${PN}.git"
else
	SRC_URI="https://github.com/maoschanz/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

IUSE="doc"

LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# tests are not useful
RESTRICT="test"

DEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	dev-python/pygobject[cairo]
	x11-libs/gtk+:3
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	doc? (
		dev-util/itstool
		sys-devel/gettext
	)
"

src_configure() {
	local emesonargs=(
		$(meson_use doc enable-translation-and-appdate)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_pkg_preinst
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
