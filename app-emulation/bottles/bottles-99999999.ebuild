# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit optfeature gnome2-utils python-single-r1 meson xdg

DESCRIPTION="Easily manage WINE prefixes in a new way"
HOMEPAGE="
	https://usebottles.com/
	https://github.com/bottlesdevs/Bottles
"

LICENSE="GPL-3+"
SLOT="0"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bottlesdevs/${PN^}.git"
else
	year="${PV::4}" month="${PV:4:2}" day="${PV:6:2}" patch="${PV:10:1}"
	MY_PV="${year}.${month}.${day}${patch:+".${patch}"}"
	SRC_URI="https://github.com/bottlesdevs/${PN^}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64"
	S="${WORKDIR}/${PN^}-${MY_PV}"
fi

RESTRICT="!test? ( test )"
PROPERTIES="test_network"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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
		dev-python/pefile[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/vkbasalt-cli[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	${PYTHON_DEPS}
	app-text/blueprint-compiler
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

src_prepare() {
	eapply_user

	if [[ "${PV}" == *9999* ]]; then
		# https://github.com/bottlesdevs/Bottles#notices-for-package-maintainers
		sed -i "s/\(.*\)/\1-$(git rev-parse --short HEAD)/" "${S}/VERSION" || die
	fi
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
