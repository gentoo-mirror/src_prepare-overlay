# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: windows-helper.eclass
# @MAINTAINER:
# moog621@gmail.com
# @AUTHOR:
# moog621@gmail.com
# @SUPPORTED_EAPIS: 7
# @BLURB: Helper functions for dealing with Windows.
# @DESCRIPTION:
# This class will provide functions and build dependencies which will help with problems typical when dealing with Windows in the context of ebuilds.

BDEPEND+="
	sys-apps/sed
	sys-apps/coreutils
"

# @FUNCTION: windowshelper_convert_normal_path_to_windows_path
# @USAGE: <path>
# @DESCRIPTION:
# This function expects a single argument - a path, nevermind if absolute or relative, because it will be implicitly converted to an absolute path.
# This function will produce a standard output comprised of the above path converted to a Windows path. Since the path is an absolute one, it will point to an analogous path in the Z: drive, which makes this path readily usable by Wine.
windowshelper_convert_normal_path_to_windows_path() {
	local abs_path="${1}"
	if ! [[ "${1}" =~ '^\/' ]]; then
		abs_path=$(readlink -f "${1}")
	fi
	echo "${abs_path}" | sed 's_^_Z:_;s_/_\\_g'
}
