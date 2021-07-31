# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit qmake-utils python-single-r1 xdg

DESCRIPTION="A fancy, customizable, keyboard-operable Qt/QML+Python Matrix chat client."
HOMEPAGE="https://github.com/mirukana/mirage"

# Currently only one submodule needed for the build, but keeping the capacity to add more submodules for the future.
SUBMODULE_COMMITS=(
	"9e9be32d6010cad484a7b12b1a3d19c6cf4c1353"
)

#[0] hsluv/hsluv-c

if [[ "${PV}" == "9999" ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mirukana/mirage.git"
	EGIT_BRANCH="dev"
	EGIT_SUBMODULES=( submodules/hsluv-c )
else
	SRC_URI="
		https://github.com/mirukana/"${PN}"/archive/v"${PV}".tar.gz -> "${PN}"-v"${PV}".tar.gz
		https://github.com/hsluv/hsluv-c/archive/"${SUBMODULE_COMMITS[0]}".tar.gz -> hsluv-c-"${SUBMODULE_COMMITS[0]}".tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="X"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	>=dev-qt/qtcore-5.12
	>=dev-qt/qtdeclarative-5.12
	>=dev-qt/qtquickcontrols2-5.12[widgets]
	>=dev-qt/qtgraphicaleffects-5.12
	X? (
		x11-libs/libX11
		x11-libs/libXScrnSaver
	)
"

RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
	>=dev-qt/qtgui-5.12[gif,png,jpeg]
	>=dev-qt/qtimageformats-5.12
	>=dev-qt/qtsvg-5.12
	dev-libs/olm
	dev-python/pyotherside[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/aiofiles-0.4.0[${PYTHON_USEDEP}]
		>=dev-python/appdirs-1.4.4[${PYTHON_USEDEP}]
		>=dev-python/dbus-python-1.2.16[${PYTHON_USEDEP}]
		>=dev-python/filetype-1.0.7[${PYTHON_USEDEP}]
		>=dev-python/hsluv-python-5.0.0[${PYTHON_USEDEP}]
		>=dev-python/html_sanitizer-1.9.1[${PYTHON_USEDEP}]
		>=dev-python/lxml-4.5.1[${PYTHON_USEDEP}]
		>=dev-python/matrix-nio-0.17.0[e2e,${PYTHON_USEDEP}]
		>=dev-python/mistune-0.8.4[${PYTHON_USEDEP}]
		>=dev-python/pillow-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/plyer-1.4.3[${PYTHON_USEDEP}]
		>=dev-python/pymediainfo-4.2.1[${PYTHON_USEDEP}]
		>=dev-python/redbaron-0.9.2[${PYTHON_USEDEP}]
		>=dev-python/simpleaudio-1.0.4[${PYTHON_USEDEP}]
		>=dev-python/sortedcontainers-2.2.2[${PYTHON_USEDEP}]
		>=dev-python/watchgod-0.6[${PYTHON_USEDEP}]
		>=media-gfx/cairosvg-2.4.2[${PYTHON_USEDEP}]
	')
	media-libs/alsa-lib
	media-libs/libjpeg-turbo
	media-libs/libmediainfo
	media-libs/libwebp
	media-libs/tiff
	media-libs/openjpeg:2
	sys-libs/zlib
"

src_prepare() {
	move_lib() {
		local IN_DIR="${1}"
		local OUT_DIR
		[ -z "${2}" ] && OUT_DIR="${IN_DIR}" || OUT_DIR=""${2%/}"/"${IN_DIR}""
		mv ""${WORKDIR}"/"${IN_DIR}""*/* ""${S}"/"${OUT_DIR}"" || die
	}
	if [ "${PV}" != "9999" ]; then
		local submodules_libs="hsluv-c"
		for submodules_lib in ${submodules_libs} ; do
			move_lib "${submodules_lib}" submodules
		done
	fi
	eapply_user
}

src_configure() {
	if use !X; then
		myconf="CONFIG+=no-x11"
	fi
	eqmake5 mirage.pro PREFIX="${EPREFIX}/usr" ${myconf}
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
