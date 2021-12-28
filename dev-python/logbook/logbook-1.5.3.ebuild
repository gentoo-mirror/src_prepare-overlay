# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="A logging replacement for Python"
HOMEPAGE="https://logbook.readthedocs.io/en/stable/
	https://github.com/getlogbook/logbook
	https://pypi.org/project/Logbook/"
SRC_URI="https://github.com/getlogbook/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="
	test? (
		app-arch/brotli[${PYTHON_USEDEP},python]
		dev-python/execnet[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pyzmq[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)"
RDEPEND="
	!!dev-python/contextvars
	!!dev-python/gevent"

distutils_enable_tests pytest
distutils_enable_sphinx docs

# Online test
EPYTEST_IGNORE=( tests/test_queues.py )

# Broken tests in upstream as well
EPYTEST_DESELECT=( tests/test_ticketing.py::test_basic_ticketing tests/test_queues.py::test_missing_zeromq )

python_configure_all() {
	export DISABLE_LOGBOOK_CEXT=1
}
