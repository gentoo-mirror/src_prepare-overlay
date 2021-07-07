# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Microsoft Paint for Windows XP."
HOMEPAGE="https://archive.org/details/mspaint_xp_version"

LICENSE+=" UNKNOWN"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_URI="https://archive.org/download/mspaint_xp_version/mspaint.exe"

IUSE="+abi_x86_32"
REQUIRED_USE="abi_x86_32"

BDEPEND+="
	media-gfx/icoutils
	media-gfx/imagemagick
	sys-apps/coreutils
"

RDEPEND+="
	app-shells/bash:0
	virtual/wine[abi_x86_32]
	app-emulation/winetricks
	sys-apps/grep
"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	wrestool -x -t14 -o . "${DISTDIR}"/mspaint.exe
	convert mspaint.exe_14_2.ico mspaint.png
	mv mspaint-6.png mspaint.png
}

src_install() {
	insinto /usr/share/mspaint
	doins "${DISTDIR}"/mspaint.exe
	insinto /usr/share/pixmaps
	doins mspaint.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/mspaint.desktop
	dobin "${FILESDIR}"/mspaint
}
