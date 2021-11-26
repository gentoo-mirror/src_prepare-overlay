# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High-level C++ D-Bus library for Linux"
HOMEPAGE="https://github.com/Kistler-Group/sdbus-cpp/"

SYSTEMDVER="242"
SRC_URI="
	https://github.com/Kistler-Group/sdbus-cpp/archive/v${PV}.tar.gz -> sdbus-cpp-"${PV}".tar.gz
	!systemd? ( https://github.com/systemd/systemd-stable/archive/v"${SYSTEMDVER}".tar.gz -> systemd-stable-"${SYSTEMDVER}".tar.gz )
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="
	systemd? ( sys-apps/systemd )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

CMAKE_MAKEFILE_GENERATOR=emake # ninja cant handle external projects for some reason

PATCHES=( "${FILESDIR}/remove_download_from_external_project.patch" )

src_prepare() {
	cmake_src_prepare
	use systemd || mv "${WORKDIR}"/systemd-stable-"${SYSTEMDVER}" "${S}"_build/systemd || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_CODE_GEN=ON # possibly could be use controlled instead
		-DBUILD_LIBSYSTEMD=$(usex !systemd)
	)
	cmake_src_configure
}
