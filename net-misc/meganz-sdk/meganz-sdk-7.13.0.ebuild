# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="MEGA C++ SDK"
HOMEPAGE="https://github.com/meganz/sdk"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/meganz/sdk.git"
else
	SRC_URI="https://github.com/meganz/sdk/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/sdk-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2"
SLOT="0/${PV}"
IUSE="examples ffmpeg freeimage fuse libuv mediainfo qt test"

RESTRICT="!test? ( test )"

# <ffmpeg-6: https://github.com/meganz/sdk/issues/2635
RDEPEND="
	dev-db/sqlite:3
	dev-libs/crypto++:=
	dev-libs/icu:=
	dev-libs/libsodium:=
	dev-libs/openssl:=
	net-dns/c-ares:=
	net-misc/curl
	ffmpeg? ( <media-video/ffmpeg-6 )
	freeimage? ( media-libs/freeimage )
	fuse? ( sys-fs/fuse )
	libuv? ( dev-libs/libuv:= )
	mediainfo? (
		media-libs/libmediainfo
		media-libs/libzen
	)
	qt? ( dev-qt/qtcore:5 )
"
DEPEND="
	${RDEPEND}
	sys-libs/readline
"

PATCHES=(
	"${FILESDIR}"/meganz-sdk-7.13.0-missing-iomanip.patch
)

src_prepare() {
	# 1. Mismatched pkgconfig file names
	# 2. Symbols still needed publically when linking library
	sed -i \
		-e '/pkg_check_modules/ s/libcrypto++/libcryptopp/' \
		-e '/target_link_libraries(SDKlib/ { /\(curl\|sodium\)/ s/PRIVATE/PUBLIC/ }' \
		contrib/cmake/modules/sdklib_libraries.cmake || die

	sed -i \
		-e 's|DESTINATION cmake|DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake|' \
		-e 's|DESTINATION pkgconfig|DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig|' \
		contrib/cmake/modules/sdklib_target.cmake || die

	# examples use readline symbols
	sed -i \
		-e 's/target_link_libraries(megacli PRIVATE MEGA::SDKlib)/target_link_libraries(megacli PRIVATE MEGA::SDKlib PkgConfig::readline)/' \
		examples/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	# building with DEBUG disabled isn't tested apparently
	# https://github.com/meganz/sdk/issues/2658
	append-cppflags -DDEBUG=1

	local mycmakeargs=(
		# CMakeLists.txt
		# contrib/cmake/modules/sdklib_options.cmake

		-DENABLE_ISOLATED_GFX=OFF # required freeimage + doesn't properly link libz
		-DENABLE_QT_BINDINGS=$(usex qt) # doesn't get installed
		-DENABLE_SDKLIB_EXAMPLES=$(usex examples)
		-DENABLE_SDKLIB_TESTS=$(usex test)
		-DENABLE_SDKLIB_WERROR=OFF
		-DUSE_FFMPEG=$(usex ffmpeg)
		-DUSE_C_ARES=ON
		-DUSE_FREEIMAGE=$(usex freeimage)
		-DUSE_LIBUV=$(usex libuv)
		-DUSE_MEDIAINFO=$(usex mediainfo)
		-DUSE_OPENSSL=ON
		-DUSE_PDFIUM=OFF # unpackaged
		-DUSE_READLINE=ON
		-DWITH_FUSE=$(usex fuse)
	)
	cmake_src_configure
}

src_test() {
	set -- "${BUILD_DIR}"/tests/unit/test_unit
	einfo ${@}
	${@} || die

	# integration test require a mega account and will be destructive, which is why they aren't run.
	# IMPORTANT: the main account must be empty (Cloud & Rubbish) before starting the test and it will be purged at exit.
	# Both main and auxiliar accounts shouldn't be contacts yet and shouldn't have any pending contact requests.
	# Set your login credentials as environment variables:
	# * $MEGA_EMAIL and $MEGA_PWD (and $MEGA_EMAIL_AUX / $MEGA_PWD_AUX for shares * contacts)
}

src_install() {
	cmake_src_install

	doheader -r include/mega

	if use qt; then
		dolib.so "${BUILD_DIR}"/bindings/qt/libSDKQtBindings.so
		insinto /usr/share/${PN}/bindings/qt
		doins bindings/qt/*.{h,cpp}
	fi
}
