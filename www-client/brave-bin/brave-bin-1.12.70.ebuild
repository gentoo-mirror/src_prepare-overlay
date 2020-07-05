# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BRAVE_PN="${PN/-bin/}"

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW
"

inherit chromium-2 desktop eutils xdg-utils

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"
SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/brave-v${PV}-linux-x64.zip -> ${P}.zip"

RESTRICT="mirror"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring"

DEPEND="
	!www-client/brave
"
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
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
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

S="${WORKDIR}"

src_prepare() {
	pushd "${S}/locales" >/dev/null || die
	chromium_remove_language_paks
	popd >/dev/null || die

	default
}

src_install() {
	declare BRAVE_HOME="/opt/${BRAVE_PN}"

	dodir "${BRAVE_HOME%/*}"

	insinto "${BRAVE_HOME}"
	doins -r *

	exeinto "${BRAVE_HOME}"
	doexe brave

	dosym "${BRAVE_HOME}/brave" "/usr/bin/${BRAVE_PN}" || die
	dosym "${BRAVE_HOME}/brave" "/usr/bin/${PN}" || die

	make_desktop_entry "brave" "Brave" "brave" "Network;WebBrowser;"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
