# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pidgin/Purple PRotocol PLugin for Discord"
HOMEPAGE="https://github.com/EionRobb/purple-discord"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EionRobb/${PN}.git"
else
	COMMIT="4a091883e646f2c103ae68c41d04b1b880e8d0bf"
	SRC_URI="https://github.com/EionRobb/purple-discord/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="+qrcode"

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/nss
	net-im/pidgin:=
	sys-libs/zlib
	virtual/libintl
	qrcode? ( media-gfx/qrencode:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	media-gfx/imagemagick[png]
	sys-devel/gettext
"

src_compile() {
	emake USE_QRCODE_AUTH=$(usex qrcode 1 0)
}
