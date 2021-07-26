# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{8..10})

inherit distutils-r1

DESCRIPTION="Read and write Advanced Authoring Format (AAF) files"
HOMEPAGE="http://pyaaf.readthedocs.io/"
SRC_URI="https://github.com/markreidvfx/pyaaf2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	test? (
		  dev-python/matplotlib[${PYTHON_USEDEP}]
		  dev-python/numpy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest
distutils_enable_sphinx docs/source

python_test() {
	# Tests import from tests/common.py which is breaks unless the dir is added to PYTHONPATH
	PYTHONPATH="${S}/tests"
	eunittest
}
