# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Colorized REPL for GNU Guile"
HOMEPAGE="https://gitlab.com/NalaGinrut/guile-colorized/"
EGIT_REPO_URI="https://gitlab.com/NalaGinrut/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-scheme/guile-2.0.9
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	default

	find "${S}" -name "*.scm" -exec touch {} + || die
}

src_compile() {
	:
}

src_install() {
	local loadpath=$(guile -c "(display (string-append (car %load-path) \"/ice-9\"))")
	mkdir -p "${D}${loadpath}"
	emake TARGET="${D}${loadpath}" install
}
