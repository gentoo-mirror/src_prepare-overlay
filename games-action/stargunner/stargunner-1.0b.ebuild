# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Horizontal shooter by Apogee. Their last game, in fact."
HOMEPAGE="https://3drealms.com/catalog/stargunner_45/"

LICENSE+=" Stargunner_freeware"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

SRC_URI="
	https://image.dosgamesarchive.com/games/stargunnerfreeware.zip
"

BDEPEND+="
	app-arch/unzip
	app-arch/unrar
	sys-apps/coreutils
"

RDEPEND+="
	games-emulation/dosbox
"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	unzip "${DISTDIR}"/stargunnerfreeware.zip
	mkdir stargunner
	unrar x stargunnerfreeware.exe stargunner
	cp "${FILESDIR}"/dosbox.conf stargunner
	cp "${FILESDIR}"/STARGUN.CFG stargunner
}

src_install() {
	insinto /usr/share/games
	doins -r stargunner
#	insinto /usr/share/pixmaps
#	doins stargunner.png
#	insinto /usr/share/applications
#	doins "${FILESDIR}/stargunner.desktop"
	dobin "${FILESDIR}"/stargunner
}
