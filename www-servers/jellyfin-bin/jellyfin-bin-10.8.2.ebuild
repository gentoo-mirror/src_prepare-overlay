# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"

if [[ "${PV}" == *_rc* ]] ; then
	# _rc -> ~rc
	MY_PV="${PV/_rc/~rc}"
	SRV_SRC="${MY_PN}-server_${MY_PV}"
	WEB_SRC="${MY_PN}-web_${MY_PV}"
	RELEASE="stable-rc"
elif [[ "${PV}" == *_beta* ]] ; then
	MY_PV="${PV/_beta/-beta}"
	SRV_SRC="${MY_PN}-server_${MY_PV/-beta/~beta}"
	WEB_SRC="${MY_PN}-web_${MY_PV/-beta/~beta}"
	RELEASE="stable-pre"
else
	# Add "-1"
	MY_PV="${PV}"
	SRV_SRC="${MY_PN}-server_${MY_PV}-1"
	WEB_SRC="${MY_PN}-web_${MY_PV}-1"
	RELEASE="stable"
fi

inherit unpacker systemd wrapper

DESCRIPTION="The Free Software Media System"
HOMEPAGE="https://jellyfin.org"
BASE_URI="https://repo.jellyfin.org/releases/server/debian/versions/${RELEASE}"
SRC_URI="
	amd64? ( ${BASE_URI}/server/${MY_PV}/${SRV_SRC}_amd64.deb
			 -> ${P}-server-amd64.deb )
	arm64? ( ${BASE_URI}/server/${MY_PV}/${SRV_SRC}_arm64.deb
			 -> ${P}-server-arm64.deb )
	${BASE_URI}/web/${MY_PV}/${WEB_SRC}_all.deb -> ${P}-web.deb
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

DEPEND="
	!www-servers/jellyfin
"
RDEPEND="
	${DEPEND}
	<=dev-util/lttng-ust-2.12.1
	>=media-video/ffmpeg-4.2.2
	acct-group/jellyfin
	acct-user/jellyfin
	app-crypt/mit-krb5
	dev-db/sqlite
	media-libs/fontconfig
	media-libs/freetype
"

QA_PREBUILT="usr/lib/${MY_PN}/bin/*"
QA_PRESTRIPPED="${QA_PREBUILT}"

S="${WORKDIR}"

PATCHES=( "${FILESDIR}"/${MY_PN}-default.patch )

src_unpack() {
	# https://gitlab.com/src_prepare/src_prepare-overlay/-/merge_requests/145
	if use amd64 ; then
		unpack_deb ${P}-server-amd64.deb
	elif use arm64 ; then
		unpack_deb ${P}-server-arm64.deb
	else
		die "Unsupported architecture"
	fi

	unpack_deb ${P}-web.deb
}

src_install() {
	# Web UI
	insinto /usr/share/${MY_PN}/web
	doins -r usr/share/${MY_PN}/web/*

	# Server
	insinto /etc
	doins -r etc/${MY_PN}
	insinto /usr/lib
	insopts -m0755
	doins -r usr/lib/${MY_PN}
	fowners -R jellyfin:jellyfin /usr/lib/${MY_PN}

	# Wrappers
	make_wrapper ${PN} "${EPREFIX}"/usr/lib/${MY_PN}/bin/${MY_PN}
	dosym ../../usr/bin/${PN} /usr/bin/${MY_PN}

	# Services
	newinitd "${FILESDIR}"/${MY_PN} ${MY_PN}
	doconfd etc/default/${MY_PN}
	dosym ../../etc/conf.d/${MY_PN} /etc/default/${MY_PN}
	systemd_dounit lib/systemd/system/${MY_PN}.service
	systemd_install_serviced etc/systemd/system/${MY_PN}.service.d/${MY_PN}.service.conf
}
