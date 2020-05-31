 
# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A Qt wrapper for libolm"
HOMEPAGE="https://gitlab.com/b0/libQtOlm"

inherit eutils cmake-utils 

SRC_URI="https://gitlab.com/b0/libqtolm/-/archive/v3.0.1/libqtolm-v3.0.1.tar.gz"

if [[ ${PV} == 9999 ]]
then
	EGIT_REPO_URI="https://gitlab.com/b0/${PN}.git"
	EGIT_COMMIT="v${PV}"
	inherit git-r3
else
    SRC_URI="https://gitlab.com/b0/libqtolm/-/archive/v${PV}/libqtolm-v${PV}.tar.gz"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-qt/qtcore
	dev-libs/olm"
	
S="${WORKDIR}"/libqtolm-v3.0.1
	
src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}
