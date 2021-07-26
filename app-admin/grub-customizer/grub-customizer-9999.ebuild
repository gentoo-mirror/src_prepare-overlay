# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="A graphical grub2 settings manager"
HOMEPAGE="https://launchpad.net/grub-customizer"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.launchpad.net/${PN}"
else
	PB="$(ver_cut 1-2)"
	SRC_URI="https://launchpad.net/${PN}/${PB}/${PV}/+download/${PN}_${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-cpp/gtkmm:3.0
	x11-themes/hicolor-icon-theme
	sys-boot/grub:2
	app-arch/libarchive
"
RDEPEND="
	${DEPEND}
"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
