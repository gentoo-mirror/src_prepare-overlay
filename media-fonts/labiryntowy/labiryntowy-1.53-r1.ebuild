# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font rpm

DESCRIPTION="Practical font realization of the Labirynth Alphabet"
HOMEPAGE="
	https://koschei.fedoraproject.org/package/labiryntowy-fonts
	http://alfabet-ozdobny.appspot.com/?str=labiryntowy
"
SRC_URI="
	http://fedora.osuosl.org/linux/releases/40/Everything/x86_64/os/Packages/l/labiryntowy-fonts-1.53-20.fc40.noarch.rpm
"
S="${WORKDIR}"

LICENSE="OFL-1.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

src_install() {
	newdoc "./usr/share/doc/${PN}-fonts/opis.txt" README.txt

	insinto "/usr/share/fonts/${PN}"
	doins "./usr/share/fonts/${PN}"/*
}
