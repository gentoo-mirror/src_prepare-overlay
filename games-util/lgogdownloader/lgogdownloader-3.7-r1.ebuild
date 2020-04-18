# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Unofficial GOG.com downloader for Linux with patchset that allows integration with Portage"
HOMEPAGE="https://sites.google.com/site/gogdownloader/"
SRC_URI="https://sites.google.com/site/gogdownloader/${P}.tar.gz"
LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gui portage"

RDEPEND=">=app-crypt/rhash-1.3.3-r2:0=
	dev-cpp/htmlcxx:0=
	dev-libs/boost:0=
	>=dev-libs/jsoncpp-1.7:0=
	dev-libs/tinyxml2:0=
	>=net-misc/curl-7.32:0=[ssl]
	gui? ( dev-qt/qtwebengine:5=[widgets] )
	portage? (	app-shells/bash
			sys-apps/coreutils
			app-arch/xz-utils
			app-arch/tar
			sys-apps/sed
	)"

DEPEND="${RDEPEND}"

BDEPEND="sys-apps/help2man
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DUSE_QT_GUI=$(usex gui)
	)
	if use portage; then
		patch -p1 < ${FILESDIR}/0001-recycle-cookies-and-tokens.patch
	fi
	cmake_src_configure
}

src_install() {
	cmake_src_install
	gunzip "${ED}"/usr/share/man/man1/${PN}.1.gz || die
	if use portage; then
		dobin ${FILESDIR}/export_gog_to_portage
	fi
}
