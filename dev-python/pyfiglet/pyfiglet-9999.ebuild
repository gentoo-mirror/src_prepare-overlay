# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="An implementation of figlet written in Python"
HOMEPAGE="https://github.com/pwaller/pyfiglet"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pwaller/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/pwaller/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE=""
