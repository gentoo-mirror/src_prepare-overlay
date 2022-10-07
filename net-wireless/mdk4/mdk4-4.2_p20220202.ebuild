# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Proof-of-concept tool to exploit common IEEE 802.11 protocol weaknesses."
HOMEPAGE="https://github.com/aircrack-ng/mdk4"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aircrack-ng/mdk4.git"
else
	# Use a newer commits for build fixed + man page correction
	COMMIT="4ba85e4c94a79b634b63d26e64a977e568551367" # 2.2.2022
	SRC_URI="https://github.com/aircrack-ng/mdk4/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
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

src_prepare() {
	default

	# dont clean dir in all
	sed -i 's/all: clean/all:/' Makefile || die
}

src_configure() {
	# https://github.com/aircrack-ng/mdk4/blob/4.2/src/Makefile#L4
	append-flags -fcommon
	default
}

src_test() {
	emake test
	./test || die
}
