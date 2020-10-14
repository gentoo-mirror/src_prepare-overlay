# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit bash-completion-r1 python-r1

DESCRIPTION="DuckDuckGo from the terminal"
HOMEPAGE="https://github.com/jarun/ddgr"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jarun/${PN}.git"
else
	SRC_URI="https://github.com/jarun/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="bash-completion fish-completion zsh-completion"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
"
RDEPEND="
	${DEPEND}
"

src_install() {
	exeinto "/usr/bin"
	doexe "${PN}"
	doman "${PN}.1"
	dodoc CHANGELOG README.md
	if use bash-completion
	then
		newbashcomp auto-completion/bash/${PN}-completion.bash ${PN}
	fi
	if use fish-completion
	then
		insinto /usr/share/fish/vendor_completions.d/
		doins auto-completion/fish/${PN}.fish
	fi
	if use zsh-completion
	then
		insinto /usr/share/zsh/site-functions
		doins auto-completion/zsh/_${PN}
	fi

}
