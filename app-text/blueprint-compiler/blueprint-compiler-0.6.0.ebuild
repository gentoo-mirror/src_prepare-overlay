# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit meson python-single-r1

DESCRIPTION="A markup language for GTK user interface files."
HOMEPAGE="https://gitlab.gnome.org/jwestman/blueprint-compiler"
SRC_URI="https://gitlab.gnome.org/jwestman/blueprint-compiler/-/archive/v${PV}/blueprint-compiler-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		gui-libs/gtk:4
	)
"

src_configure() {
	local emesonargs=(
		$(meson_use doc docs)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize
}
