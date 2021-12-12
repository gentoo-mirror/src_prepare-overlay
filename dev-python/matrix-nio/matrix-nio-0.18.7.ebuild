# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10})
DISTUTILS_USE_SETUPTOOLS="pyproject.toml"

inherit distutils-r1

DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles"
HOMEPAGE="https://github.com/poljar/matrix-nio"
SRC_URI="https://github.com/poljar/matrix-nio/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="e2e test"

RESTRICT="!e2e? ( test )"

RDEPEND="
	>=dev-python/aiohttp-3.7.4[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-socks-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/future-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/h11-0.12.0[${PYTHON_USEDEP}]
	>=dev-python/h2-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/logbook-1.5.3[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.10.1[${PYTHON_USEDEP}]
	e2e? (
		>=dev-libs/olm-3.1.3[python(-),${PYTHON_USEDEP}]
		>=dev-python/peewee-3.14.4[${PYTHON_USEDEP}]
		>=dev-python/cachetools-4.2.1[${PYTHON_USEDEP}]
		>=dev-python/atomicwrites-1.4.0[${PYTHON_USEDEP}]
	)
"
DEPEND="
	test? (
		${RDEPEND}
		>=dev-python/aioresponses-0.7.2[${PYTHON_USEDEP}]
		dev-python/atomicwrites[${PYTHON_USEDEP}]
		dev-python/cachetools[${PYTHON_USEDEP}]
		>=dev-python/Faker-8.0.0[${PYTHON_USEDEP}]
		dev-python/peewee[${PYTHON_USEDEP}]
		>=dev-python/pytest-aiohttp-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-benchmark-3.2.3[${PYTHON_USEDEP}]
		dev-python/pytest-flake8[${PYTHON_USEDEP}]
		>=dev-python/pytest-isort-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-2.11.1[${PYTHON_USEDEP}]
		>=dev-python/hpack-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/hyperframe-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/hypothesis-6.8.9[${PYTHON_USEDEP}]
		>=dev-python/mypy-0.812[${PYTHON_USEDEP}]
		dev-python/mypy_extensions[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx_rtd_theme dev-python/m2r2

python_test() {
	# Former requires internet access, latter fails randomly
	epytest --deselect tests/async_client_test.py::TestClass::test_connect_wrapper[pyloop] --deselect tests/async_client_test.py::TestClass::test_transfer_monitor_callbacks
}
