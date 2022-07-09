# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1 bash-completion-r1

DESCRIPTION="Simple but convenient CLI-based Matrix client app for sending and receiving"
HOMEPAGE="https://github.com/8go/matrix-commander"
SRC_URI="https://github.com/8go/matrix-commander/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Tests are a bunch shell scripts and lone python script
# Not gonna bother
RESTRICT="test"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/aiofiles-0.6.0[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		>=dev-python/matrix-nio-0.14.1[e2e(+),${PYTHON_USEDEP}]
		dev-python/notify2[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
	')
"

src_install() {
	distutils-r1_src_install

	dobashcomp auto-completion/bash/matrix-commander.bash
}
