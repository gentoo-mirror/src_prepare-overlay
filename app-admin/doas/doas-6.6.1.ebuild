# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=OpenDoas
MY_P=${MY_PN}-${PV}

inherit eutils toolchain-funcs

DESCRIPTION="A portable fork of the OpenBSD doas command"
HOMEPAGE="https://github.com/Duncaen/OpenDoas"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Duncaen/${MY_PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Duncaen/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="ISC"
SLOT="0"
IUSE="pam"

RDEPEND="
	pam? ( sys-libs/pam )
"
DEPEND="
	${RDEPEND}
	virtual/yacc
"

if [[ ! "${PV}" == *9999* ]]; then
	S="${WORKDIR}"/${MY_P}
fi

DOCS=(
	README.md
)

src_prepare() {
	default
	sed -i 's/-Werror //' Makefile || die
}

src_configure() {
	tc-export CC AR
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--sysconfdir="${EPREFIX}"/etc
		$(use_with pam)
	)
	./configure "${myconf[@]}"
}
