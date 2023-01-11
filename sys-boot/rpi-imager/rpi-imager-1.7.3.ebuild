# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake optfeature

DESCRIPTION="Raspberry Pi Imaging Utility"
HOMEPAGE="https://github.com/raspberrypi/rpi-imager"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/raspberrypi/${PN}.git"
else
	SRC_URI="https://github.com/raspberrypi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
CMAKE_USE_DIR="${S}/src"

BDEPEND="
	dev-qt/linguist-tools
"
RDEPEND="
	app-arch/libarchive
	dev-libs/openssl
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	net-misc/curl
	sys-fs/udisks:2
"
DEPEND="
	${RDEPEND}
"

IUSE="+filter-drivelist"

PATCHES=(
	"${FILESDIR}/${PV}-move-DRIVELIST_FILTER_SYSTEM_DRIVES-to-cmake-arg.patch"
)

src_configure() {
	local mycmakeargs=(
		-DENABLE_CHECK_VERSION=OFF
		-DENABLE_TELEMETRY=OFF
		-DDRIVELIST_FILTER_SYSTEM_DRIVES=$(usex filter-drivelist)
	)

	cmake_src_configure
}

pkg_postinst() {
	optfeature "writing to disk as non-root user" sys-fs/udisks
}
