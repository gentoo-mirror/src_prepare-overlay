# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"

inherit wrapper desktop xdg

DESCRIPTION="Angry IP Scanner - fast and friendly network scanner"
HOMEPAGE="https://angryip.org/"
SRC_URI="https://github.com/angryip/${MY_PN}/releases/download/${PV}/${MY_PN}-linux64-${PV}.jar -> ${P}.jar"
S="${DISTDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror strip test"

RDEPEND="
	>=virtual/jre-1.7:*
	x11-libs/gtk+:3
"

src_unpack() {
	# Don't unpack; instead:
	if ! use amd64
	then
		die "Unsupported architecture"
	fi
}

src_install() {
	insinto "/opt/${PN}"
	newins "${P}.jar" "${PN}.jar"

	make_wrapper "${PN}" "java -jar /opt/${PN}/${PN}.jar"
	# TODO: icon is ipscan (we relay on 3rd party icons)
	make_desktop_entry "${PN}" "${PN}" "${MY_PN}" "Network;"
}
