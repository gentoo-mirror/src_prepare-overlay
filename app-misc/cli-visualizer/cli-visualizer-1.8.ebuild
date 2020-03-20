# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="CLI based audio visualizer"
HOMEPAGE="https://github.com/dpayne/cli-visualizer"
SRC_URI="https://github.com/dpayne/cli-visualizer/archive/v1.8.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	sci-libs/fftw
	dev-util/cmake"
BDEPEND=""

src_install(){
	emake DESTDIR="${D}" install
}
