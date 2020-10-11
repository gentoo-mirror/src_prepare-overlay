# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LICENSE="BSD"
DESCRIPTION="The mailx utility from CentOS"
HOMEPAGE="https://www.debian.org/"
SRC_URI="https://yorune.pl/gentoo/${CATEGORY}/${PN}/${PN}_${PVR}.orig.tar.gz http://ftp.debian.org/debian/pool/main/h/${PN}/${PN}_${PVR}.orig.tar.gz"
KEYWORDS="~amd64"

DEPEND="net-libs/liblockfile
		dev-libs/libbsd
		virtual/mta
		mail-client/mailx-support"

RDEPEND="${DEPEND}
		!virtual/mailx
		!mail-client/nail
		!net-mail/mailutils
		!mail-client/mailx"

SLOT="0"

src_prepare() {
	eapply -p1 "${FILESDIR}/${PN}-${PVR}-fixes-1.patch"
	eapply_user
}

src_compile(){
	sed 's@<openssl@<openssl-1.0/openssl@' -i openssl.c fio.c makeconfig
	emake LDFLAGS+="-L /usr/lib/openssl-1.0/" SENDMAIL=/usr/sbin/sendmail
}

src_install(){
	emake PREFIX="${D}/usr" SYSCONFDIR="${D}/etc" UCBINSTALL="/usr/bin/install" install
	install -v -m755 -d     "${D}/usr/share/doc/heirloom-mailx-12.5"
	install -v -m644 README "${D}/usr/share/doc/heirloom-mailx-12.5"
}
