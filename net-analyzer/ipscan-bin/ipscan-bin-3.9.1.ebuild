# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit unpacker xdg

DESCRIPTION="Angry IP Scanner - fast and friendly network scanner"
HOMEPAGE="https://angryip.org/"
SRC_URI="
	amd64? ( https://github.com/angryip/ipscan/releases/download/${PV}/ipscan_${PV}_amd64.deb )
"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror test"

RDEPEND="
	!net-analyzer/ipscan
	>=virtual/jre-11:*
	x11-libs/gtk+:3
"

QA_PREBUILT="*"

DESTDIR="/opt/ipscan"

src_prepare() {
	default

	# Install jar into opt instead
	sed -i -e 's|/usr/lib\*|/opt|' usr/bin/ipscan || die

	# 1. deprecated
	# 2. unregistered
	sed -i \
		-e '/Categories/ s/Application;//' \
		-e '/Categories/ s/Internet;//' \
		usr/share/applications/ipscan.desktop || die
}

src_install() {
	dobin usr/bin/ipscan

	insinto ${DESTDIR}
	doins usr/lib/ipscan/*

	insinto /usr/share
	doins -r usr/share/{applications,metainfo,pixmaps}
}
