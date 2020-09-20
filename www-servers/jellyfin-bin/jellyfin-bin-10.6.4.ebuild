# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN//-bin}"
BASE_URI="https://repo.jellyfin.org/releases/server/debian/versions/stable/"

# No 'webapp' here because this is a server
inherit eutils unpacker systemd

DESCRIPTION="The Free Software Media System"
HOMEPAGE="https://jellyfin.org"
SRC_URI="
	amd64? (
		${BASE_URI}/server/${PV}/${MY_PN}-server_${PV}-1_amd64.deb -> ${P}-server-${ARCH}.deb
	)
	arm64? (
		${BASE_URI}/server/${PV}/${MY_PN}-server_${PV}-1_arm64.deb -> ${P}-server-${ARCH}.deb
	)
	${BASE_URI}/web/${PV}/${MY_PN}-web_${PV}-1_all.deb -> ${P}-web.deb
"

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""

DEPEND=""
RDEPEND="
	>=media-video/ffmpeg-4.2.2
	dev-db/sqlite
	media-libs/fontconfig
	media-libs/freetype
"

QA_PRESTRIPPED="
	usr/lib/jellyfin/bin/System.Globalization.Native.so
	usr/lib/jellyfin/bin/System.IO.Compression.Native.so
	usr/lib/jellyfin/bin/System.Native.so
	usr/lib/jellyfin/bin/System.Net.Http.Native.so
	usr/lib/jellyfin/bin/System.Net.Security.Native.so
	usr/lib/jellyfin/bin/System.Security.Cryptography.Native.OpenSsl.so
	usr/lib/jellyfin/bin/createdump
	usr/lib/jellyfin/bin/jellyfin
	usr/lib/jellyfin/bin/libSkiaSharp.so
	usr/lib/jellyfin/bin/libclrjit.so
	usr/lib/jellyfin/bin/libcoreclr.so
	usr/lib/jellyfin/bin/libcoreclrtraceptprovider.so
	usr/lib/jellyfin/bin/libdbgshim.so
	usr/lib/jellyfin/bin/libe_sqlite3.so
	usr/lib/jellyfin/bin/libhostfxr.so
	usr/lib/jellyfin/bin/libhostpolicy.so
	usr/lib/jellyfin/bin/libmscordaccore.so
	usr/lib/jellyfin/bin/libmscordbi.so
"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${P}-server-${ARCH}.deb"
	unpack_deb "${P}-web.deb"
}

src_install() {
	# Install the Server part
	insinto usr/lib/
	doins -r usr/lib/${MY_PN}
	insinto etc
	doins -r etc/${MY_PN}
	insinto etc/default
	doins etc/default/${MY_PN}

	# Install the Web UI part
	insinto usr/lib/${MY_PN}/bin/${MY_PN}-web
	doins -r usr/share/${MY_PN}/web/*

	# Install wrappers and services
	make_wrapper "${MY_PN}" "${EPREFIX}/usr/lib/${MY_PN}/bin/${MY_PN}"
	dosym "${EPREFIX}/usr/bin/jellyfin" "${EPREFIX}/usr/bin/jellyfin-bin"
	systemd_dounit lib/systemd/system/${MY_PN}.service
	systemd_install_serviced etc/systemd/system/${MY_PN}.service.d/${MY_PN}.service.conf

	# Fix permissions
	fperms +x /usr/lib/${MY_PN}/*
	fperms +x /usr/lib/${MY_PN}/bin/*
}
