# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg cmake

DESCRIPTION="An LLE dog-themed 3DS emulator"
HOMEPAGE="https://github.com/PSI-Rockin/Corgi3DS/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PSI-Rockin/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi

RESTRICT="mirror test"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-qt/qtmultimedia:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
"
DEPEND="${RDEPEND}"

src_install() {
	einstalldocs
	dobin "${BUILD_DIR}/Corgi3DS"
	make_desktop_entry "Corgi3DS" "Corgi3DS" "${PN}" "Game;"
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "You need the following files in order to run ${PN}:"
	elog "- 3DS boot ROMs (boot9/boot11)"
	elog "- Encrypted NAND image"
	elog "Those files can be found somewhere on the Internet ;-)"
}
