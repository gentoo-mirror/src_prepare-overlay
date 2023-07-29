# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=y
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

DESCRIPTION="File Versioning System with hash comparison"
HOMEPAGE="https://github.com/mirkobrombin/FVS/
	https://pypi.org/project/fvs/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# No tests
RESTRICT="test"

RDEPEND="dev-python/orjson[${PYTHON_USEDEP}]"
