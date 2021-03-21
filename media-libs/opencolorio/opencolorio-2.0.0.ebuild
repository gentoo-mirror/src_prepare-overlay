# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A color management framework for visual effects and animation"
HOMEPAGE="https://opencolorio.org/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AcademySoftwareFoundation/OpenColorIO.git"
else
#	MY_P=$(ver_rs 3 '-')
	SRC_URI="
		https://github.com/AcademySoftwareFoundation/OpenColorIO/archive/v"${PV}".tar.gz -> "${P}".tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/OpenColorIO-"${PV}""
fi

# TODO
# doc, Python and Java bindings

LICENSE="BSD"
SLOT="0"
IUSE="cpu_flags_x86_sse2 opengl test"
#REQUIRED_USE="
#	doc? ( python )
#	python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	dev-cpp/pystring
	>=dev-cpp/yaml-cpp-0.5
	dev-libs/tinyxml
	dev-python/pybind11
	opengl? (
		media-libs/lcms:2
		media-libs/openimageio
		media-libs/glew:=
		media-libs/freeglut
		virtual/opengl
	)
	media-libs/ilmbase
"

DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

# No doc for now, as sphinx-tabs isnt in the main repo but in guru and due sphinx-press-theme not being done yet.
# + python bindings not working properly so they are omited for now
#	doc? (
#		app-doc/doxygen
#		$(python_gen_cond_dep '
#			dev-python/six[${PYTHON_USEDEP}]
#			dev-python/testresources[${PYTHON_USEDEP}]
#			dev-python/recommonmark[${PYTHON_USEDEP}]
#			dev-python/sphinx[${PYTHON_USEDEP}]
#			dev-python/sphinx-press-theme[${PYTHON_USEDEP}]
#			dev-python/sphinx-tabs[${PYTHON_USEDEP}]
#			dev-python/breathe[${PYTHON_USEDEP}]
#		')
#	)
#"

CMAKE_BUILD_TYPE="Release"

PATCHES=(
	"${FILESDIR}/opencolorio-2.0.0_libraries_to_lib64_instead_of_lib.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DOCIO_BUILD_APPS=$(usex opengl)
#		-DOCIO_BUILD_DOCS=$(usex doc)
#		-DOCIO_BUILD_PYTHON=$(usex python)
		-DOCIO_BUILD_TESTS=$(usex test)
		-DOCIO_BUILD_GPU_TESTS=$(usex test)
		-DOCIO_USE_SSE=$(usex cpu_flags_x86_sse2)
		-DOCIO_INSTALL_EXT_PACKAGES=NONE

	)
	cmake_src_configure
}
