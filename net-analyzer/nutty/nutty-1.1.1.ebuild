# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/granite
	x11-libs/gtk+:3
"
RDEPEND="
	${DEPEND}
	dev-db/sqlite
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

DOCS=( AUTHORS README.md )

src_prepare() {
	xdg_src_prepare
	vala_src_prepare
	default
}

src_configure() {
	meson_src_configure
}

src_install() {
	meson_src_install
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_preinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
