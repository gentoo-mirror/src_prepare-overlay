# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PV=${PV/_p*}
COMMIT="ec0ea8fa0ec10baab2f2df60aadbe9c2f1ca99b5"

DESCRIPTION="CrystalDiskInfo alternative for Linux"
HOMEPAGE="https://github.com/edisionnano/QDiskInfo"
SRC_URI="
	https://github.com/edisionnano/QDiskInfo/archive/${COMMIT}.tar.gz
		-> ${PN}-${COMMIT}.tar.gz
"
S="${WORKDIR}/QDiskInfo-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,widgets]
"
RDEPEND="${DEPEND}
	sys-apps/smartmontools
"

src_prepare() {
	cmake_src_prepare

	sed -i CMakeLists.txt \
		-e "s/QDiskInfo VERSION 0.1/QDiskInfo VERSION ${MY_PV}/" \
		-e 's/set(CMAKE_CXX_FLAGS "\(.*\)")/add_compile_options(\1)/' \
		|| die
}
