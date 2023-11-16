# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Check if a given package has new upstream versions"
HOMEPAGE="https://gitlab.com/src_prepare/euscan-ng"

MY_PV="$(pypi_translate_version ${PV})"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/src_prepare/${PN}.git"
else
	# GITLAB WHY DO NOT HAVE NON SHA256 URLS
	SHA256="573c400924f9ca4163c5cf41c124bec0896ec9e1e6fb0bbc297aff2ff15a001c"
	SRC_URI="https://gitlab.com/api/v4/projects/21075613/packages/pypi/files/${SHA256}/${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_PV}"

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
