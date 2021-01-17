# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Qt5 library to write cross-platform clients for Matrix"
HOMEPAGE="https://matrix.org/docs/projects/sdk/quotient"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/quotient-im/"${PN}".git"
else
	SRC_URI="https://github.com/quotient-im/libQuotient/archive/"${PV}".tar.gz -> "${P}".tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/libQuotient-${PV}"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="e2e"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	e2e? ( dev-libs/libQtOlm )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-no-android.patch
	"${FILESDIR}"/${P}-no-tests.patch
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DQuotient_ENABLE_E2EE=$(usex e2e)
		-DUSE_INTREE_LIBQOLM=OFF
		-DQuotient_INSTALL_TESTS=OFF
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
	)
	cmake_src_configure
}
