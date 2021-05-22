# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="A theme based on the theme of https://docs.python.org/3/."
HOMEPAGE="https://github.com/ionelmc/sphinx-py3doc-enhanced-theme"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
# TODO: figure out how to fix tests
RESTRICT="test"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/Allow-missing-env-var.patch"
	"${FILESDIR}/undo-pypi-modification-to-setupcfg.patch"
	"${FILESDIR}/backport-for-setupcfg.patch"
)
DOCS=( "README.rst" )
