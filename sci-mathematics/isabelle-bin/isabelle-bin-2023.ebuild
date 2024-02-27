# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

MY_P="Isabelle${PV}"

DESCRIPTION="Generic proof assistant with higher-order logic"
HOMEPAGE="https://isabelle.in.tum.de/overview.html"
SRC_URI="
	amd64? (
		https://isabelle.in.tum.de/dist/${MY_P}_linux.tar.gz
	)
	arm64? (
		https://isabelle.in.tum.de/dist/${MY_P}_linux_arm.tar.gz
	)
"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
#contrib
LICENSE+=" Apache-2.0 BitstreamVera BSD-2 CPL-1.0 EPL-1.0 GPL-2 GPL-2+ GPL-3 GPL-3-with-openssl-exception LGPL-2.1+ LPPL-1.3c MIT public-domain"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="test"

RDEPEND="
	!sci-mathematics/isabelle
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	virtual/latex-base
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/pango
"

DESTDIR="${EPREFIX}/opt/isabelle"
DOCS="ANNOUNCE CONTRIBUTORS COPYRIGHT NEWS README"
QA_PREBUILT=".*"

src_prepare() {
	default

	for platform in \
		$(usev !amd64 platform_x86_64-linux) $(usev !arm64 platform_arm64-linux) \
		platform_x86_64-cygwin platform_x86_64-darwin; do
		find "${S}" -name "${platform}" -type d -exec rm -rf {} +
	done

	# symlinks for static libraries which point to nothing
	rm -rf contrib/e-*/src/lib || die
}

src_install() {
	# lots of bundled binaries which require executable bit
	mkdir -p "${ED}/${DESTDIR}" || die
	cp -r ./* "${ED}/${DESTDIR}" || die

	local isabelle_env='env USER_HOME=${HOME}/.cache/isabelle'
	local wrap
	for wrap in ${PN} ${MY_P} Isabelle isabelle; do
		make_wrapper ${wrap} "${isabelle_env} ${DESTDIR}/${MY_P}" "${DESTDIR}"
	done

	doicon ./lib/icons/isabelle-mini.xpm
	doicon ./lib/icons/isabelle.xpm

	make_desktop_entry isabelle Isabelle isabelle "Education;Science;Math;"

	einstalldocs
}
