# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit wrapper desktop xdg

DESCRIPTION="Unofficial desktop client for Figma - collaborative interface design tool"
HOMEPAGE="https://github.com/Figma-Linux/figma-linux"
SRC_URI="
	amd64? ( https://github.com/Figma-Linux/figma-linux/releases/download/v${PV}/figma-linux_${PV}_linux_amd64.zip -> ${P}-amd64.zip )
	arm64? ( https://github.com/Figma-Linux/figma-linux/releases/download/v${PV}/figma-linux_${PV}_linux_arm64.zip -> ${P}-arm64.zip )
"
S="${WORKDIR}"

RESTRICT="mirror test"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="test"

BDEPEND="app-arch/unzip"
RDEPEND="
	app-accessibility/at-spi2-atk
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libpng:0/16
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
"

QA_PREBUILT="*"

src_install() {
	local pnopt="/opt/${PN}"

	mkdir -p "${D}/${pnopt}" || die
	cp -R * "${D}/${pnopt}" || die

	make_wrapper "${PN}" "${EROOT}/${pnopt}/figma-linux"
	make_desktop_entry "${PN}" "${PN^}" "${EROOT}/${pnopt}/figma-linux.png"
}
