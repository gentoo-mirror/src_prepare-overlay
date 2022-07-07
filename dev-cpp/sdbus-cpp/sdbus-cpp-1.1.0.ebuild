# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High-level C++ D-Bus library for Linux"
HOMEPAGE="https://github.com/Kistler-Group/sdbus-cpp/"

SYSTEMDVER="251"
SRC_URI="
	https://github.com/Kistler-Group/sdbus-cpp/archive/v${PV}.tar.gz -> ${P}.tar.gz
	!systemd? ( https://github.com/systemd/systemd-stable/archive/v"${SYSTEMDVER}".tar.gz -> systemd-stable-"${SYSTEMDVER}".tar.gz )
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples systemd test"
RESTRICT="!test? ( test )"

CDEPEND="
	systemd? ( sys-apps/systemd )
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

PATCHES=( "${FILESDIR}/remove_download_from_external_project.patch" )

src_prepare() {
	cmake_src_prepare
	use systemd || mv "${WORKDIR}"/systemd-stable-"${SYSTEMDVER}" "${S}"_build/systemd || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_CODE_GEN=ON
		-DBUILD_LIBSYSTEMD=$(usex !systemd)
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
