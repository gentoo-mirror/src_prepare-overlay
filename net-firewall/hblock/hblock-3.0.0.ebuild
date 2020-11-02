# Copyright 1999-2020 Gentoo Authors
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

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND="
	sys-apps/baselayout
"
BDEPEND="
	${DEPEND}
	sys-apps/coreutils
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	default

	# Upstream provides shasums in the repo - let's use them
	cd "${S}" || die
	sha256sum -c "${S}"/SHA256SUMS || die "Shasum check failed"
	cd "${S}"/resources/systemd || die
	sha256sum -c "${S}"/resources/systemd/SHA256SUMS || die "Shasum check failed"
}

src_compile() {
	:
}

src_install() {
	einstalldocs

	dobin "${PN}"

	systemd_dounit "${S}"/resources/systemd/hblock.service
	systemd_dounit "${S}"/resources/systemd/hblock.timer
}
