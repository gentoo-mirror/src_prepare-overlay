# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Improve your security and privacy by blocking ads, tracking and malware domains"
HOMEPAGE="https://hblock.molinero.dev/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hectorm/${PN}.git"
else
	SRC_URI="https://github.com/hectorm/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="binchecks mirror strip test"

RDEPEND="
	|| (
		net-misc/curl[http2,ssl]
		net-misc/wget[ssl]
		www-client/fetch
	)
"

src_compile() {
	:
}

src_install() {
	einstalldocs

	dobin "${PN}"

	systemd_dounit "${S}"/resources/systemd/hblock.service
	systemd_dounit "${S}"/resources/systemd/hblock.timer
}
