# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Python bindings for FFmpeg with complex filtering support "
HOMEPAGE="https://github.com/kkroening/ffmpeg-python"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kkroening/${PN}.git"
else
	SRC_URI="https://github.com/kkroening/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	>=dev-python/future-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.16.5[${PYTHON_USEDEP}]
	dev-python/wheel
	test? (
		>=dev-python/pytest-mock-1.11.2[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${RDEPEND}
	media-video/ffmpeg
"

distutils_enable_tests pytest

distutils_enable_sphinx doc/src

python_prepare_all() {
	sed -i -e '/pytest-runner/d' setup.py || die

	distutils-r1_python_prepare_all
}
