# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit cmake optfeature python-any-r1 xdg

DESCRIPTION="Raspberry Pi Imaging Utility"
HOMEPAGE="https://github.com/raspberrypi/rpi-imager"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/raspberrypi/rpi-imager.git"
else
	SRC_URI="https://github.com/raspberrypi/rpi-imager/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="qt6 +filter-drivelist test"
RESTRICT="test !test? ( test )" # requires network and extra permissions to write

RDEPEND="
	app-arch/libarchive:=
	app-arch/xz-utils
	net-libs/gnutls:=
	net-misc/curl
	!qt6? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtquickcontrols2:5
		dev-qt/qtwidgets:5
	)
	qt6? (
		dev-qt/qtbase:6[dbus,gui,network,widgets]
		dev-qt/qtdeclarative:6
	)
"
DEPEND="
	${RDEPEND}
	!qt6? (
		dev-qt/qtsvg:5
	)
	qt6? (
		dev-qt/qtsvg:6
	)
"
BDEPEND="
	!qt6? ( dev-qt/linguist-tools )
	test? (
		${PYTHON_DEPS}
		$(python_gen_any_dep '
			dev-python/jsonschema[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/urllib3[${PYTHON_USEDEP}]
		')
	)
"

PATCHES=(
	#https://github.com/raspberrypi/rpi-imager/pull/816
	"${FILESDIR}/rpi-imager-1.8.5-expose-DRIVELIST_FILTER_SYSTEM_DRIVES.patch"
)

CMAKE_USE_DIR="${S}/src"

python_check_deps() {
	python_has_version "dev-python/jsonschema[${PYTHON_USEDEP}]" \
		&& python_has_version "dev-python/pytest[${PYTHON_USEDEP}]" \
		&& python_has_version "dev-python/urllib3[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CHECK_VERSION=OFF
		-DENABLE_TELEMETRY=OFF
		-DDRIVELIST_FILTER_SYSTEM_DRIVES=$(usex filter-drivelist)
		$(cmake_use_find_package !qt6 Qt5)
	)

	cmake_src_configure
}

src_test() {
	epytest tests
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "writing to disk as non-root user" sys-fs/udisks:2
}
