# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Proof-of-concept tool to exploit common IEEE 802.11 protocol weaknesses."
HOMEPAGE="https://github.com/aircrack-ng/mdk4"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aircrack-ng/mdk4.git"
else
	SRC_URI="https://github.com/aircrack-ng/mdk4/archive/"${PV}".tar.gz -> "${P}".tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/libnl:3
	net-libs/libpcap
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( ""${FILESDIR}"/include_stdlib.patch" )
# https://github.com/aircrack-ng/mdk4/commit/a70d75cff34ba24231e75bcef7f8075eb4e7b0a3

src_configure() {
	filter-flags -fno-common
	append-flags -fcommon
	default
}

src_install() {
	# The install phase is a tad bit too funky, so doing by hand
	dosbin src/mdk4
	doman man/mdk4.1

	insinto /usr/share/"${PN}"
	doins -r useful_files

	HTML_DOCS="docs"
	einstalldocs

	dodoc AUTHORS CHANGELOG TODO
}
