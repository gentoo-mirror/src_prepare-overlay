# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs xdg cmake

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="https://github.com/thezbyg/gpick"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thezbyg/${PN}.git"
else
	SRC_URI="https://github.com/thezbyg/${PN}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror test"
LICENSE="BSD"
SLOT="0"
IUSE="gtk2 nls"

BDEPEND="
	dev-util/ragel
"
DEPEND="
	>=dev-libs/boost-1.74.0
	dev-lang/lua:*
	dev-libs/expat
	gtk2? ( x11-libs/gtk+:2 )
	!gtk2? ( x11-libs/gtk+:3 )
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/gpick-gpick-${PV}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DENABLE_NLS=$(usex nls ON OFF)
		# gtk3 == no gtk2
		-DUSE_GTK3=$(usex gtk2 OFF ON)
	)
	cmake_src_configure
}

src_install() {
	# DEBUG: cmake_src_install doesn't install libs
	pushd "${BUILD_DIR}" || die
	exeinto "/usr/$(get_libdir)"
	local l
	for l in *.so
	do
		doexe "${l}"
	done
	popd || die

	cmake_src_install

	# DEBUG: Correct doc path
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${P}" || die
}
