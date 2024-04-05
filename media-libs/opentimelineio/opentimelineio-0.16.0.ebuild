# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
inherit cmake python-r1

DESCRIPTION="Open Source API and interchange format for editorial timeline information."
HOMEPAGE="https://opentimeline.io"
if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AcademySoftwareFoundation/OpenTimelineIO.git"
	EGIT_SUBMODULES="src/deps/{any,optional-lite,rapidjson}"
else
	MY_PN="OpenTimelineIO"

	PYBIND11_COMMIT="8a099e44b3d5f85b20f05828d919d2332a8de841"
	RAPIDJSON_COMMIT="06d58b9e848c650114556a23294d0b6440078c61"

	SRC_URI="
		https://github.com/AcademySoftwareFoundation/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.tar.gz
		https://github.com/Tencent/rapidjson/archive/${RAPIDJSON_COMMIT}.tar.gz
			-> rapidjson-${RAPDIJSON_COMMIT}.tar.gz
		python? (
			https://github.com/pybind/pybind11/archive/${PYBIND11_COMMIT}.tar.gz
				-> pybind11-${PYBIND11_COMMIT}.tar.gz
		)
	"
	S="${WORKDIR}/${MY_PN}-${PV}"

	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	|| (
		dev-libs/imath
		media-libs/ilmbase
	)
"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
"
BDEPEND="
	python? (
		python_targets_python3_11? ( dev-python/unittest-or-fail[python_targets_python3_11] )
	)
"

src_prepare() {
	if [[ "${PV}" != "9999" ]]; then
		mv -T "${WORKDIR}/rapidjson-${RAPIDJSON_COMMIT}" "${S}/src/deps/rapidjson" || die
		if use python; then
			mv -T "${WORKDIR}/pybind11-${PYBIND11_COMMIT}" "${S}/src/deps/pybind11" || die
		fi
	fi

	default

	sed -i -e "/OTIO_RESOLVED_CXX_DYLIB_INSTALL_DIR/ s|\${CMAKE_INSTALL_PREFIX}/lib|$(get_libdir)|" \
		CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOTIO_CXX_INSTALL=ON
		-DOTIO_PYTHON_INSTALL=OFF
		-DOTIO_DEPENDENCIES_INSTALL=ON
		-DOTIO_INSTALL_PYTHON_MODULES=OFF
		-DOTIO_INSTALL_COMMANDLINE_TOOLS=ON
		-DOTIO_PYTHON_INSTALL_DIR=OFF
		-DOTIO_INSTALL_CONTRIB=OFF
		-DOTIO_SHARED_LIBS=ON
		-DOTIO_CXX_COVERAGE=OFF
		-DOTIO_CXX_EXAMPLES=OFF
		-DOTIO_AUTOMATIC_SUBMODULES=OFF
		-DOTIO_FIND_IMATH=ON
		-DUSE_DEPS_IMATH=OFF
	)
	cmake_src_configure

	myconfigure() {
		local mycmakeargs=(
			-DOTIO_CXX_INSTALL=OFF
			-DOTIO_PYTHON_INSTALL=ON
			-DOTIO_DEPENDENCIES_INSTALL=OFF
			-DOTIO_INSTALL_PYTHON_MODULES=ON
			-DOTIO_INSTALL_COMMANDLINE_TOOLS=OFF
			-DOTIO_PYTHON_INSTALL_DIR=$(python_get_sitedir)
			-DOTIO_INSTALL_CONTRIB=OFF
			-DOTIO_SHARED_LIBS=OFF
			-DOTIO_CXX_COVERAGE=OFF
			-DOTIO_CXX_EXAMPLES=OFF
			-DOTIO_AUTOMATIC_SUBMODULES=OFF
			-DOTIO_FIND_IMATH=ON
			-DUSE_DEPS_IMATH=OFF
		)
		cmake_src_configure
	}

	use python && python_foreach_impl run_in_build_dir myconfigure
}

src_compile() {
	cmake_src_compile
	use python && python_foreach_impl run_in_build_dir cmake_src_compile
}

src_test() {
	cmake_src_test

	# TODO
	local -x OTIO_DISABLE_SHELLOUT_TESTS=1
	local -x OTIO_DISABLE_SERIALIZED_SCHEMA_TEST=1
	use python && python_foreach_impl eunittest tests
}

src_install() {
	cmake_src_install
	einstalldocs

	my_python_optimize() {
		python_optimize "${D}$(python_get_sitedir)"
	}

	if use python; then
		python_foreach_impl run_in_build_dir cmake_src_install
		python_foreach_impl my_python_optimize
	fi
}
