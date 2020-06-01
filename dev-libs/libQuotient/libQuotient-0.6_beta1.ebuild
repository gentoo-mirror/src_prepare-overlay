<<<<<<< HEAD
# Copyright 1999-2017 Gentoo Foundation
=======
# Copyright 2020 Gentoo Authors
>>>>>>> upstream/master
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Qt5 library to write cross-platform clients for Matrix"
HOMEPAGE="https://github.com/qmatrixclient/libqmatrixclient"

inherit eutils cmake-utils

<<<<<<< HEAD

if [[ ${PV} == "9999" ]];
then
	EGIT_REPO_URI="https://github.com/quotient-im/${PN}.git"
=======
MY_PV="$(ver_rs 2 '-')"

if [[ ${PV} == "9999" ]]; then
>>>>>>> upstream/master
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quotient-im/${PN}.git"
else
<<<<<<< HEAD
     SRC_URI="https://github.com/quotient-im/libQuotient/archive/0.6-beta1.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
=======
	SRC_URI="https://github.com/quotient-im/libQuotient/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
>>>>>>> upstream/master
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-qt/qtcore
	dev-qt/qtmultimedia
	!!dev-libs/libqmatrixclient
"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}
