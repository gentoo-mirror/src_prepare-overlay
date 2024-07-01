# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="Check if a given package has new upstream versions"
HOMEPAGE="https://gitlab.com/src_prepare/euscan-ng"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/src_prepare/${PN}.git"
else
	SRC_URI="https://gitlab.com/src_prepare/${PN}/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

# no tests
RESTRICT="test"

# Right now euscan-ng and euscan can't be both installed on the same system
RDEPEND="
	!app-portage/euscan
	app-portage/gentoolkit
	>=dev-python/beautifulsoup4-4.8.2[${PYTHON_USEDEP}]
	sys-apps/portage
"
