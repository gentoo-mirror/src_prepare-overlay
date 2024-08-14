# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 bash-completion-r1

DESCRIPTION="Simple but convenient CLI-based Matrix client app for sending and receiving"
HOMEPAGE="https://github.com/8go/matrix-commander"
SRC_URI="https://github.com/8go/matrix-commander/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Tests are a bunch shell scripts and lone python script
# Not gonna bother as they require testing against a running matrix server
RESTRICT="test"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/aiofiles-0.6.0[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/async-timeout[${PYTHON_USEDEP}]
		dev-python/emoji[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		>=dev-python/matrix-nio-0.14.1[e2e(+),${PYTHON_USEDEP}]
		dev-python/notify2[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
	')
"

src_prepare() {
	eapply_user

	sed -i -e 's/matrix-commander.py/matrix-commander/' auto-completion/bash/matrix-commander.bash || die
}

src_install() {
	distutils-r1_src_install

	newbashcomp auto-completion/bash/matrix-commander.bash matrix-commander
}
