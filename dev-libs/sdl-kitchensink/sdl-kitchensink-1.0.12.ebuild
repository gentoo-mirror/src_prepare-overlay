# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A Simple SDL2 / FFmpeg library for audio/video playback written in C99"
HOMEPAGE="https://github.com/katajakasa/SDL_kitchensink"
SRC_URI="https://github.com/katajakasa/SDL_kitchensink/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SDL_kitchensink-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc examples"

# no tests
RESTRICT="test"

RDEPEND="
	>=media-libs/libsdl2-2.0.5
	>=media-video/ffmpeg-3.2:=
	media-libs/libass:=
"
BDEPEND="
	doc? ( app-text/doxygen )
"

src_prepare() {
	cmake_src_prepare

	# Install examples
	sed -i \
		-e 's/set_property(TARGET ${TARGET} PROPERTY \(.*\))/\
		set_target_properties(${TARGET} PROPERTIES OUTPUT_NAME "SDL_kitchensink-${TARGET}" \1)/' \
		-e '/add_executable(${TARGET}/ a\\tinstall(TARGETS ${TARGET})' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES="$(usex examples)"
		-DBUILD_SHARED=ON
		-DBUILD_STATIC=OFF
		-DUSE_ASAN=OFF
		-DUSE_DYNAMIC_LIBASS=OFF
		-DUSE_TIDY=OFF
	)
	cmake_src_configure
}

src_compile () {
	cmake_src_compile

	use doc && cmake_build docs
}

src_install() {
	cmake_src_install

	if use doc; then
		dodoc -r "${S}"/docs/html
	fi
}

pkg_postinst() {
	if use examples; then
		for i in audio complex custom rwops simple; do
			einfo "Installed ${i} example as SDL_kitchensink-${i}"
		done
	fi
}
