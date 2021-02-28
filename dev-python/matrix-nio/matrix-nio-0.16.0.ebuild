# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9})
DISTUTILS_USE_SETUPTOOLS="pyproject.toml"

inherit distutils-r1

DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles"
HOMEPAGE="https://github.com/poljar/matrix-nio"
SRC_URI="https://github.com/poljar/matrix-nio/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="e2e"


RDEPEND="
	dev-python/future
	dev-python/aiohttp
	dev-python/aiofiles
	dev-python/h11
	dev-python/hyper-h2
	dev-python/logbook
	dev-python/jsonschema
	dev-python/unpaddedbase64
	dev-python/pycryptodome
	e2e? (
		>=dev-libs/olm-3.1.5[python(-)]
		>=dev-python/peewee-3.9.5
		dev-python/cachetools
		dev-python/atomicwrites
	)
"
