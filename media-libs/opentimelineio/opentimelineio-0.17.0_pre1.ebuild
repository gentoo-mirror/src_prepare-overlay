# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PV="${PV/_pre/.dev}"

DESCRIPTION="Open Source API and interchange format for editorial timeline information."
HOMEPAGE="https://opentimeline.io"
if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AcademySoftwareFoundation/OpenTimelineIO.git"
	EGIT_SUBMODULES="src/deps/{any,optional-lite,rapidjson}"
else
	MY_PN="OpenTimelineIO"

	ANY_COMMIT="bfc77f2e4be6e9a093dd645ef3f1aa30620c9205"
	OPTIONAL_LITE_COMMIT="be720ebfd7add22abe60e49602735de9231105d0"
	RAPIDJSON_COMMIT="06d58b9e848c650114556a23294d0b6440078c61"

	SRC_URI="
		https://github.com/AcademySoftwareFoundation/${MY_PN}/archive/refs/tags/v${MY_PV}.tar.gz
			-> ${P}.tar.gz
		https://github.com/thelink2012/any/archive/${ANY_COMMIT}.tar.gz
			-> any-${ANY_COMMIT}.tar.gz
		https://github.com/martinmoene/optional-lite/archive/${OPTIONAL_LITE_COMMIT}.tar.gz
			-> optional-lite-${OPTIONAL_LITE_COMMIT}.tar.gz
		https://github.com/Tencent/rapidjson/archive/${RAPIDJSON_COMMIT}.tar.gz
			-> rapidjson-${RAPDIJSON_COMMIT}.tar.gz
	"
	S="${WORKDIR}/${MY_PN}-${MY_PV}"

	KEYWORDS=""
fi

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	|| (
		dev-libs/imath
		media-libs/ilmbase
	)
"
RDEPEND="${DEPEND}"

#TODO: python

src_prepare() {
	if [[ "${PV}" != "9999" ]]; then
		rmdir "${S}/src/deps/"{any,optional-lite,rapidjson} || die
		mv "${WORKDIR}/any-${ANY_COMMIT}" "${S}/src/deps/any" || die
		mv "${WORKDIR}/optional-lite-${OPTIONAL_LITE_COMMIT}" "${S}/src/deps/optional-lite" || die
		mv "${WORKDIR}/rapidjson-${RAPIDJSON_COMMIT}" "${S}/src/deps/rapidjson" || die
	fi

	eapply_user

	sed -i \
		"s|\(set(OTIO_RESOLVED_CXX_DYLIB_INSTALL_DIR \"\${CMAKE_INSTALL_PREFIX}/\)lib\")|\1$(get_libdir)\")|" \
		CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# needed for olive, hopefully set upstream in the final release
		# (with the removal of bundled any and optional!)
		# https://github.com/AcademySoftwareFoundation/OpenTimelineIO/pull/1539
		-DCMAKE_CXX_STANDARD=17

		-DOTIO_AUTOMATIC_SUBMODULES=OFF
		-DOTIO_FIND_IMATH=ON

		-DOTIO_CXX_COVERAGE=OFF
		-DOTIO_CXX_EXAMPLES=OFF
		-DOTIO_CXX_INSTALL=ON
		-DOTIO_DEPENDENCIES_INSTALL=ON
		-DOTIO_INSTALL_COMMANDLINE_TOOLS=ON
		-DOTIO_INSTALL_CONTRIB=OFF
		-DOTIO_PYTHON_INSTALL=OFF
		-DOTIO_SHARED_LIBS=ON
	)
	cmake_src_configure
}
