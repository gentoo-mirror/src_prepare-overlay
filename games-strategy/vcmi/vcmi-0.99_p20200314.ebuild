# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
COMMIT_SHA="dca5d86e7a6d18d2ddac7258f98a0ce08c691a6e"

inherit cmake-utils vcs-snapshot xdg

DESCRIPTION="VCMI is work-in-progress attempt to recreate engine for Heroes III."
HOMEPAGE="http://vcmi.eu"
SRC_URI="https://github.com/${PN}/${PN}/archive/${COMMIT_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="editor erm +launcher"

RDEPEND="
	dev-libs/fuzzylite
	media-libs/libsdl2[video]
	media-libs/sdl2-image
	media-libs/sdl2-mixer[mp3]
	media-libs/sdl2-ttf
	sys-libs/zlib[minizip]
	virtual/ffmpeg

	editor? (
		dev-qt/qtwidgets:5
	)
	launcher? (
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
	)
"
DEPEND="${RDEPEND}
	dev-libs/boost:=[nls]
	virtual/pkgconfig
"

src_prepare() {
	patch -p1 < "${FILESDIR}"/0001-fix-desktop-entries-not-loading-due-to-missing-libs.patch
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_EDITOR=$(usex editor)
		-DENABLE_ERM=$(usex erm)
		-DENABLE_LAUNCHER=$(usex launcher)
		-DENABLE_PCH=ON
		-DENABLE_TEST=OFF
		-DFORCE_BUNDLED_FL=OFF
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "In order to play VCMI you must install:"
	elog "- Heroes III: Shadow of Death or Complete edition;"
	elog "- Unnoficial WoG addon;"
	elog "- VCMI data files."
	elog "Use vcmibuilder tool for automated install of data files;"
	elog "Additional information can be found in VCMI wiki:"
	elog "http://wiki.vcmi.eu/index.php?title=Installation_on_Linux#Installing_Heroes_III_data_files"
}
