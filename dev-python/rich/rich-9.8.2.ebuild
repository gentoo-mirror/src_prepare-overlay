# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 eutils

DESCRIPTION="Validate configuration and produce human-readable messages"
HOMEPAGE="https://github.com/willmcgugan/rich"
SRC_URI="https://github.com/willmcgugan/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/colorama-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/commonmark-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4[${PYTHON_USEDEP}]
"
