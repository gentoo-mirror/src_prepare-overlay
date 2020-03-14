# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Burglary simulator"
HOMEPAGE="https://web.archive.org/web/20090106121638/http://www.thesting-thegame.com/frameset-d.htm"

LICENSE="neoSoftware"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-emulation/wine-vanilla[abi_x86_32]
	app-arch/unshield"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	if [ -z ${CDROM_ROOT} ]; then
		die "CDROM_ROOT must be set in order to install TheSting."
	fi
	unshield -d . x ${CDROM_ROOT}/Data1.cab
	rm -rf _*
	cp ${CDROM_ROOT}/Setup/Sting.exe Program_Files
	cp ${CDROM_ROOT}/'TheSting!.exe' Program_Files
	cp -r ${CDROM_ROOT}/Game Program_Files
	cp "${FILESDIR}"/clou2.reg Program_Files
	mv Program_Files clou2
}

src_install() {
	insinto /usr/share/games
	doins -r *
	dobin "${FILESDIR}/clou2"
}
