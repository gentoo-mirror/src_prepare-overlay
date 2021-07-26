# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="b1cddc13149014362a984902cc0cbe4fba28cf05"

SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-"${COMMIT}".tar.gz -> "${P}".tar.gz
	https://archive.mozilla.org/pub/firefox/releases/89.0/KEY -> Mozilla_pgp_key-20210507.pgp
"

LICENSE="GPL-3"
SLOT="${PV}"
KEYWORDS="~amd64"

IUSE="+buildtarball"

RESTRICT="buildtarball? ( network-sandbox )"

RDEPEND="${BDEPEND}"
BDEPEND="
	app-crypt/gnupg
	dev-vcs/mercurial
	dev-perl/File-Rename
"

S=""${WORKDIR}"/gnuzilla-"${COMMIT}""

src_prepare() {
	default_src_prepare
	# Making sure that latest Mozilla public key is available for verying the firefox tarball
	gpg --import "${DISTDIR}/Mozilla_pgp_key-20210507.pgp" || die
}

src_compile() {
	if use buildtarball; then
		./makeicecat || die
	fi
}

src_install() {
	insinto /usr/src/makeicecat-"${PV}"
	doins -r "${S}"/{artwork,CHANGELOG,COPYING,data,makeicecat,README,tools}
	fperms +x /usr/src/makeicecat-"${PV}"/{makeicecat,tools/{AddonsScraper.py,buildbinaries,createdebsrcrepo,gnupload}}
	if use buildtarball; then
		insinto /usr/src/makeicecat-"${PV}"/output
		doins "${S}"/output/icecat-"${PV}"-gnu1.tar.bz2
	fi
}

pkg_postinst() {
	if ! use buildtarball; then
		einfo "You haven't enabled buildtarball, therefore you have to create the tarball yourself."
		einfo "You can create the tarball in /usr/share/makeicecat-"${PV}" by starting the script manually."
		einfo "   ./makeicecat"
		einfo "It will take a while so be prepared."
	fi
}
