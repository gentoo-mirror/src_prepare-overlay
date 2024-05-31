# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BINTRON_NAME="figma-linux"

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt
	lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit bintron-r1 unpacker

DESCRIPTION="Unofficial desktop client for Figma - collaborative interface design tool"
HOMEPAGE="https://github.com/Figma-Linux/figma-linux"
SRC_URI="
	amd64? (
		https://github.com/Figma-Linux/figma-linux/releases/download/v${PV}/figma-linux_${PV}_linux_amd64.deb
	)
	arm64? (
		https://github.com/Figma-Linux/figma-linux/releases/download/v${PV}/figma-linux_${PV}_linux_arm64.deb
	)
"
S="${WORKDIR}/opt/figma-linux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror test"

src_prepare() {
	bintron-r1_src_prepare

	# Remove all unnecessary bundled libs
	rm -r lib usr || die
}
