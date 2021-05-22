# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9})

inherit distutils-r1

DESCRIPTION="Markdown to reStructuredText converter "
HOMEPAGE="https://crossnox.github.io/m2r2/"
SRC_URI="https://github.com/CrossNox/m2r2/archive/refs/tags/v"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/mistune[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		  ${RDEPEND}
		  dev-python/pygments[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs

PATCHES=( "${FILESDIR}/quick_workaround_to_distributionnotfound.patch" )
