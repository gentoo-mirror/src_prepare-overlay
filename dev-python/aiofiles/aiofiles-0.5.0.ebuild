# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Copied from the Gentoo repo, only exists to add python3,9 support in PYTHON_COMPAT

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="File support for asyncio"
HOMEPAGE="https://github.com/Tinche/aiofiles"
SRC_URI="https://github.com/Tinche/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="test? (
	>=dev-python/pytest-5.4[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
