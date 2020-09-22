# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
inherit qmake-utils python-single-r1 xdg

DESCRIPTION="A fancy, customizable, keyboard-operable Qt/QML+Python Matrix chat client."
HOMEPAGE="https://github.com/mirukana/mirage"

SUBMODULE_COMMITS=(
	"ec3af1a087a0c4c0c31709ed94b7e939d3e51400"
	"36befddf5d57faad990e72c88c5844794f274145"
	"0e796aacc16388a164bab0bb0ce9dabc885ed7fa"
	"9e9be32d6010cad484a7b12b1a3d19c6cf4c1353"
	"f5ca07b71cecda685d0dd4b3c74d2fb2ca71f711"
)

#[0] mirukana/RadialBarDemo
#[1] oKcerG/SortFilterProxyModel
#[2] Cutehacks/gel
#[3] hsluv/hsluv-c
#[4] benlau/qsyncable

if [[ "${PV}" == "9999" ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mirukana/mirage.git"
	EGIT_SUBMODULES=( '*' )
else
	SRC_URI="
		https://github.com/mirukana/"${PN}"/archive/v"${PV}".tar.gz -> "${PN}"-v"${PV}".tar.gz
		https://github.com/mirukana/RadialBarDemo/archive/"${SUBMODULE_COMMITS[0]}".tar.gz -> RadialBarDemo-"${SUBMODULE_COMMITS[0]}".tar.gz
		https://github.com/oKcerG/SortFilterProxyModel/archive/"${SUBMODULE_COMMITS[1]}".tar.gz -> SortFilterProxyModel-"${SUBMODULE_COMMITS[1]}".tar.gz
		https://github.com/Cutehacks/gel/archive/"${SUBMODULE_COMMITS[2]}".tar.gz -> gel-"${SUBMODULE_COMMITS[2]}".tar.gz
		https://github.com/hsluv/hsluv-c/archive/"${SUBMODULE_COMMITS[3]}".tar.gz -> hsluv-c-"${SUBMODULE_COMMITS[3]}".tar.gz
		https://github.com/benlau/qsyncable/archive/"${SUBMODULE_COMMITS[4]}".tar.gz -> qsyncable-"${SUBMODULE_COMMITS[4]}".tar.gz
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
	>=dev-qt/qtimageformats-5.12
	>=dev-qt/qtsvg-5.12
	dev-libs/olm
	dev-python/pyotherside[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/matrix-nio[e2e,${PYTHON_USEDEP}]
		>=dev-python/aiofiles-0.4.0[${PYTHON_USEDEP}]
		>=dev-python/appdirs-1.4.4[${PYTHON_USEDEP}]
		>=dev-python/blist-1.3.6[${PYTHON_USEDEP}]
		>=media-gfx/cairosvg-2.4.2[${PYTHON_USEDEP}]
		>=dev-python/filetype-1.0.7[${PYTHON_USEDEP}]
		>=dev-python/html_sanitizer-1.9.1[${PYTHON_USEDEP}]
		>=dev-python/lxml-4.5.1[${PYTHON_USEDEP}]
		>=dev-python/mistune-0.8.4[${PYTHON_USEDEP}]
		>=dev-python/pillow-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/pymediainfo-4.2.1[${PYTHON_USEDEP}]
		python_single_target_python3_6? ( >=dev-python/async_generator-1.10[python_targets_python3_6] )
		python_single_target_python3_6? ( >=dev-python/dataclasses-0.6[python_targets_python3_6] )
		python_single_target_python3_6? ( >=dev-python/pyfastcopy-1.0.3[python_targets_python3_6] )
		python_single_target_python3_7? ( >=dev-python/pyfastcopy-1.0.3[python_targets_python3_7] )

	')
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
		local submodules_libs="RadialBarDemo SortFilterProxyModel gel hsluv-c qsyncable"
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
	eqmake5 mirage.pro PREFIX="${D}"/usr ${myconf}
}

src_install() {
	emake install
}
