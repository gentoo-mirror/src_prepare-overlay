# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# 5.4.0 -> tulip_5_4_0
TULIP_P="${PN}_${PV//./_}"

PYTHON_COMPAT=( python3_{8..9} )

inherit cmake python-r1 xdg

DESCRIPTION="Large graphs analysis, drawing and visualization framework"
HOMEPAGE="https://tulip.labri.fr/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Tulip-Dev/${PN}.git"
else
	SRC_URI="https://github.com/Tulip-Dev/${PN}/archive/${TULIP_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}"/"${PN}-${TULIP_P}"
fi

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="LGPL-3"
SLOT="0"
IUSE="ccache debug minimal +python test"
REQUIRED_USE="
	python? (
		${PYTHON_REQUIRED_USE}
	)
	minimal? ( !python )
"

# TODO: turn off doc build on USE demand
BDEPEND="
	ccache? (
		dev-util/ccache
	)
"
RDEPEND="
	dev-libs/quazip
	dev-libs/yajl
	media-libs/qhull
	sys-libs/zlib
	!minimal? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[X]
		dev-qt/qtnetwork:5
		dev-qt/qtquickcontrols2:5
		dev-qt/qtwebchannel:5
		dev-qt/qtwebengine:5
		dev-qt/qtwidgets:5[X]
		media-libs/freetype
		media-libs/glew:0
		python? (
			${PYTHON_DEPS}
			dev-python/sip:*[${PYTHON_USEDEP}]
		)
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-util/cppunit
	)
	!minimal? (
		app-doc/doxygen[dot]
		dev-python/sphinx
	)
"

# In live version this is likely to break
PATCHES=(
	"${FILESDIR}"/"${PN}-sandbox.patch"
)

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug Debug Release)
		-DTULIP_BUILD_CORE_ONLY=$(usex minimal ON OFF)
		-DTULIP_BUILD_PYTHON_COMPONENTS=$(usex python ON OFF)
		-DTULIP_BUILD_TESTS=$(usex test ON OFF)
		-DTULIP_USE_CCACHE=$(usex ccache ON OFF)
	)

	cmake_src_configure
}
