 
# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A Qt5 library to write cross-platform clients for Matrix"
HOMEPAGE="https://github.com/qmatrixclient/libqmatrixclient"

inherit eutils cmake-utils

#https://github.com/quotient-im/libQuotient/archive/0.6-beta1.tar.gz
if [[ ${PV} == "9999" ]];
then
	EGIT_REPO_URI="https://github.com/quotient-im/${PN}.git"
	inherit git-r3
else
     SRC_URI="https://github.com/quotient-im/libQuotient/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-qt/qtcore
	dev-qt/qtmultimedia
	!!dev-libs/libqmatrixclient"

S="${WORKDIR}"/${PN}-${PV/_/\-}	

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}
