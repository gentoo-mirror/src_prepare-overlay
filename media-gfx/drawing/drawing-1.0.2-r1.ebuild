# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="A drawing application for the GNOME desktop"
HOMEPAGE="https://github.com/maoschanz/drawing"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/maoschanz/drawing.git"
else
	SRC_URI="https://github.com/maoschanz/drawing/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# tests are not useful
RESTRICT="test"

DEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	x11-libs/gtk+:3
	$(python_gen_cond_dep '
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-libs/appstream-glib
	dev-util/itstool
	sys-devel/gettext
"

src_configure() {
	local emesonargs=(
		-Denable-translations-and-appdata=true
		-Duse-uuid-as-binary-name=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	einstalldocs
	python_fix_shebang -f "${D}"
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
