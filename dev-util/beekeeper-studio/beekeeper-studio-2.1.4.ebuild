# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker bintron

DESCRIPTION="Modern and easy to use SQL client"
HOMEPAGE="https://www.beekeeperstudio.io/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${PN}_${PV}_amd64.deb"
S="${WORKDIR}/opt/Beekeeper Studio"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

src_install() {
	local size
	for size in 16 24 32 48 64 96 128 256 512; do
		doicon --size ${size}  \
			../../usr/share/icons/hicolor/${size}x${size}/apps/${PN}.png
	done
	make_desktop_entry ${PN} "Beekeeper Studio" ${PN} "Development;"

	bintron_src_install
}
