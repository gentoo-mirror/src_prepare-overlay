# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="libcurl libraries linked with gnutls"
HOMEPAGE="https://curl.haxx.se"
MIRROR_URI="https://mirror.rackspace.com/archlinux"
SRC_URI="
	amd64? (
		${MIRROR_URI}/community/os/x86_64/${PN}-${PV}-1-x86_64.pkg.tar.zst
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror strip"

DEPEND="net-misc/curl[-curl_ssl_gnutls]"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

QA_PRESTRIPPED="
	/usr/lib/libcurl-gnutls-4.5.0
	/usr/lib64/libcurl-gnutls-4.5.0
	/usr/lib/libcurl-gnutls-4.6.0
	/usr/lib64/libcurl-gnutls-4.6.0
"

src_install(){
	mkdir -p "${D}/usr/$(get_libdir)"
	cp -r usr/lib/. "${D}/usr/$(get_libdir)"
	mkdir -p "${D}/usr/lib"
	cp -r usr/lib32/* "${D}/usr/lib/"
}
