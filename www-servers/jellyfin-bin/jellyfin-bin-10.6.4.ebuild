# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN//-bin}"
BASE_URI="https://repo.jellyfin.org/releases/server/debian/versions/stable/"

# No 'webapp' here because this is a server
inherit unpacker systemd

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

DEPEND="
	!www-servers/jellyfin
"
RDEPEND="
	${DEPEND}
	>=media-video/ffmpeg-4.2.2
	acct-group/jellyfin
	acct-user/jellyfin
	dev-db/sqlite
	dev-util/lttng-ust
	media-libs/fontconfig
	media-libs/freetype
"

QA_PRESTRIPPED="
	usr/lib/${MY_PN}/bin/System.Globalization.Native.so
	usr/lib/${MY_PN}/bin/System.IO.Compression.Native.so
	usr/lib/${MY_PN}/bin/System.Native.so
	usr/lib/${MY_PN}/bin/System.Net.Http.Native.so
	usr/lib/${MY_PN}/bin/System.Net.Security.Native.so
	usr/lib/${MY_PN}/bin/System.Security.Cryptography.Native.OpenSsl.so
	usr/lib/${MY_PN}/bin/createdump
	usr/lib/${MY_PN}/bin/${MY_PN}
	usr/lib/${MY_PN}/bin/libSkiaSharp.so
	usr/lib/${MY_PN}/bin/libclrjit.so
	usr/lib/${MY_PN}/bin/libcoreclr.so
	usr/lib/${MY_PN}/bin/libcoreclrtraceptprovider.so
	usr/lib/${MY_PN}/bin/libdbgshim.so
	usr/lib/${MY_PN}/bin/libe_sqlite3.so
	usr/lib/${MY_PN}/bin/libhostfxr.so
	usr/lib/${MY_PN}/bin/libhostpolicy.so
	usr/lib/${MY_PN}/bin/libmscordaccore.so
	usr/lib/${MY_PN}/bin/libmscordbi.so
"

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/${MY_PN}-default.patch"
)

src_unpack() {
	unpack_deb "${P}-server-${ARCH}.deb"
	unpack_deb "${P}-web.deb"
}

src_install() {
	# Install the Server part
	insinto usr/lib/
	doins -r "usr/lib/${MY_PN}"
	insinto etc
	doins -r "etc/${MY_PN}"

	# Install the Web UI part
	insinto "usr/share/${MY_PN}/web"
	doins -r "usr/share/${MY_PN}/web"/*

	# Install wrappers
	make_wrapper "${MY_PN}" "${EPREFIX}/usr/lib/${MY_PN}/bin/${MY_PN}"
	dosym "${EPREFIX}/usr/bin/${MY_PN}" "${EPREFIX}/usr/bin/${PN}"

	# Install services
	newinitd "${FILESDIR}/${MY_PN}" "${MY_PN}"
	doconfd "etc/default/${MY_PN}"
	dosym "${EPREFIX}/etc/conf.d/${MY_PN}" "${EPREFIX}/etc/default/${MY_PN}"
	systemd_dounit "lib/systemd/system/${MY_PN}.service"
	systemd_install_serviced "etc/systemd/system/${MY_PN}.service.d/${MY_PN}.service.conf"

	# Fix permissions
	chmod +x "${ED}/usr/lib/${MY_PN}"/* || die
	chmod +x "${ED}/usr/lib/${MY_PN}/bin"/* || die
	chown -R jellyfin:jellyfin "${ED}/usr/lib/${MY_PN}" || die
}
