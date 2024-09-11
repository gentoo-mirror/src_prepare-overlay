# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="minimalistic, lightweight command line client for Jellyfin"
HOMEPAGE="https://github.com/Aanok/jftui"
SRC_URI="https://github.com/Aanok/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	net-misc/curl
	media-video/mpv
	dev-libs/yajl
"
