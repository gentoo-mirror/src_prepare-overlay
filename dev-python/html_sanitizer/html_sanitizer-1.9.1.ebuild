# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Allowlist-based HTML cleaner"
HOMEPAGE="https://github.com/matthiask/html-sanitizer/ https://pypi.org/project/html-sanitizer/"
SRC_URI="https://github.com/matthiask/html-sanitizer/archive/"${PV}".tar.gz -> "${PN}"-"${PV}".tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/lxml-3.6.1
	dev-python/beautifulsoup4
"

S="${WORKDIR}/html-sanitizer-${PV}"

distutils_enable_tests unittest
