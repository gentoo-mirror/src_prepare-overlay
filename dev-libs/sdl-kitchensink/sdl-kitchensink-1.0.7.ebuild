# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A Simple SDL2 / FFmpeg library for audio/video playback written in C99"
HOMEPAGE="https://github.com/katajakasa/SDL_kitchensink"
SRC_URI="https://github.com/katajakasa/SDL_kitchensink/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

IUSE="static sanitize examples"

BDEPEND+="
	!static? ( sys-apps/findutils )
	examples? ( sys-apps/coreutils )
"

RDEPEND+="
	sanitize? ( sys-devel/gcc[sanitize] )
	media-libs/libsdl2
	media-video/ffmpeg[libass]
"

#S="${S}/${PN}"
S="${WORKDIR}/SDL_kitchensink-${PV}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	SANITIZE="OFF"
	EXAMPLES="OFF"
	if use sanitize; then SANITIZE="ON"; fi
	if use examples; then EXAMPLES="ON"; fi
	local mycmakeargs=(
		-DUSE_ASAN="${SANITIZE}"
		-DBUILD_EXAMPLES="${EXAMPLES}"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if ! use static; then
		elog "Removing static library libSDL_kitchensink_static.a"
		find "${D}" -name libSDL_kitchensink_static.a -delete
	fi
	if use examples; then
		for i in audio complex custom rwops simple; do
			elog "Installing example: ${i}"
			mv "${BUILD_DIR}"/${i} "${BUILD_DIR}"/SDL_kitchensink-${i}
			dobin "${BUILD_DIR}"/SDL_kitchensink-${i}
		done
		if use static; then
			elog "Examples are linked against static SDL_kitchensink library."
		fi
	fi
}
