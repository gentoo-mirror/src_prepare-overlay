# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 meson xdg

DESCRIPTION="A lightweight image viewer for Sway/Wayland display servers."
HOMEPAGE="https://github.com/artemsen/swayimg"
if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/artemsen/swayimg"
else
	SRC_URI="https://github.com/artemsen/swayimg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

COMMUN_DEPEND="
	dev-libs/json-c
	dev-libs/wayland
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libxkbcommon
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib )
	heif? ( media-libs/libheif )
	jpeg? ( media-libs/libjpeg-turbo )
	jpegxl? ( media-libs/libjxl )
	png? ( media-libs/libpng )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff )
	webp? ( media-libs/libwebp )"

RDEPEND="${COMMUN_DEPEND}"

DEPEND="
	${COMMUN_DEPEND}
	dev-libs/wayland-protocols"

BDEPEND="
	dev-util/wayland-scanner"

IUSE="exif gif heif jpeg jpegxl png svg tiff webp"

src_configure() {
	local emesonargs=(
		$(meson_feature exif)
		$(meson_feature gif)
		$(meson_feature heif)
		$(meson_feature jpeg)
		$(meson_feature jpegxl jxl)
		$(meson_feature png)
		$(meson_feature svg)
		$(meson_feature tiff)
		$(meson_feature webp)
		-Ddesktop=true
		-Dman=true
		-Dzsh=enabled
	)
	if [[ "${PV}" != "9999" ]]; then
		emesonargs+=( -Dversion=${PV} )
	fi
	meson_src_configure
}

src_install(){
	meson_src_install
	newbashcomp extra/bash.completion ${PN}
}
