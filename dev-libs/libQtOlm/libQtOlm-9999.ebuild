# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Qt wrapper for libolm"
HOMEPAGE="https://gitlab.com/b0/libQtOlm"

inherit cmake

SRC_URI="https://gitlab.com/b0/libqtolm/-/archive/v3.0.1/libqtolm-v3.0.1.tar.gz"

if [[ ${PV} == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/b0/${PN}.git"
else
	SRC_URI="https://gitlab.com/b0/libqtolm/-/archive/v${PV}/libqtolm-v${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/libqtolm-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-qt/qtcore
	dev-libs/olm
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake_src_configure
}
