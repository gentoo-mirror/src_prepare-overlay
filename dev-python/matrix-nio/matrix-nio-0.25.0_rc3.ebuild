# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

MY_PV="${PV/_/}"

DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles"
HOMEPAGE="https://github.com/matrix-nio/matrix-nio"
SRC_URI="https://github.com/matrix-nio/matrix-nio/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="ISC"
SLOT="0"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/python-olm-3.2.15[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-socks-0.8.4[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-23.1.0[${PYTHON_USEDEP}]
	>=dev-python/atomicwrites-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/cachetools-4.2.1[${PYTHON_USEDEP}]
	>=dev-python/h11-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/h2-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/peewee-3.17.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.10.1[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-2.1.0[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		${RDEPEND}
		>=dev-python/aioresponses-0.7.4[${PYTHON_USEDEP}]
		>=dev-python/Faker-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-aiohttp-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/hpack-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/hyperframe-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/hypothesis-6.8.9[${PYTHON_USEDEP}]
		>=dev-python/mypy-0.812[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
# m2r2 mistune woes
#distutils_enable_sphinx doc dev-python/sphinx-autodoc-typehints dev-python/sphinx-rtd-theme dev-python/m2r2

EPYTEST_DESELECT=(
	# breaks network sandbox
	"tests/async_client_test.py::TestClass::test_connect_wrapper"
	# requires pytest-benchmark, not much value in pass/no pass tests
	"tests/key_export_test.py::TestClass::test_decrypt_rounds"
	"tests/key_export_test.py::TestClass::test_encrypt_rounds"
	# flaky
	"tests/async_client_test.py::TestClass::test_transfer_monitor_callbacks"
)
