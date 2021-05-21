# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1 multiprocessing

MY_P="${PN}-${PV/_pre/.dev}"

DESCRIPTION="PYthon svg GrAph plotting Library "
# http://pygal.org/ is dead as of 20210519, therefore use the next best thing
HOMEPAGE="https://github.com/Kozea/pygal"
SRC_URI="mirror://pypi/${MY_P:0:1}/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	media-gfx/cairosvg[${PYTHON_USEDEP}]
"
DEPEND="
	man? (
		 dev-python/pygal_sphinx_directives
		 dev-python/sphinx_rtd_theme
	)
	test? (
		  ${RDEPEND}
		  dev-python/flask[${PYTHON_USEDEP}]
		  dev-python/pygal_maps_ch[${PYTHON_USEDEP}]
		  dev-python/pygal_maps_fr[${PYTHON_USEDEP}]
		  dev-python/pygal_maps_world[${PYTHON_USEDEP}]
		  dev-python/pytest-cov[${PYTHON_USEDEP}]
		  dev-python/pytest-flake8[${PYTHON_USEDEP}]
		  dev-python/pytest-isort[${PYTHON_USEDEP}]
		  dev-python/pytest-xdist[${PYTHON_USEDEP}]
		  dev-python/pyquery[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	man? ( dev-python/sphinx )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/pygal_sphinx_directives dev-python/sphinx_rtd_theme

python_prepare_all() {
	sed -i -e '/pytest-runner/d' setup.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use man && emake -C docs -j1 man
	sphinx_compile_all
}

python_test() {
	epytest -n "$(makeopts_jobs "${MAKEOPTS}" "$(get_nproc)")"
}

python_install_all() {
	use man && doman docs/_build/man/*
	distutils-r1_python_install_all
}
