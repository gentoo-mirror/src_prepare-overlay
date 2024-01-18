# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="CLI based audio visualizer"
HOMEPAGE="https://github.com/dpayne/cli-visualizer"
COMMIT="b98068ffbe55210ab4828556d243e13e79ba889d"
SRC_URI="https://github.com/dpayne/cli-visualizer/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	media-libs/libpulse
	media-libs/portaudio
	sci-libs/fftw:3.0=
	sys-libs/ncurses:=[tinfo]
	test? (
		dev-cpp/gtest
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare

	# Handle automagic, upstream uses find_program and find_library instead find_package forcing this approach
	sed -i \
		-e '/find_program(CCACHE_FOUND ccache)/d' \
		-e '/find_library(JEMALLOC_FOUND NAMES jemalloc)/d' \
		-e '/ExternalProject_Add(googletest/,/)$/d' \
		-e '/if(VIS_WITH_TESTS)/afind_package(GTest REQUIRED)' \
		-e '/set(GTEST_INCLUDE_DIRS ${EXTERNAL_PROJECTS_INCLUDE_DIR})/,/add_dependencies(${GMOCK_MAIN_LIBRARY} ${GTEST_LIBRARY})/d' \
		-e 's/target_link_libraries(${PROJECT_TEST_NAME} gtest gmock pthread)/target_link_libraries(${PROJECT_TEST_NAME} GTest::gtest GTest::gmock pthread)/' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DVIS_WITH_TESTS=$(usex test)
		-DVIS_WITH_PERF_TESTS=OFF # possible false positive when under heavy load
		-DVIS_RUN_CLANG_FORMAT=OFF
		-DVIS_RUN_CLANG_TIDY=OFF
	)

	cmake_src_configure
}
