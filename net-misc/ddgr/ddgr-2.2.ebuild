# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1 bash-completion-r1

DESCRIPTION="DuckDuckGo from the terminal"
HOMEPAGE="
	https://github.com/jarun/ddgr
	https://pypi.org/project/ddgr/
"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jarun/ddgr"
else
	SRC_URI="https://github.com/jarun/ddgr/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

src_install() {
	distutils-r1_src_install

	dodoc CHANGELOG README.md
	doman ddgr.1

	newbashcomp auto-completion/bash/${PN}-completion.bash ${PN}

	insinto /usr/share/fish/vendor_completions.d/
	doins auto-completion/fish/${PN}.fish

	insinto /usr/share/zsh/site-functions
	doins auto-completion/zsh/_${PN}
}
