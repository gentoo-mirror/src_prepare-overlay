# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit python-single-r1 gnome2-utils meson xdg

DESCRIPTION="Minimalist file manager for those who want to use Linux mobile devices"
HOMEPAGE="https://github.com/tchx84/Portfolio"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tchx84/${PN^}.git"
else
	SRC_URI="https://github.com/tchx84/${PN^}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN^}-${PV}"
fi

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="GPL-3"
SLOT="0"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/appstream-glib[introspection]
	x11-libs/gtk+:3[introspection]
	$(python_gen_cond_dep '
		dev-python/pycairo[${PYTHON_MULTI_USEDEP}]
		dev-python/pygobject:3[${PYTHON_MULTI_USEDEP}]
	')
	test? (
		dev-python/black
		dev-python/pyflakes
		dev-python/pytest
	)
"
DEPEND="
	${RDEPEND}
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	meson_src_install
	python_optimize

	echo "#!/usr/bin/${EPYTHON}
	$(cat ${D}/usr/bin/dev.tchx84.Portfolio)" > "${D}/usr/bin/dev.tchx84.Portfolio" || die
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
