# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=lolcat
MY_P="${MY_PN}-${PV}"

DESCRIPTION="High-performance implementation of lolcat"
HOMEPAGE="https://github.com/jaseg/lolcat"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jaseg/${MY_PN}.git"
else
	SRC_URI="https://github.com/jaseg/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="WTFPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	!games-misc/lolcat
"

if [[ ${PV} != *9999* ]]; then
	S="${WORKDIR}/${MY_P}"
fi

src_install() {
	insinto "/usr/bin"
	doins "${MY_PN}"
	fperms +x "/usr/bin/${MY_PN}"
}
