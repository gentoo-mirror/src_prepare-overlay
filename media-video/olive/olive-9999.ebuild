# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

RESTRICT="!test? ( test )"

LICENSE="GPL-3"
SLOT="0"
IUSE="doc test"

# TODO: qt6
DEPEND="
	>=dev-qt/qtconcurrent-5.6.0
	>=dev-qt/qtcore-5.6.0
	>=dev-qt/qtgui-5.6.0
	>=dev-qt/qtopengl-5.6.0
	>=dev-qt/qtsvg-5.6.0
	>=dev-qt/qtwidgets-5.6.0
	>=media-libs/opencolorio-2.0.0:=
	media-libs/openexr:=
	>=media-libs/openimageio-2.1.12:=
	media-libs/opentimelineio:=
	media-libs/portaudio
	>=media-video/ffmpeg-3.0.0
	virtual/opengl
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-qt/linguist-tools:5
	doc? ( app-text/doxygen[dot] )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOXYGEN="$(usex doc)"
		-DBUILD_TESTS="$(usex test)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use doc; then
		docinto html
		dodoc -r "${BUILD_DIR}"/docs/html/*
	fi
}
