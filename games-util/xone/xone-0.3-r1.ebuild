# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="Linux kernel driver for Xbox One and Xbox Series X|S accessories"

HOMEPAGE="https://github.com/medusalix/xone"

XONE_DRIVER_VERSION="201707-1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e"
SRC_URI="
	https://github.com/medusalix/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	http://download.windowsupdate.com/c/msdownload/update/driver/drvs/${XONE_DRIVER_VERSION:0:4}/${XONE_DRIVER_VERSION:4:2}/${XONE_DRIVER_VERSION:7}.cab
		-> ${PN}-driver-${XONE_DRIVER_VERSION}.cab
"

LICENSE="GPL-2 MS-TOU"

RESTRICT="bindist mirror"

SLOT="0"

KEYWORDS="~amd64"

BDEPEND="app-arch/cabextract"

pkg_setup() {
	local CONFIG_CHECK="SND CFG80211 INPUT_FF_MEMLESS USB POWER_SUPPLY LEDS_CLASS HID"

	MODULE_NAMES="
		xone-wired(kernel/drivers/input/joystick)
		xone-dongle(kernel/drivers/input/joystick)
		xone-gip(kernel/drivers/input/joystick)
		xone-gip-gamepad(kernel/drivers/input/joystick)
		xone-gip-headset(kernel/drivers/input/joystick)
		xone-gip-chatpad(kernel/drivers/input/joystick)
		xone-gip-guitar(kernel/drivers/input/joystick)
	"

	linux-mod_pkg_setup

	BUILD_TARGETS="module"
	BUILD_PARAMS="KERNEL_DIR=${KERNEL_DIR} V=1"

	# TODO: more robust solution in linux-mod would be ideal
	if linux_chkconfig_present CC_IS_CLANG; then
		"${KERNEL_CC:=${CHOST}-clang}"
		if linux_chkconfig_present LD_IS_LLD; then
			: "${KERNEL_LD:=ld.lld}"
			if linux_chkconfig_present LTO_CLANG_THIN; then
				BUILD_PARAMS+=" ldflags-y=--thinlto-cache-dir= LDFLAGS_MODULE=--thinlto-cache-dir="
			fi
		fi
	fi

	BUILD_PARAMS+=" ${KERNEL_CC:+CC=${KERNEL_CC}} ${KERNEL_LD:+LD=${KERNEL_LD}}"
}

src_unpack() {
	unpack ${P}.tar.gz

	cabextract -F FW_ACC_00U.bin -d "${S}" "${DISTDIR}/${PN}-driver-${XONE_DRIVER_VERSION}.cab" > /dev/null \
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
