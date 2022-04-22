# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="Linux kernel driver for Xbox One and Xbox Series X|S accessories"

HOMEPAGE="https://github.com/medusalix/xone"

SRC_URI="https://github.com/medusalix/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	http://download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/07/1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e.cab -> ${P}-driver.cab"

LICENSE="GPL-2 MS-TOU"

RESTRICT="bindist mirror"

SLOT="0"

KEYWORDS="~amd64"

MODULE_NAMES="
	xone-wired(kernel/drivers/input/joystick)
	xone-dongle(kernel/drivers/input/joystick)
	xone-gip-bus(kernel/drivers/input/joystick)
	xone-gip-common(kernel/drivers/input/joystick)
	xone-gip-gamepad(kernel/drivers/input/joystick)
	xone-gip-headset(kernel/drivers/input/joystick)
	xone-gip-chatpad(kernel/drivers/input/joystick)
"
BUILD_TARGETS="module"
BUILD_PARAMS="KERNEL_DIR=${KERNEL_DIR}"

BDEPEND="app-arch/cabextract"

src_unpack() {
	unpack ${P}.tar.gz

	cabextract -F FW_ACC_00U.bin -d "${S}" "${DISTDIR}/${P}-driver.cab" > /dev/null \
		|| die "Failed to unpack driver"
}

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}" || die
	eapply_user
}

src_install() {
	linux-mod_src_install

	einfo "Installing module blacklist"
	insinto /etc/modprobe.d/
	newins "${S}"/install/modprobe.conf xone-blacklist.conf

	einfo "Installing Microsoft binary firmware"
	insinto /lib/firmware/
	newins "${S}"/FW_ACC_00U.bin xow_dongle.bin
}
