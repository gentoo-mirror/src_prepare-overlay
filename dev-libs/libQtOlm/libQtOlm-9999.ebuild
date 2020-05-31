 
# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A Qt wrapper for libolm"
HOMEPAGE="https://gitlab.com/b0/libQtOlm"

inherit eutils cmake-utils git-r3

SRC_URI=""
EGIT_REPO_URI="https://gitlab.com/b0/${PN}.git"
if [[ ${PV} != "9999" ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-qt/qtcore
	dev-libs/olm"
src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}
