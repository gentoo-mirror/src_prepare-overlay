# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop gnome2-utils multilib unpacker xdg

MY_PN="ONLYOFFICE-DesktopEditors"
MY_P="${MY_PN}-${PVR//r}"

DESCRIPTION="onlyoffice is an office productivity suite (binary version)"
HOMEPAGE="https://www.onlyoffice.com/"

KEYWORDS="~amd64"

SRC_URI="
	amd64? (
		https://github.com/ONLYOFFICE/DesktopEditors/releases/download/${MY_P}/${PN/bin/desktopeditors}_amd64.deb -> ${MY_P}_amd64.deb
	)
"

SLOT="0"
RESTRICT="mirror strip"
LICENSE="AGPL-3"

RDEPEND="
	x11-libs/gtk+:3
	dev-libs/nss
	x11-libs/libXScrnSaver
	x11-libs/pixman
	media-gfx/graphite2
"

RDEPEND="
	${DEPEND}
	dev-db/sqlite:3
	net-libs/libcurl-gnutls
	!app-office/onlyoffice
"

S="${WORKDIR}"

src_unpack(){
	unpack_deb ${A}
}

src_install() {
	mkdir -p "${D}"
	cp -r . "${D}"
	local res
	for res in 16 24 32 48 64 128 256; do
		doicon -s ${res} opt/onlyoffice/desktopeditors/asc-de-${res}.png
	done
}
