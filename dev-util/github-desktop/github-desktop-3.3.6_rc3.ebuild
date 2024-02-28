# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt
	lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW
"

MY_PV="${PV/_rc/-linux}"

inherit bintron-r1 unpacker

DESCRIPTION="GitHub Desktop for Linux"
HOMEPAGE="https://github.com/shiftkey/desktop"
SRC_URI="
	amd64? (
		https://github.com/shiftkey/desktop/releases/download/release-${MY_PV}/GitHubDesktop-linux-amd64-${MY_PV}.deb
	)
	arm64? (
		https://github.com/shiftkey/desktop/releases/download/release-${MY_PV}/GitHubDesktop-linux-arm64-${MY_PV}.deb
	)
	arm? (
		https://github.com/shiftkey/desktop/releases/download/release-${MY_PV}/GitHubDesktop-linux-armhf-${MY_PV}.deb
	)
"
S="${WORKDIR}/usr/lib/github-desktop"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror test"

# https://github.com/shiftkey/desktop/blob/linux-release-3.3.6/script/package-debian.ts#L61
RDEPEND="
	app-crypt/libsecret
	dev-vcs/git-lfs
	dev-vcs/git
	net-misc/curl
	sys-libs/zlib
	virtual/secret-service
"
