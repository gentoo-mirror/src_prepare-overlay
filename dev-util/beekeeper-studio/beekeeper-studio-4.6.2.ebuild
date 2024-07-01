# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt
	lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW
"

inherit bintron-r1 unpacker

DESCRIPTION="Modern and easy to use SQL client"
HOMEPAGE="https://www.beekeeperstudio.io/"
SRC_URI="
	amd64? (
		https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v${PV}/beekeeper-studio_${PV}_amd64.deb
	)
"
S="${WORKDIR}/opt/Beekeeper Studio"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror test"

BINTRON_HOME="/opt/Beekeeper Studio/"

src_prepare() {
	bintron-r1_src_prepare

	# MimeType" in group "Desktop Entry" contains "application/vnd.sqlite3" more than once
	sed -i \
		-e 's|application/vnd.sqlite3;application/vnd.sqlite3;application/vnd.sqlite3;|application/vnd.sqlite3;|' \
		"${WORKDIR}/usr/share/applications/beekeeper-studio.desktop" || die
}
