# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High-level C++ D-Bus library for Linux"
HOMEPAGE="https://github.com/Kistler-Group/sdbus-cpp/"
SRC_URI="
	https://github.com/Kistler-Group/sdbus-cpp/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples systemd test"
RESTRICT="!test? ( test )"

CDEPEND="
	systemd? ( >=sys-apps/systemd-236 )
	!systemd? ( >=sys-auth/elogind-236 )
"
DEPEND="
	${CDEPEND}
	test? (
		dev-cpp/gtest
	)
"
RDEPEND="
	${CDEPEND}
"
BDEPEND="
	virtual/pkgconfig
	test? (
		sys-apps/dbus
	)
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_CODE_GEN=ON
		-DBUILD_LIBSYSTEMD=OFF
		-DBUILD_TESTS=$(usex test)
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_DOC=$(usex doc)
	)
	cmake_src_configure
}

src_test() {
	local myctestargs=(
		# Requires system level configs for dbus
		--exclude-regex integration-tests
	)
	cmake_src_test
}
