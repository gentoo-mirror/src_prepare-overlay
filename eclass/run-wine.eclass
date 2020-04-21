# Copyright 2020-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: run-wine.eclass
# @MAINTAINER:
# moog621@gmail.com
# @AUTHOR:
# moog621@gmail.com
# @SUPPORTED_EAPIS: 7
# @BLURB: Functions and BDEPEND/RDEPEND enrichment for Windows programs.
# @DESCRIPTION:
# This eclass helps to run Windows software during ebuild stages.
# It also concentrates problematic Wine targets so they don't come up
# in repoman reports for all packages using this eclass.

if [ -z ${INSTALLER_ABI} ]; then
	export INSTALLER_ABI="abi_x86_32"
fi
if [ -z ${PROGRAM_ABI} ]; then
	export PROGRAM_ABI="abi_x86_32"
fi
if [ -z ${WINEARCH} ]; then
	case "${INSTALLER_ABI}" in
		"abi_x86_32") export WINEARCH="win32";;
		"abi_x86_64") export WINEARCH="win64";;
		*) die "Unknown INSTALLER_ABI";;
	esac
fi
if [ -z ${WINEPREFIX} ]; then
	export WINEPREFIX="${HOME}/wineprefix"
fi

BDEPEND+="
	virtual/wine[${INSTALLER_ABI}]
	sys-apps/sed
	sys-apps/coreutils
	sys-apps/grep
"

RDEPEND+="
	virtual/wine[${PROGRAM_ABI}]
"

runwine_prepare_for_wine_run() {
	local HID_DEVICES=($(ls /dev | grep ^hid | sed 's_^_/dev/_'))
	einfo "Adding temporary pseudo rw to /dev/input"
	addpredict /dev/input
	for hid_device in ${HID_DEVICES[@]}; do
		einfo "Adding temporary pseudo rw to ${hid_device}"
		addpredict ${hid_device}
	done
}
