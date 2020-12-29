# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A very simple convenience library for handling properties and signals in C++11"
HOMEPAGE="https://github.com/lib-cpp/properties-cpp"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lib-cpp/properties-cpp"
else
	COMMIT="45863e849b39c4921d6553e6d27e267a96ac7d77" # 9.4.2018
	SRC_URI="https://github.com/lib-cpp/properties-cpp/archive/"${COMMIT}".tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc"

DEPEND="
	doc? ( app-doc/doxygen )
	dev-cpp/gtest
"

src_prepare() {
	# Provided FindGtest tries (and fails) to build its own version of gtest rather than actually search for it on the system
	cp "${FILESDIR}"/FindGtest.cmake cmake/FindGtest.cmake || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPROPERTIES_CPP_ENABLE_DOC_GENERATION=$(usex doc)
	)
	cmake_src_configure
}
