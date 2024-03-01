# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

BINTRON_NAME="Postman"
BINTRON_EXECUTABLES="Postman postman"

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt
	lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit bintron-r1 desktop

DESCRIPTION="Supercharge your API workflow"
HOMEPAGE="https://www.postman.com"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}-amd64.tar.gz"
S="${WORKDIR}/Postman/app"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip test"

RDEPEND="
	app-crypt/libsecret
	dev-libs/wayland
"

src_install() {
	bintron-r1_src_install

	einstalldocs

	newicon -s 128 icons/icon_128x128.png Postman.png
	make_desktop_entry Postman Postman Postman "Development;Utility;" \
		"StartupWMClass=postman;" "MimeType=x-scheme-handler/postman;"
}
