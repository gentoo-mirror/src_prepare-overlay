# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker bintron

DESCRIPTION="Windows 95, running in an Electron app"
HOMEPAGE="https://github.com/felixrieseberg/windows95"
SRC_URI="https://github.com/felixrieseberg/${PN}/releases/download/v${PV}/${PN}_${PV}_amd64.deb"
S="${WORKDIR}/usr/lib/${PN}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="-* ~amd64"

src_install() {
	domenu ../../share/applications/${PN}.desktop
	doicon ../../share/pixmaps/${PN}.png

	bintron_src_install
}
