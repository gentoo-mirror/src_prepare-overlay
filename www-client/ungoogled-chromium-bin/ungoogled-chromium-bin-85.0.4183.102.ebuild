# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

UNGCH_PN="${PN/-bin/}"
UNGCH_PV="${PV}-1.1"

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW
"

inherit chromium-2 desktop eutils xdg

DESCRIPTION="Google Chromium, sans integration with Google (binary package)"
HOMEPAGE="https://ungoogled-software.github.io/"
SRC_URI="https://github.com/Eloston/ungoogled-chromium-binaries/releases/download/${UNGCH_PV}/ungoogled-chromium_${UNGCH_PV}_linux.tar.xz -> ${P}.tar.xz
"

RESTRICT="mirror"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring"

RDEPEND="
	${DEPEND}
	>=media-libs/libpng-1.6.34
	>=net-print/cups-2.0.0
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	app-arch/bzip2
	dev-libs/atk
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/gmp
	dev-libs/gobject-introspection
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libpcre
	dev-libs/libpthread-stubs
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nettle
	dev-libs/nspr
	dev-libs/nss
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	net-dns/libidn2
	net-libs/gnutls
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/libxcb
	x11-libs/libxshmfence
	x11-libs/pango
	x11-libs/pixman
"

QA_PREBUILT="*"

S="${WORKDIR}/${UNGCH_PN}_${UNGCH_PV}_linux"

src_prepare() {
	pushd "${S}/locales" || die
	chromium_remove_language_paks
	popd || die

	default
}

src_install() {
	declare UNGCH_HOME="/opt/${PN}"
	dodir "${UNGCH_HOME%/*}"

	insinto "${UNGCH_HOME}"
	doins -r *

	exeinto "${UNGCH_HOME}"
	doexe chrome

	dosym "${UNGCH_HOME}/chrome" "${UNGCH_HOME}/${UNGCH_PN}"
	dosym "${UNGCH_HOME}/${UNGCH_PN}" "/usr/bin/${PN}"

	make_desktop_entry "${PN}" "${UNGCH_PN^} (binary)" "chromium" "Network;WebBrowser;"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	elog "Some versions have cleaning cookies on browser exit enabled by default."
	elog "This can be toggled in the browser settings."
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
