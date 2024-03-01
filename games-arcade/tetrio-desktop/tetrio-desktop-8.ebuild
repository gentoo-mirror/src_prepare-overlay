# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt
	lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW
"

inherit bintron-r1 unpacker

DESCRIPTION="TETR.IO desktop client"
HOMEPAGE="https://tetr.io/"
SRC_URI="https://tetr.io/about/desktop/builds/${PV}/TETR.IO%20Setup.deb -> ${P}.deb"
S="${WORKDIR}/opt/TETR.IO"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror test"

RDEPEND="
	x11-libs/gdk-pixbuf:2
	x11-libs/libXScrnSaver
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
"

QA_PREBUILT=".*"
