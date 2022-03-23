# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: bintron.eclass
# @MAINTAINER:
# src_prepare group
# @AUTHOR:
# Maciej Barć <xgqt@riseup.net>
# @SUPPORTED_EAPIS: 7
# @BLURB: Common configuration eclass for binary packages built with Electron
# @DESCRIPTION:
# This eclass is used in Electron packages ebuilds

# shellcheck shell=bash disable=2034

inherit optfeature xdg

case "${EAPI}"
in
	[7-8] )
		true
		;;
	* )
		die "EAPI: ${EAPI} not supported"
		;;
esac

EXPORT_FUNCTIONS src_prepare src_compile src_install pkg_postinst

RESTRICT+=" bindist mirror "

_BINTRON_LANGS="
	am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk vi zh-CN zh-TW
"

# @ECLASS_VARIABLE: BINTRON_LANGS
# @DESCRIPTION:
# List of language packs available for this package.
: ${BINTRON_LANGS:=${_BINTRON_LANGS}}

# Adapted from chromium-2.eclass

# @FUNCTION: _bintron_set_l10n_IUSE
# @USAGE:
# @INTERNAL
# @DESCRIPTION:
# Converts and adds BINTRON_LANGS to IUSE. Called automatically if
# BINTRON_LANGS is defined.
_bintron_set_l10n_IUSE() {
	local lang
	for lang in ${BINTRON_LANGS}; do
		# Default to enabled since we bundle them anyway.
		# USE-expansion will take care of disabling the langs the user has not
		# selected via L10N.
		IUSE+=" l10n_${lang} "
	done
}

if [[ ${BINTRON_LANGS} ]]; then
	_bintron_set_l10n_IUSE
fi

BINTRON_DEPEND="
	>=app-accessibility/at-spi2-atk-2.26:2
	>=app-accessibility/at-spi2-core-2.26:2
	>=dev-libs/atk-2.26
	>=dev-libs/libxml2-2.9.4-r3[icu]
	>=dev-libs/nss-3.26
	>=media-libs/alsa-lib-1.0.19
	>=media-libs/freetype-2.11.0-r1
	>=media-libs/libwebp-0.4.0
	>=net-print/cups-1.3.11
	app-arch/bzip2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	media-libs/flac
	media-libs/fontconfig
	media-libs/libjpeg-turbo
	media-libs/libpng
	net-misc/curl[ssl]
	sys-apps/dbus
	sys-apps/pciutils
	sys-libs/zlib[minizip]
	virtual/opengl
	virtual/ttf-fonts
	virtual/udev
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[X]
	x11-libs/libxkbcommon
	x11-libs/pango
	system-ffmpeg? ( >=media-video/ffmpeg-4.3[chromium] )
	system-vulkan? ( media-libs/vulkan-loader )
"
RDEPEND+="${BINTRON_DEPEND}"

IUSE+=" +system-ffmpeg +system-vulkan "

# The package will be already compiled,
# also most likely the package will be pre-stripped too.
QA_PREBUILT='*'
QA_PRESTRIPPED='*'

# @ECLASS_VARIABLE: BINTRON_HOME
# @DESCRIPTION:
# Path where the package contents will we installed.
: ${BINTRON_HOME:="/usr/share/${PN}/"}

# Adapted from chromium-2.eclass

# @FUNCTION: bintron_remove_language_paks
# @USAGE:
# @DESCRIPTION:
# Removes pak files from the current directory for languages that the user has
# not selected via the L10N variable.
# Also performs QA checks to ensure BINTRON_LANGS has been set correctly.
bintron_remove_language_paks() {
	pushd "${1:=.}" >/dev/null || die

	# Look for missing pak files.
	local lang
	for lang in ${BINTRON_LANGS}; do
		if [[ ! -e ${lang}.pak ]]; then
			eqawarn "L10N warning: no .pak file for ${lang} (${lang}.pak not found)"
		fi
	done

	# Remove pak files that the user does not want.
	local pak
	for pak in *.pak; do
		lang=${pak%.pak}
		if [[ ${lang} == en-US ]]; then
			continue
		fi
		if ! has ${lang} ${BINTRON_LANGS}; then
			eqawarn "L10N warning: no ${lang} in LANGS"
			continue
		fi
		if ! use l10n_${lang}; then
			rm "${pak}" || die
			rm -f "${pak}.info" || die
		fi
	done

	popd >/dev/null || die
}

# @FUNCTION: bintron_system_replace
# @DESCRIPTION:
# Replace bundled libraries with system libraries.
bintron_system_replace() {
	pushd "${1:=.}" >/dev/null || die

	if use system-ffmpeg; then
		echo "Replacing bundled libffmpeg"

		rm ./libffmpeg.so ||
			die "Failed: remove bundled libffmpeg"
		ln -s "${EROOT}"/usr/lib64/chromium/libffmpeg.so . ||
			die "Failed: link libffmpeg"
	fi
	if use system-vulkan; then
		echo "Replacing bundled libvulkan"

		if [[ -f ./libvulkan.so ]]; then
			rm ./libvulkan.so ||
				die "Failed: remove bundled libvulkan"
			ln -s "${EROOT}"/usr/lib64/libvulkan.so . ||
				die "Failed: link libvulkan"
		elif [[ -f ./libvulkan.so.1 ]]; then
			rm ./libvulkan.so.1 ||
				die "Failed: remove bundled libvulkan"
			ln -s "${EROOT}"/usr/lib64/libvulkan.so.1 . ||
				die "Failed: link libvulkan"
		fi
	fi

	popd >/dev/null || die
}

# @FUNCTION: bintron_src_prepare
# @DESCRIPTION:
# Default src_prepare.
bintron_src_prepare() {
	xdg_environment_reset
	default

	bintron_remove_language_paks .
	bintron_system_replace .
}

# @FUNCTION: bintron_src_compile
# @DESCRIPTION:
# Default src_compile.
bintron_src_compile() {
	true
}

# @FUNCTION: bintron_install_copy
# @DESCRIPTION:
# Install all the files in a given directory, or current directory.
bintron_install_copy() {
	local dir="${1:=.}"

	mkdir -p "${ED}/${BINTRON_HOME}" || die "Failed: mkdir"
	cp -r "${dir}"/* "${ED}/${BINTRON_HOME}" || die "Failed: copy $(pwd)"
}

# @FUNCTION: bintron_prepare_bin
# @DESCRIPTION:
# Preparation for bintron_link_bin.
# If there is no "bin" directory and a file named "${PN}" exists,
# then create a link from from "bin/${PN}" to "${PN}".
bintron_prepare_bin() {
	local dir="${1:=.}"

	mkdir -p "${dir}"/bin || die
	ln -s "${dir}"/../${PN} "${dir}"/bin/${PN} || die
}

# @FUNCTION: bintron_link_bin
# @DESCRIPTION:
# Link launchers in "bin" directory.
bintron_link_bin() {
	local dir="${1:=.}"

	if [[ -d "${dir}"/bin ]]; then
		local bin
		for bin in "${dir}"/bin/*; do
			mkdir -p "${ED}/usr/bin/" || die "Failed: mkdir"
			chmod +x "${bin}" || die "Failed: make ${bin} executable"

			local binname
			binname="$(basename "${bin}")"
			ln -s "${BINTRON_HOME}/${binname}" "${ED}/usr/bin/${binname}" ||
				die "Failed: link ${bin}"
		done
	fi
}

# @FUNCTION: bintron_src_install
# @DESCRIPTION:
# Default src_install.
bintron_src_install() {
	if [[ ! -d ./bin ]] && [[ -f ./${PN} ]]; then
		bintron_prepare_bin .
	fi
	bintron_link_bin .

	bintron_install_copy .
}

# @FUNCTION: bintron_pkg_postinst
# @DESCRIPTION:
# Default pkg_postinst.
bintron_pkg_postinst() {
	xdg_pkg_postinst
	optfeature "password storage" app-crypt/libsecret kde-frameworks/kwallet
}
