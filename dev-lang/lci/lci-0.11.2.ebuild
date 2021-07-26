# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="LOLCODE interpreter written in C"
HOMEPAGE="http://www.lolcode.org/"
SRC_URI="https://github.com/justinmeza/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="doc? (
	app-doc/doxygen
)
"

src_compile() {
	cmake_src_compile
	use doc && cmake_src_compile docs
}
