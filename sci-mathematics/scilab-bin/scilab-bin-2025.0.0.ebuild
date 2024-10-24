# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Scientific software package for numerical computations"
HOMEPAGE="https://www.scilab.org/"
SRC_URI="https://www.scilab.org/download/${PV}/scilab-${PV}.bin.x86_64-linux-gnu.tar.xz"
S="${WORKDIR}/scilab-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror strip test"

RDEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/mesa
	sci-libs/lapack
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/libdrm
"

DESTDIR="/opt/scilab-bin"
QA_PREBUILT="${DESTDIR}/.*"
DOCS=( ACKNOWLEDGEMENTS COPYING CHANGES.md README.md )

src_prepare() {
	default

	# bug #709450
	mv share/appdata share/metainfo || die
}

src_install() {
	insinto "${DESTDIR}"
	doins -r bin include lib thirdparty

	for executable in {modelica{c,t},scilab{{,-bin},-adv-cli,-cli{,-bin}},scinotes,xcos,XML2Modelica}; do
		fperms +x "${DESTDIR}/bin/${executable}"
		# Only symlink shellscript if there is an option
		if ! [[ ${executable} =~ *-bin ]]; then
			dosym "${DESTDIR}/bin/${executable}" "/usr/bin/${executable}"
		fi
	done

	insinto "${DESTDIR}/share"
	doins -r share/{locale,scilab}

	insinto /usr/share
	doins -r share/{applications,icons,locale,metainfo,mime}

	einstalldocs
}
