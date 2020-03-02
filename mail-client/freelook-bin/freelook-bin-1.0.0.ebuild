# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=electron-outlook
MY_P="${MY_PN}_${PV}"

inherit unpacker xdg-utils

DESCRIPTION="Freelook, an Electron-based client for Microsoft Outlook"
HOMEPAGE="https://github.com/eNkru/freelook"
SRC_URI="https://github.com/eNkru/${PN//-bin}/releases/download/v${PV}/${MY_P}_amd64.deb"
RESTRICT="bindist mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	>=net-print/cups-2.0.0
	dev-libs/libappindicator
	dev-libs/nss
	gnome-base/gconf:2
	x11-libs/libXtst
	x11-libs/libnotify
"

QA_PREBUILT="
	/opt/Freelook/*
"

S="${WORKDIR}"

pkg_setup() {
	use amd64 || die "Arch not supported"
}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	mv * "${D}" || die
	rm -rd "${D}/usr/share/doc"
	dosym "../../opt/Freelook/${MY_PN}" "${EROOT}usr/bin/${MY_PN}"
}

pkg_postinst() {
	xdg_icon_cache_update
	elog "Keep in mind that Freelook binary is named electron-outlook..."
}

pkg_postrm() {
	xdg_icon_cache_update
}
