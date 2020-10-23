# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Raspberry Pi Imaging Utility"
HOMEPAGE="https://github.com/raspberrypi/rpi-imager"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/raspberrypi/${PN}.git"
else
	SRC_URI="https://github.com/raspberrypi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="debug"

BDEPEND="
	app-arch/libarchive
	net-misc/curl
"
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	sys-fs/udisks:2
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=$(usex debug Debug Release)
	)

	cmake_src_configure
}
