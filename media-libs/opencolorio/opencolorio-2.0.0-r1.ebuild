# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit python-single-r1 multilib cmake

DESCRIPTION="A color management framework for visual effects and animation"
HOMEPAGE="https://opencolorio.org/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AcademySoftwareFoundation/OpenColorIO.git"
else
	SRC_URI="
		https://github.com/AcademySoftwareFoundation/OpenColorIO/archive/v"${PV}".tar.gz -> "${P}".tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/OpenColorIO-"${PV}""
fi

#Missing:
# Java bindings

LICENSE="BSD"
SLOT="0"
IUSE="cpu_flags_x86_sse2 doc opengl python test"
REQUIRED_USE="
	doc? ( python )
	python? ( ${PYTHON_REQUIRED_USE} )
"

RDEPEND="
	>=dev-cpp/pystring-1.1.3
	>=dev-cpp/yaml-cpp-0.6.3
	>=dev-libs/expat-2.2.5
	>=media-libs/ilmbase-2.3.0
	opengl? (
		>=media-libs/lcms-2.2
		>=media-libs/openimageio-2.1.9:=
	)
	python? (
		$(python_gen_cond_dep '
			>=dev-python/pybind11-2.4.3[${PYTHON_USEDEP}]
		')
	)
"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		$(python_gen_cond_dep '
			dev-python/six[${PYTHON_USEDEP}]
			dev-python/testresources[${PYTHON_USEDEP}]
			dev-python/recommonmark[${PYTHON_USEDEP}]
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/sphinx_press_theme[${PYTHON_USEDEP}]
			dev-python/sphinx-tabs[${PYTHON_USEDEP}]
			dev-python/breathe[${PYTHON_USEDEP}]
		')
	)
	test? (
		$(python_gen_cond_dep '
			dev-python/numpy[${PYTHON_USEDEP}]
		')
	)
"
BDEPEND="
	virtual/pkgconfig
"

CMAKE_BUILD_TYPE="Release"

src_prepare() {
	sed -i "s/DESTINATION lib/DESTINATION $(get_libdir)/" "${S}"/src/OpenColorIO/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLIB_SUFFIX=""
		-DBUILD_SHARED_LIBS=ON
		-DOCIO_BUILD_APPS=$(usex opengl)
		-DOCIO_BUILD_DOCS=$(usex doc)
		-DOCIO_BUILD_PYTHON=$(usex python)
		-DOCIO_BUILD_JAVA=OFF
		-DOCIO_BUILD_TESTS=$(usex test)
		-DOCIO_BUILD_GPU_TESTS=$(usex test)
		-DOCIO_USE_SSE=$(usex cpu_flags_x86_sse2)
		-DOCIO_INSTALL_EXT_PACKAGES=NONE

	)
	cmake_src_configure
}
