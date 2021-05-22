# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="pytest plugin to enable formatting checks with black "
HOMEPAGE="https://github.com/shopkeep/pytest-black"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/black[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
"
DEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests pytest

DOCS=( "README.md" )

# Fix tests for pytest6
# https://github.com/shopkeep/pytest-black/pull/53
PATCHES=( "${FILESDIR}/fix-pytest.tmpdir.makefile-call.patch" )
