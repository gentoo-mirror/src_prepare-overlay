# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="A Matrix proxy daemon that adds E2E encryption capabilities"
HOMEPAGE="https://github.com/matrix-org/pantalaimon"
# tests not included in sdist
SRC_URI="https://github.com/matrix-org/pantalaimon/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# lets relax dbus-python, matrix-nio and pygobject
RDEPEND="
	>=dev-python/attrs-19.3.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.6[${PYTHON_USEDEP}]
	<dev-python/aiohttp-4.0[${PYTHON_USEDEP}]
	>=dev-python/appdirs-1.4.4[${PYTHON_USEDEP}]
	>=dev-python/cachetools-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-7.1.2[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	>=dev-python/janus-0.5[${PYTHON_USEDEP}]
	>=dev-python/keyring-21.2.1[${PYTHON_USEDEP}]
	>=dev-python/logbook-1.5.3[${PYTHON_USEDEP}]
	dev-python/matrix-nio[e2e(+),${PYTHON_USEDEP}]
	>=dev-python/notify2-0.3[${PYTHON_USEDEP}]
	<dev-python/notify2-0.4[${PYTHON_USEDEP}]
	>=dev-python/peewee-3.13.1[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3[${PYTHON_USEDEP}]
	<dev-python/prompt-toolkit-4[${PYTHON_USEDEP}]
	>=dev-python/pydbus-0.6[${PYTHON_USEDEP}]
	<dev-python/pydbus-0.7[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	"tests/proxy_test.py"
)

EPYTEST_DESELECT=(
	"tests/pan_client_test.py::TestClass::test_start_loop"
)

python_test() {
	epytest -o asyncio_mode=auto -p asyncio
}

src_install() {
	distutils-r1_src_install

	einstalldocs

	doman docs/man/pantalaimon.{5,8}
	dodoc docs/man/pantalaimon.{5,8}.md
	doman docs/man/panctl.1
	dodoc docs/man/panctl.md

	# issue: contrib config could be much better
	sed -i 's/^/# /' contrib/pantalaimon.conf || die
	insinto /etc
	doins contrib/pantalaimon.conf

	insinto /usr/lib/systemd/user
	doins contrib/pantalaimon.service
}
