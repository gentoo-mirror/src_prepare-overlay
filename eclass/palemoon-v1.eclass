# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


# @ECLASS: palemoon-v1.eclass
# @MAINTAINER:  src_prepare group
# @AUTHOR:  src_prepare group
# @SUPPORTED_EAPIS: 6 7
# @BLURB: Common configuration eclass for Palemoon
# @DESCRIPTION: This eclass is used in palemoon ebuilds


case ${EAPI} in
	0 | 1 | 2 | 3 | 4 | 5 )
		die "EAPI=${EAPI} not supported"
		;;
esac


inherit check-reqs desktop toolchain-funcs xdg-utils

EXPORT_FUNCTIONS pkg_pretend pkg_postinst pkg_postrm pkg_setup


# @FUNCTION: palemoon-v1_pkg_pretend
# @DESCRIPTION: pkg_pretend for palemoon

palemoon-v1_pkg_pretend() {

	# Ensure that we have enough disk space to compile:
	CHECKREQS_DISK_BUILD="${REQUIRED_BUILDSPACE}"
	check-reqs_pkg_setup

	# Ensure that we are on a supported compiler profile:
	einfo "Checking compiler profile..."
	if [[ ${PALEMOON_ENABLE_UNSUPPORTED_COMPILERS} == 1 ]]; then
		unsupported_compiler_warning "$(tc-get-compiler-type)"
	else
		if ! [[ tc-is-gcc && "${GCC_SUPPORTED_VERSIONS}" =~ (^| )"$(gcc-version)"($| ) ]]; then
			unsupported_compiler_error "$(tc-get-compiler-type)"
			die
		fi
	fi
}


# @FUNCTION: palemoon-v1_pkg_postinst
# @DESCRIPTION: pkg_postinst for palemoon

palemoon-v1_pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}


# @FUNCTION: palemoon-v1_pkg_postrm
# @DESCRIPTION: pkg_postrm for palemoon

palemoon-v1_pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}


# @FUNCTION: palemoon-v1_pkg_setup
# @DESCRIPTION: pkg_setup for palemoon

palemoon-v1_pkg_setup() {

	# Nested configure scripts in mozilla products generate unrecognized
	# options false positives when toplevel configure passes downwards:
	export QA_CONFIGURE_OPTIONS=".*"
}


# @FUNCTION: official-branding_warning
# @DESCRIPTION: Warn when enabling official branding

official-branding_warning() {
	elog "You are enabling the official branding. You may not redistribute this build"
	elog "to any users on your network or the internet. Doing so puts yourself into"
	elog "a legal problem with Moonchild Productions."
	elog "You can disable the official branding by emerging ${PN} _without_"
	elog "the official-branding USE flag."
}


# @FUNCTION: unsupported_compiler_warning
# @DESCRIPTION: Warn when unsupported compiler is detected

unsupported_compiler_warning() {
	ewarn "Building Pale Moon with a compiler other than a supported gcc version"
	ewarn "may result in an unstable build."
	ewarn "Be aware that building Pale Moon with an unsupported compiler"
	ewarn "means that the official support channels may refuse to offer any"
	ewarn "kind of help in case the build fails or the browser behaves incorrectly."
	ewarn "Supported GCC versions: ${GCC_SUPPORTED_VERSIONS// /, }"
	if [[ "${1}" == "gcc" ]]; then
		ewarn "Selected GCC version: $(gcc-version)"
	else
		ewarn "Unsupported compiler selected: ${1}"
	fi
	ewarn "To disable this warning unset the PALEMOON_ENABLE_UNSUPPORTED_COMPILERS"
	ewarn "environment variable."
}


# @FUNCTION: unsupported_compiler_error
# @DESCRIPTION: Error when unsupported compiler is detected

unsupported_compiler_error() {
	eerror "Building Pale Moon with a compiler other than a supported gcc version"
	eerror "may result in an unstable build."
	eerror "You can use gcc-config to change your compiler profile, just remember"
	eerror "to change it back afterwards."
	eerror "You need to have the appropriate versions of gcc installed for them"
	eerror "to be shown in gcc-config."
	eerror "Alternatively, you can set the PALEMOON_ENABLE_UNSUPPORTED_COMPILERS"
	eerror "environment variable to 1 either by exporting it from the current shell"
	eerror "or by adding it to your make.conf file."
	eerror "Be aware though that building Pale Moon with an unsupported compiler"
	eerror "means that the official support channels may refuse to offer any"
	eerror "kind of help in case the build fails or the browser behaves incorrectly."
	eerror "Supported GCC versions: ${GCC_SUPPORTED_VERSIONS// /, }"
	if [[ "${1}" == "gcc" ]]; then
		eerror "Selected GCC version: $(gcc-version)"
	else
		eerror "Unsupported compiler selected: ${1}"
	fi
}


# @FUNCTION: mozconfig_init
# @DESCRIPTION: Initialize mozconfig

mozconfig_init() {
	echo "ac_add_options --enable-application=palemoon" > "${S}/.mozconfig"
}


# @FUNCTION: mozconfig_enable
# @DESCRIPTION: Enable a mozconfig option

mozconfig_enable() {
	for option in "${@}"; do
		echo "ac_add_options --enable-${option}" >> "${S}/.mozconfig"
	done
}


# @FUNCTION: mozconfig_disable
# @DESCRIPTION: Disable a mozconfig option

mozconfig_disable() {
	for option in "${@}"; do
		echo "ac_add_options --disable-${option}" >> "${S}/.mozconfig"
	done
}


# @FUNCTION: mozconfig_with
# @DESCRIPTION: Enable a mozconfig option

mozconfig_with() {
	for option in "${@}"; do
		echo "ac_add_options --with-${option}" >> "${S}/.mozconfig"
	done
}


# @FUNCTION: mozconfig_var
# @DESCRIPTION: Enable a mozconfig viariable

mozconfig_var() {
	echo "mk_add_options ${1}=${2}" >> "${S}/.mozconfig"
}


# @FUNCTION: set_pref
# @DESCRIPTION: Enable a (Java Script) preference

set_pref() {
	echo "pref(\"${1}\", ${2});" >> "${S}/${obj_dir}/dist/bin/browser/defaults/preferences/palemoon.js"
}


# @FUNCTION: install_branding_files
# @DESCRIPTION: Install icons and desktop file

install_branding_files() {
	cp -rL "${S}/${obj_dir}/dist/branding" "${extracted_dir}/"

	local size sizes icon_path icon name
	icon="${PN}"
	icon_path="${extracted_dir}/branding"
	name="Pale Moon"
	sizes="16 32 48"

	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png"
	done

	# The 128x128 icon has a different name:
	insinto "/usr/share/icons/hicolor/128x128/apps"
	newins "${icon_path}/mozicon128.png" "${icon}.png"

	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs:
	newicon "${icon_path}/default48.png" "${icon}.png"
	newmenu "${FILESDIR}/${PN}.desktop" "${PN}.desktop"
	sed -i -e "s:@NAME@:${name}:" -e "s:@ICON@:${icon}:" \
		"${ED}/usr/share/applications/${PN}.desktop" || die
}
