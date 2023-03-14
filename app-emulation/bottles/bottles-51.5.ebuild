# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# todo patool, icoextract
PYTHON_COMPAT=( python3_{9..10} )
inherit gnome2-utils python-single-r1 meson xdg optfeature

DESCRIPTION="Run Windows software and games on Linux"
HOMEPAGE="https://usebottles.com/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bottlesdevs/Bottles/"
else
	SRC_URI="https://github.com/bottlesdevs/Bottles/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/Bottles-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# tests are quite pointless as they check static files and releases are tagged with them still failing
RESTRICT="test"

# Very annoying to figure out the deps
# Script for getting python modules:
#   https://gitlab.com/Parona/my-scripts/-/blob/master/scripts/python_deps.sh
# Runtime programs needed can be quickly found with:
#   grep -r "shutil.which"
# But look at context to gauge if they are optional or not
#
# BDPEPEND dependencies can be thankfully gathered from the meson.build files
# DEPEND are instrospection files which can be found as such
#   find . -name "*.blp" -exec grep -Eh "^using " {} + | sed 's/using \([A-Za-z]*\) \([0-9.]*\);/\1-\2.typelib/'
# And in similar vein find runtime required introspection files, similar deal with getting typelib file as above
#   grep -r "gi.require_version

# vkbasalt could be optional but vkbasalt-cli isnt
# It could work without wine but(!) it still requires all the runtime dependencies for wine
# so easier to depend on wine to get it for free

DEPEND="
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita[introspection]
"
RDEPEND="
	${PYTHON_DEPS}
	${DEPEND}
	app-arch/cabextract
	app-arch/p7zip
	gui-libs/gtksourceview[introspection]
	media-gfx/imagemagick
	>=sys-libs/glibc-2.32
	virtual/wine
	x11-apps/xdpyinfo
	$(python_gen_cond_dep '
		app-arch/patool[${PYTHON_USEDEP}]
		dev-python/FVS[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/icoextract[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/pathvalidate[${PYTHON_USEDEP}]
		dev-python/pefile[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/vkbasalt-cli[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	${PYTHON_DEPS}
	dev-util/blueprint-compiler
	dev-libs/glib:2
	sys-devel/gettext
	test? (
		dev-libs/appstream
		dev-libs/glib
		dev-util/desktop-file-utils
	)
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	if  [[ "${PV}" == "9999" ]]; then
		local emesonargs=(
			-Ddevel=true
		)
	fi
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize "${D}/usr/share/bottles/"
	python_fix_shebang "${D}/usr/"
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	optfeature "gamemode support" games-util/gamemode
	optfeature "gamescope support" games-util/gamescope
	optfeature "vmtouch support" dev-utils/vmtouch
	#optfeature "MangoHub support" games-util/mangohub
	#optfeature "obs-vkcapture support" media-video/obs-vkcapture
}
