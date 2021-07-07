# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Simple SDL2 / FFmpeg library for audio/video playback written in C99"
HOMEPAGE="https://github.com/katajakasa/SDL_kitchensink"
SRC_URI="https://github.com/katajakasa/SDL_kitchensink/archive/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"
IUSE="static sanitize examples"

BDEPEND+="
	examples? ( sys-apps/coreutils )
"
RDEPEND+="
	sanitize? ( >=sys-devel/gcc-5.0.0[sanitize] )
	media-libs/libsdl2
	media-video/ffmpeg[libass]
"

#S="${S}/${PN}"
S="${WORKDIR}/SDL_kitchensink-${PV}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	SANITIZE="OFF"
	EXAMPLES="OFF"
	STATIC="OFF"

	if use sanitize; then SANITIZE="ON"; fi
	if use examples; then EXAMPLES="ON"; fi
	if use static; then STATIC="ON"; fi

	local mycmakeargs=(
		-DUSE_ASAN="${SANITIZE}"
		-DBUILD_EXAMPLES="${EXAMPLES}"
		-DBUILD_STATIC="${STATIC}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use examples; then
		for i in audio complex custom rwops simple; do
			mv "${BUILD_DIR}"/${i} "${BUILD_DIR}"/SDL_kitchensink-${i}
			dobin "${BUILD_DIR}"/SDL_kitchensink-${i}
			elog "Installed ${i} example as SDL_kitchensink-${i}"
		done
		if use static; then
			elog "Examples are linked against static SDL_kitchensink library."
		fi
	fi
}
