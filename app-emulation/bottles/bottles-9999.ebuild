# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit python-single-r1 meson gnome2-utils xdg

DESCRIPTION="Easily manage WINE prefixes in a new way"
HOMEPAGE="
	https://usebottles.com/
	https://github.com/bottlesdevs/Bottles
"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bottlesdevs/${PN^}.git"
else
	SRC_URI="https://github.com/bottlesdevs/${PN^}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${P^}"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	>=x11-libs/gtk+-3.24.10[introspection]
	dev-libs/appstream-glib[introspection]
	dev-util/desktop-file-utils
	$(python_gen_cond_dep '
		dev-python/pycairo[${PYTHON_MULTI_USEDEP}]
		dev-python/pygobject:3[${PYTHON_MULTI_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	meson_src_install
	python_optimize

	# TODO: find a better way to fix the python script
	echo "#!/usr/bin/${EPYTHON}
	$(cat ${D}/usr/bin/${PN})" > "${D}/usr/bin/${PN}"
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
