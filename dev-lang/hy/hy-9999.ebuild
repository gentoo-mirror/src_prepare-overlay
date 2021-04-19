# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS="rdepend"
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="A LISP dialect running in python"
HOMEPAGE="http://hylang.org/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hylang/${PN}.git"
else
	MY_PV="${PV/_alpha/a}"
	SRC_URI="https://github.com/hylang/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

# tests fail
RESTRICT="mirror test"
# RESTRICT="
#	!test? ( test )
#	mirror
# "
# L
LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="
	>=dev-python/astor-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/clint-0.4[${PYTHON_USEDEP}]
	>=dev-python/funcparserlib-0.3.6[${PYTHON_USEDEP}]
	>=dev-python/rply-0.7.6[${PYTHON_USEDEP}]
	dev-python/flake8[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-0.15.0-do-not-install-get_version.py.patch" )

python_test() {
	nosetests -vv || die "Tests failed under ${EPYTHON}"
}
