# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Extract icons from Windows PE files (.exe/.dll)"
HOMEPAGE="
	https://pypi.org/project/icoextract/
	https://github.com/jlu5/icoextract
"
SRC_URI="https://github.com/jlu5/icoextract/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pefile[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-util/mingw64-toolchain
		${RDEPEND}
	)
"

distutils_enable_tests unittest

src_test() {
	export PATH="${BROOT}/usr/lib/mingw64-toolchain/bin:${PATH}"
	emake -C tests
	distutils-r1_src_test
}
