# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Professional open-source non-linear video editor"
HOMEPAGE="https://github.com/olive-editor/olive"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/olive-editor/olive.git"
else
	SRC_URI="https://github.com/olive-editor/olive/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="doxygen"

COMMON_DEPEND="
	>=dev-qt/qtcore-5.6.0
	>=dev-qt/qtgui-5.6.0
	>=dev-qt/qtmultimedia-5.6.0
	>=dev-qt/qtopengl-5.6.0
	>=dev-qt/qtsvg-5.6.0
	>=dev-qt/qtwidgets-5.6.0
	>media-libs/opencolorio-1.9.9
	media-libs/openexr
	>=media-libs/openimageio-2.1.12
	>=media-video/ffmpeg-3.0.0
	virtual/opengl
"
#media-video/opentimelineio : The CMakeFile tries to find it, but doesnt do anything yet.
# Wants opecolorio-2.0.0, but have to do >1.9.9 due to no proper release and portage not seeing prereleases and betas as being >=2.0.0

DEPEND="
	"${COMMON_DEPEND}"
	>=dev-qt/qtconcurrent-5.6.0
	dev-qt/linguist-tools
	doxygen? ( app-doc/doxygen[dot] )
"
RDEPEND="
	"${COMMON_DEPEND}"
	dev-qt/qtnetwork
"

src_configure() {
	local mycmakeargs=(
#		-DUPDATE_TS=
		-DBUILD_DOXYGEN="$(usex doxygen)"
	)
	cmake_src_configure
}

src_install() {
	if use doxygen; then
		docinto html
		dodoc -r docs/html/.
	fi
	cmake_src_install
}

pkg_postinst() {
	einfo "Olive crashes at runtime when playing video"
	einfo "with ~ffmpeg-4.3. The current remedy is to"
	einfo "use ~ffmpeg-4.2 or ffmpeg-9999 instead."
}
