# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="A simple application to provide essential information on network related aspects"
HOMEPAGE="https://github.com/babluboy/nutty"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/babluboy/${PN}.git"
else
	SRC_URI="https://github.com/babluboy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

# tests are just data file validation
RESTRICT="test"

DEPEND="
	>=dev-db/sqlite-3.5.9:3
	>=dev-libs/granite-0.5:=
	>=dev-libs/libgee-0.8:=
	dev-libs/glib:2
	dev-libs/libxml2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libnotify
"
RDEPEND="
	${DEPEND}
	net-analyzer/nethogs
	net-analyzer/nmap
	net-analyzer/traceroute
	net-analyzer/vnstat
	net-misc/curl
	net-wireless/wireless-tools
	sys-apps/iproute2
	sys-apps/net-tools
	sys-apps/pciutils
"
BDEPEND="
	sys-devel/gettext
"

DOCS=( AUTHORS README.md )

pkg_setup() {
	vala_setup
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
