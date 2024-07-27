# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A customizable music player, Qt clone of foobar2000"
HOMEPAGE="https://www.fooyin.org/"
SRC_URI="
	https://github.com/fooyin/fooyin/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alsa pipewire sdl test"
RESTRICT="!test? ( test )"
REQUIRED_USE="|| ( alsa pipewire sdl )"

RDEPEND="
	dev-libs/icu:=
	dev-libs/kdsingleapplication
	dev-qt/qtbase:6[concurrent,dbus,gui,network,sql,widgets]
	media-libs/taglib
	media-video/ffmpeg:=
	alsa? ( media-libs/alsa-lib )
	pipewire? ( media-video/pipewire:= )
	sdl? ( media-libs/libsdl2 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? ( dev-cpp/gtest )
"

src_prepare() {
	sed -i CMakeLists.txt \
		-e "s|/doc/${PN}|/doc/${PF}|g" \
		-e '/option(BUILD_TESTING/aenable_testing()' \
		|| die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DBUILD_CCACHE=OFF
		-DINSTALL_HEADERS=ON
		$(cmake_use_find_package alsa ALSA)
		$(cmake_use_find_package pipewire PipeWire)
		$(cmake_use_find_package sdl SDL2)
	)

	cmake_src_configure
}

src_test() {
	local CMAKE_SKIP_TESTS=(
		# TODO: figure out why these tests fail to find their test data
		TagReaderTest.*
		TagWriterTest.*
	)

	cmake_src_test
}
