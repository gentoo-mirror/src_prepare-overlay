# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Neko is a high-level dynamically typed programming language"
HOMEPAGE="https://nekovm.org/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HaxeFoundation/${PN}.git"
else
	MY_PV=${PV//./-}
	SRC_URI="https://github.com/HaxeFoundation/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

RESTRICT="mirror test"
LICENSE="MIT"
SLOT="0"
IUSE="apache gtk2 mysql sqlite ssl"

DEPEND="
	apache? ( www-servers/apache:2 )
	gtk2?   ( x11-libs/gtk+:2      )
	mysql?  ( dev-db/mysql:*       )
	sqlite? ( dev-db/sqlite        )
	ssl?    ( dev-libs/openssl     )

	dev-libs/boehm-gc
	dev-libs/libpcre
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_APACHE=$(usex apache)
		-DWITH_MYSQL=$(usex mysql)
		-DWITH_NEKOML=ON
		-DWITH_REGEXP=ON
		-DWITH_SQLITE=$(usex sqlite)
		-DWITH_SSL=$(usex ssl)
		-DWITH_UI=$(usex gtk2)
	)
	cmake_src_configure
}
