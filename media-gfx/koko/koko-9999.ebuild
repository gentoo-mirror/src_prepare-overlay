# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="true"
ECM_TEST="true"
KFMIN=5.240
QTMIN=6.4

GEONAMES_DATA=(
	"admin1CodesASCII.txt"
	"admin2Codes.txt"
	"cities1000.zip"
)

geonames-src_uri() {
	for file in ${GEONAMES_DATA[@]}; do
		SRC_URI+=" https://download.geonames.org/export/dump/${file} -> ${P}-${file}"
	done
}

inherit ecm gear.kde.org git-r3

DESCRIPTION="Image gallery application by KDE designed for desktop and touch devices"
HOMEPAGE="https://apps.kde.org/koko/"

LICENSE="|| ( LGPL-2.1 LGPL-3 ) CC-BY-4.0"
SLOT="0"
IUSE="X"

geonames-src_uri

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtpositioning-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=media-gfx/exiv2-0.21:=
	>=media-libs/kquickimageeditor-1.0
	X? ( x11-libs/libxcb:= )
"
RDEPEND="
	${DEPEND}
	dev-libs/kirigami-addons:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/purpose-${KFMIN}:6
"
BDEPEND="
	app-arch/unzip
"

CMAKE_SKIP_TESTS=(
	# Expects files to installed, and you can't install the files before you test.
	"reversegeocodertest"
)

src_unpack() {
	git-r3_src_unpack

	for file in ${GEONAMES_DATA[@]}; do
		cp "${DISTDIR}/${P}-${file}" "${S}/src/${file}" || die
	done
}

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package X XCB)
	)
	cmake_src_configure
}
