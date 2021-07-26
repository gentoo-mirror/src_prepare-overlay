# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font rpm

DESCRIPTION="Practical font realization of the Labirynth Alphabet"
HOMEPAGE="
	https://koschei.fedoraproject.org/package/labiryntowy-fonts
	http://alfabet-ozdobny.appspot.com/?str=labiryntowy
"
SRC_URI="http://fedora.osuosl.org/linux/releases/33/Everything/x86_64/os/Packages/l/${PN}-fonts-${PV}-12.fc33.noarch.rpm -> ${P}.rpm"
KEYWORDS="~amd64"

RESTRICT="mirror"
LICENSE="OFL"
SLOT="0"

S="${WORKDIR}"

src_install() {
	newdoc "./usr/share/doc/${PN}-fonts/opis.txt" README.txt

	insinto "/usr/share/fonts/${PN}"
	doins "./usr/share/fonts/${PN}"/*
}
