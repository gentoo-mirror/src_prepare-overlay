# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

# This is the name of the tag/release, not the commit (although the tag is named after the commit)
VERSION="c3d1610"

DESCRIPTION="Linux kernel driver for Xbox 360 controllers with Xbox One support removed"
HOMEPAGE="https://github.com/medusalix/xpad-noone"
SRC_URI="https://github.com/medusalix/xpad-noone/archive/refs/tags/${VERSION}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${VERSION}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CONFIG_CHECK="INPUT_JOYDEV INPUT_JOYSTICK"
MODULES_KERNEL_MIN=5.11

src_prepare() {
	# Use custom Makefile to use KERNEL_DIR instead of guessing it with uname
	cp "${FILESDIR}/Makefile" "${S}" || die
	eapply_user
}

src_compile() {
	local modlist=(
		xpad-noone=kernel/drivers/input/joystick
	)

	linux-mod-r1_src_compile
}
