# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt
	lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit bintron-r1 unpacker

DESCRIPTION="Windows 95, running in an Electron app"
HOMEPAGE="https://github.com/felixrieseberg/windows95"
SRC_URI="
	amd64? (
		https://github.com/felixrieseberg/${PN}/releases/download/v${PV}/${PN}_${PV}_amd64.deb
	)
	arm64? (
		https://github.com/felixrieseberg/${PN}/releases/download/v${PV}/${PN}_${PV}_arm64.deb
	)
	arm? (
		https://github.com/felixrieseberg/${PN}/releases/download/v${PV}/${PN}_${PV}_armhf.deb
	)
"

S="${WORKDIR}/usr/lib/${PN}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	dev-libs/wayland
"
