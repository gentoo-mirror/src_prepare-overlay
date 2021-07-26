# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN//-bin}"

inherit unpacker xdg-utils

DESCRIPTION="Flash OS images to SD cards & USB drives, safely and easily."
HOMEPAGE="https://etcher.io"
SRC_URI="https://github.com/balena-io/${MY_PN}/releases/download/v${PV}/balena-etcher-electron_${PV}_amd64.deb"
RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	app-arch/lzma
	dev-libs/atk
	dev-libs/expat
	dev-libs/libappindicator
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/fontconfig
	media-libs/freetype
	net-print/cups
	sys-apps/dbus
	sys-auth/polkit
	x11-apps/xrandr
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libnotify
"

QA_PREBUILT="
	opt/balenaEtcher/*
"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	mv * "${D}" || die
	rm -rd "${D}/usr/share/doc/balena-etcher-electron"
	sed -i "s/Utility/System/g" "${D}/usr/share/applications/balena-etcher-electron.desktop"
	fperms 0755 /opt/balenaEtcher/balena-etcher-electron || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
