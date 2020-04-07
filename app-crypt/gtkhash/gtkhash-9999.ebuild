# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils linux-info xdg-utils

DESCRIPTION="A cross-platform desktop utility for computing message digests or checksums"
HOMEPAGE="https://github.com/tristanheaven/gtkhash"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tristanheaven/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/tristanheaven/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="
	+blake2
	caja
	debug
	-gtk2
	+gtk3
	+gcrypt
	+linux-crypto
	libressl
	mbedtls
	nautilus
	nemo
	nettle
	nls
	+openssl
	thunar
	+zlib
"
REQUIRED_USE="
	gtk3? ( !gtk2 )
	|| ( gtk3 gtk2 )
	openssl? ( !libressl )
	|| ( openssl libressl )
"

BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	app-crypt/mhash
	dev-libs/glib:2
	blake2? (
		app-crypt/libb2
	)
	caja? (
		mate-base/caja
		mate-extra/caja-extensions
	)
	!gtk3? (
		gtk2? (
			x11-libs/gtk+:2
		)
	)
	gtk3? (
		x11-libs/gtk+:3
	)
	gcrypt? (
		dev-libs/libgcrypt
	)
	mbedtls? (
		net-libs/mbedtls
	)
	nautilus? (
		gnome-base/nautilus
	)
	nemo? (
		gnome-extra/nemo
	)
	nettle? (
		dev-libs/nettle
	)
	!libressl? (
		openssl? (
			>=dev-libs/openssl-1.1.1d
		)
	)
	libressl? (
		dev-libs/libressl
	)
	thunar? (
		>=xfce-base/thunar-1.8.12
	)
	zlib? (
		sys-libs/zlib
	)
"
DEPEND="
	${RDEPEND}
	dev-util/intltool
	gnome-base/librsvg
	nls? (
		 sys-devel/gettext
	)
"

pkg_setup() {
	if use linux-crypto; then
		local CONFIG_CHECK="~CRYPTO_USER_API_HASH"
		local WARNING_CRYPTO_USER_API_HASH="CONFIG_CRYPTO_USER_API_HASH is required for hash algorithm interface"
		check_extra_config
	fi
}

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local econfargs=(
		$(use_enable blake2)
		$(use_enable caja)
		$(use_enable debug)
		$(use_enable gcrypt)
		$(use_enable libressl libcrypto)
		$(use_enable linux-crypto)
		$(use_enable mbedtls)
		$(use_enable nautilus)
		$(use_enable nemo)
		$(use_enable nettle)
		$(use_enable nls)
		$(use_enable openssl libcrypto)
		$(use_enable thunar)
		$(use_enable zlib)
		--enable-appstream
		--enable-glib-checksums
		--enable-gtkhash
		--enable-internal-md6
	)

	if use gtk3; then
		econfargs+=( $(use_with gtk3 gtk 3.0) )
	elif use gtk2; then
		econfargs+=( $(use_with gtk2 gtk 2.0) )
	fi

	econf "${econfargs[@]}"
}

pkg_preinst() {
	gnome2_schemas_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
