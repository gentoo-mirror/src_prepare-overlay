# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{7..9})

inherit distutils-r1

DESCRIPTION="Read and write Advanced Authoring Format (AAF) files"
HOMEPAGE="http://pyaaf.readthedocs.io/"
SRC_URI="https://github.com/markreidvfx/pyaaf2/archive/v"${PV}".tar.gz -> "${P}".tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

DEPEND="
	test? (
		  dev-python/matplotlib[${PYTHON_USEDEP}]
		  dev-python/numpy[${PYTHON_USEDEP}]
	)
"
BDEPEND="doc? ( app-misc/sphinx )"

distutils_enable_tests setup.py

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}

python_test() {
	# Tests import from tests/common.py which is breaks unless the dir is added to PYTHONPATH
	PYTHONPATH="${S}/tests"
	epytest
}
