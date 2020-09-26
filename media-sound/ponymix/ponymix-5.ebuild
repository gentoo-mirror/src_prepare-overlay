# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="CLI volume control for PulseAudio"
HOMEPAGE="https://github.com/falconindy/ponymix"
SRC_URI="https://github.com/falconindy/ponymix/archive/${PV}.tar.gz -> ${P}.tar.gz"

inherit bash-completion-r1 toolchain-funcs

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

RDEPEND="media-sound/pulseaudio"
DEPEND="${REDPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i "s/pkg-config/$(tc-getPKG_CONFIG)/g" Makefile || die "sed failed"

	default
}

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	dobin "${PN}"
	doman "${PN}.1"

	use bash-completion && newbashcomp bash-completion "${PN}"
}
