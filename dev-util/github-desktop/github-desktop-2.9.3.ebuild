# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker bintron

DESCRIPTION="GitHub Desktop for Linux"
HOMEPAGE="https://github.com/shiftkey/desktop"
SRC_URI="https://github.com/shiftkey/desktop/releases/download/release-${PV}-linux3/GitHubDesktop-linux-${PV}-linux3.deb -> ${P}.deb"
S="${WORKDIR}/usr/lib/github-desktop"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

src_install() {
	domenu ../../share/applications/github-desktop.desktop

	local size
	for size in 32 64 128 256 512; do
		doicon --size ${size}  \
			../../share/icons/hicolor/${size}x${size}/apps/github-desktop.png
	done

	bintron_src_install
}
