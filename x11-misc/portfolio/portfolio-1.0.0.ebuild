# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

inherit gnome2-utils meson python-single-r1 virtualx xdg

DESCRIPTION="Minimalist file manager for those who want to use Linux mobile devices"
HOMEPAGE="https://github.com/tchx84/Portfolio"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tchx84/Portfolio.git"
else
	SRC_URI="https://github.com/tchx84/Portfolio/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${P^}"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/gobject-introspection
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
"
DEPEND="
	${RDEPEND}
	test? (
		$(python_gen_cond_dep '
			dev-python/pytest[${PYTHON_USEDEP}]
		')
	)
"
BDEPEND="sys-devel/gettext"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply_user

	# Don't validate data files even if found.
	sed -Ei \
		-e 's/^((appstream_util|desktop_utils|compile_schemas) =).*$/\1 disabler()/' \
		data/meson.build || die

	# Don't enable linting tests even if found.
	sed -Ei \
		-e 's/^((pyflakes|black) =).*$/\1 disabler()/' \
		tests/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_use test run_service_tests)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize
	python_fix_shebang "${D}"/usr/bin/dev.tchx84.Portfolio
}

src_test() {
	virtx meson_src_test
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
