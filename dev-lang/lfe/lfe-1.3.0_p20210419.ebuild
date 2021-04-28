# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp-common toolchain-funcs

DESCRIPTION="Lisp-flavoured Erlang"
HOMEPAGE="http://lfe.github.io/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_BRANCH="develop"
	EGIT_REPO_URI="https://github.com/rvirding/${PN}.git"
else
	COMMIT_SHA="dbfd16af065b12d2dbce26ff1fbad151765243fd"
	SRC_URI="https://github.com/rvirding/${PN}/archive/${COMMIT_SHA}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${COMMIT_SHA}"
fi

# tests require rebar3 & rebar3_proper
RESTRICT="mirror test"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc emacs"

BDEPEND="
	doc? (
		app-text/pandoc
		app-text/pandoc-bin
	)
"
RDEPEND="
	dev-lang/erlang
	emacs? ( >=app-editors/emacs-23.1:* )
"
DEPEND="${RDEPEND}"

SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	default

	sed -i "s|cc |$(tc-getCC) ${CFLAGS} |g" ./Makefile  \
		|| die "Failed to fix the makefile"
}

src_compile() {
	emake compile

	use doc && emake docs
	use emacs && emake emacs
}

src_install() {
	dodir "/usr/$(get_libdir)/erlang/lib/lfe/ebin/"
	cp -R ./ebin "${D}/usr/$(get_libdir)/erlang/lib/lfe/"  \
		|| die "failed to copy the ebin directory"

	dobin ./bin/*

	if use doc; then
		dodoc ./doc/*.txt
		doman ./doc/man/*
	fi

	if use emacs; then
		elisp-install lfe emacs/*  \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
