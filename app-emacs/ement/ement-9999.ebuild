# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
NEED_EMACS="26.3"

inherit elisp git-r3

DESCRIPTION="Matrix client for GNU Emacs"
HOMEPAGE="https://github.com/alphapapa/ement.el"

EGIT_REPO_URI="https://github.com/alphapapa/ement.el.git"
EGIT_BRANCH="master"
EGIT_CLONE_TYPE="single"

KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="e2e extras"

DOCS="README.org"

BDEPEND="
	>=app-emacs/plz-0.1_pre
	>=app-emacs/ts-0.2
	e2e? ( net-im/pantalaimon )
"
# Pantalaimon's docs are needed at build time to annotate config

RDEPEND="
	>=app-emacs/plz-0.1_pre
	>=app-emacs/ts-0.2
	e2e? ( net-im/pantalaimon )
	extras? ( app-emacs/ement-extras )
"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp_src_compile
	if use e2e ; then
		einfo "Annotating suggested pantalaimon config..."
		cp "${FILESDIR}"/pantalaimon.conf "${S}"
		"${EMACS}" -Q -batch -l "${FILESDIR}/${PN}"-annotate-conf.el
	fi
}

src_install() {
	if use e2e ; then
		einfo "Installing suggested pantalaimon config to /etc/${PN}"
		insinto /etc/"${PN}"
		doins pantalaimon.conf
		DOCS+=" ${FILESDIR}/${PN}-gentoo-pantalaimon.org"
	fi
	elisp_src_install
}

pkg_postinst() {
	if [ ! [ use e2e && use extras ] ] ; then
		einfo "To start using Matrix from Emacs with E2EE without any manual configuration,"
		einfo "USE=\"e2e extras\" emerge app-emacs/ement"
	fi
}
