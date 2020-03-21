# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1

DESCRIPTION="Python bindings for FFmpeg - with complex filtering support "
HOMEPAGE="https://github.com/kkroening/ffmpeg-python"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kkroening/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/kkroening/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc test"

COMMON_DEPEND="
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DEPEND="
	${COMMON_DEPEND}
	doc? (
		>=dev-python/sphinx-2.4.4[${PYTHON_USEDEP}]
	)
	test? (
		>=dev-python/pytest-4.6.9[${PYTHON_USEDEP}]
		>=dev-python/pytest-mock-1.11.2[${PYTHON_USEDEP}]
		>=dev-python/tox-3.12.1[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${COMMON_DEPEND}
	>=dev-python/future-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.16.5[${PYTHON_USEDEP}]
	media-video/ffmpeg
"
