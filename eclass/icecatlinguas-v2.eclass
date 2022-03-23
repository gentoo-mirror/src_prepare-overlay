# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: icecatlinguas-v2.eclass
# @MAINTAINER:
# moog621@gmail.com
# @AUTHOR:
# moog621@gmail.com
# @SUPPORTED_EAPIS: 2 3 4 5 6
# @BLURB: Handle language packs for gnuzilla products
# @DESCRIPTION:
# Sets IUSE according to MOZ_LANGS (language packs available). Also exports
# src_unpack, src_compile and src_install for use in ebuilds, and provides
# supporting functions for langpack generation and installation.

inherit mozextension

case "${EAPI:-0}" in
	0|1)
		die "EAPI ${EAPI:-0} does not support the '->' SRC_URI operator";;
	2|3|4|5|6)
		EXPORT_FUNCTIONS src_unpack src_compile src_install;;
	*)
		die "EAPI ${EAPI} is not supported, contact eclass maintainers";;
esac

# @ECLASS_VARIABLE: MOZ_LANGS
# @DESCRIPTION:
# Array containing the list of language pack xpis available for
# this release. The list can be updated with scripts/get_langs.sh from the
# mozilla overlay.
: ${MOZ_LANGS:=()}

# @ECLASS_VARIABLE: MOZ_PV
# @DESCRIPTION:
# Ebuild package version converted to equivalent upstream version.
# Defaults to ${PV}, and should be overridden for alphas, betas, and RCs
: ${MOZ_PV:="${PV}"}

# @ECLASS_VARIABLE: MOZ_PN
# @DESCRIPTION:
# Ebuild package name converted to equivalent upstream name.
# Defaults to ${PN}, and should be overridden for binary ebuilds.
: ${MOZ_PN:="${PN}"}

# @ECLASS_VARIABLE: MOZ_P
# @DESCRIPTION:
# Ebuild package name + version converted to upstream equivalent.
# Defaults to ${MOZ_PN}-${MOZ_PV}
: ${MOZ_P:="${MOZ_PN}-${MOZ_PV}"}

# @ECLASS_VARIABLE: MOZ_FTP_URI
# @DESCRIPTION:
# The ftp URI prefix for the release tarballs and language packs.
: ${MOZ_FTP_URI:=""}

# @ECLASS_VARIABLE: MOZ_HTTP_URI
# @DESCRIPTION:
# The http URI prefix for the release tarballs and language packs.
: ${MOZ_HTTP_URI:=""}

# @ECLASS_VARIABLE: MOZ_LANGPACK_HTTP_URI
# @DESCRIPTION:
# An alternative http URI if it differs from official mozilla URI.
# Defaults to whatever MOZ_HTTP_URI was set to.
: ${MOZ_LANGPACK_HTTP_URI:=${MOZ_HTTP_URI}}

# @ECLASS_VARIABLE: MOZ_LANGPACK_PREFIX
# @DESCRIPTION:
# The relative path till the lang code in the langpack file URI.
# Defaults to ${MOZ_PV}/langpacks
: ${MOZ_LANGPACK_PREFIX:="${MOZ_PV}/langpacks/${MOZ_P}."}

# @ECLASS_VARIABLE: MOZ_LANGPACK_SUFFIX
# @DESCRIPTION:
# The suffix after the lang code in the langpack file URI.
# Defaults to '.xpi'
: ${MOZ_LANGPACK_SUFFIX:=".langpack.xpi"}

# @ECLASS_VARIABLE: MOZ_LANGPACK_UNOFFICIAL
# @DESCRIPTION:
# The status of the langpack, used to differentiate within
# Manifests and on Gentoo mirrors as to when the langpacks are
# generated officially by gnuzilla or if they were generated
# unofficially by others.  When
# this var is set, the distfile will have a .unofficial.xpi
# suffix.
: ${MOZ_LANGPACK_UNOFFICIAL:=""}

# @ECLASS_VARIABLE: MOZ_GENERATE_LANGPACKS
# @DESCRIPTION:
# This flag specifies whether or not the langpacks should be
# generated directly during the build process, rather than
# being downloaded and installed from upstream pre-built
# extensions.  Primarily it supports pre-release builds.
# Defaults to empty.
: ${MOZ_GENERATE_LANGPACKS:=""}

# @ECLASS_VARIABLE: MOZ_L10N_SOURCEDIR
# @DESCRIPTION:
# The path that l10n sources can be found at, once unpacked.
# Defaults to ${WORKDIR}/l10n-sources
: ${MOZ_L10N_SOURCEDIR:="${WORKDIR}/l10n-sources"}

# @ECLASS_VARIABLE: MOZ_L10N_URI_PREFIX
# @DESCRIPTION:
# The full URI prefix of the distfile for each l10n locale.  The
# AB_CD and MOZ_L10N_URI_SUFFIX will be appended to this to complete the
# SRC_URI when MOZ_GENERATE_LANGPACKS is set.  If empty, nothing will
# be added to SRC_URI.
# Defaults to empty.
: ${MOZ_L10N_URI_PREFIX:=""}

# @ECLASS_VARIABLE: MOZ_L10N_URI_SUFFIX
# @DESCRIPTION:
# The suffix of l10n source distfiles.
# Defaults to '.tar.xz'
: ${MOZ_L10N_URI_SUFFIX:=".tar.xz"}

# @ECLASS_VARIABLE: MOZ_FORCE_UPSTREAM_L10N
# @DESCRIPTION:
# Set this to use upstream langpaks even if the package normally
# shouldn't (ie it is an alpha or beta package)
: ${MOZ_FORCE_UPSTREAM_L10N:=""}

# @ECLASS_VARIABLE: MOZ_TOO_REGIONALIZED_FOR_L10N
# @INTERNAL
# @DESCRIPTION:
# Upstream identifiers that should not contain region subtags in L10N
MOZ_TOO_REGIONALIZED_FOR_L10N=( fy-NL ga-IE gu-IN hi-IN hy-AM nb-NO nn-NO pa-IN sv-SE )

# @ECLASS_VARIABLE: MOZ_INSTALL_L10N_XPIFILE
# @DESCRIPTION:
# Install langpacks as .xpi file instead of unpacked directory.
# Leave unset to install unpacked
: ${MOZ_INSTALL_L10N_XPIFILE:=""}

# Add l10n_* to IUSE according to available language packs
# No language packs for alphas and betas
if ! [[ -n ${MOZ_GENERATE_LANGPACKS} ]] ; then
	if ! [[ ${PV} =~ alpha|beta ]] || { [[ ${PN} == seamonkey ]] && ! [[ ${PV} =~ alpha ]] ; } || [[ -n ${MOZ_FORCE_UPSTREAM_L10N} ]] ; then
	[[ -z ${MOZ_FTP_URI} ]] && [[ -z ${MOZ_LANGPACK_HTTP_URI} ]] && die "No URI set to download langpacks, please set one of MOZ_{FTP,HTTP_LANGPACK}_URI"
	for x in "${MOZ_LANGS[@]}" ; do
		# en and en_US are handled internally
		if [[ ${x} == en ]] || [[ ${x} == en-US ]]; then
			continue
		fi
		# strip region subtag if $x is in the list
		if has ${x} "${MOZ_TOO_REGIONALIZED_FOR_L10N[@]}" ; then
			xflag=${x%%-*}
		else
			xflag=${x}
		fi
		SRC_URI+=" l10n_${xflag/[_@]/-}? ("
		[[ -n ${MOZ_FTP_URI} ]] && SRC_URI+="
			${MOZ_FTP_URI}/${MOZ_LANGPACK_PREFIX}${x}${MOZ_LANGPACK_SUFFIX} -> ${MOZ_P}.${x}${MOZ_LANGPACK_UNOFFICIAL:+.unofficial}.xpi"
		[[ -n ${MOZ_LANGPACK_HTTP_URI} ]] && SRC_URI+="
			${MOZ_LANGPACK_HTTP_URI}/${MOZ_LANGPACK_PREFIX}${x}${MOZ_LANGPACK_SUFFIX} -> ${MOZ_P}.${x}${MOZ_LANGPACK_UNOFFICIAL:+.unofficial}.xpi"
		SRC_URI+=" )"
		IUSE+=" l10n_${xflag/[_@]/-}"
#		einfo "MOZ_LANGPACK_HTTP_URI: ${MOZ_LANGPACK_HTTP_URI}"
#		einfo "MOZ_LANGPACK_PREFIX: ${MOZ_LANGPACK_PREFIX}"
#		einfo "x: ${x}"
#		einfo "MOZ_LANGPACK_SUFFIX: ${MOZ_LANGPACK_SUFFIX}"
		# We used to do some magic if specific/generic locales were missing, but
		# we stopped doing that due to bug 325195.
	done
	fi
else
	for x in "${MOZ_LANGS[@]}" ; do
		# en and en_US are handled internally
		if [[ ${x} == en ]] || [[ ${x} == en-US ]]; then
			continue
		fi
		# strip region subtag if $x is in the list
		if has ${x} "${MOZ_TOO_REGIONALIZED_FOR_L10N[@]}" ; then
			xflag=${x%%-*}
		else
			xflag=${x}
		fi
		if [[ -n ${MOZ_L10N_URI_PREFIX} ]]; then
			SRC_URI+=" l10n_${xflag/[_@]/-}? ( ${MOZ_L10N_URI_PREFIX}${x}${MOZ_L10N_URI_SUFFIX} )"
		fi
		IUSE+=" l10n_${xflag/[_@]/-}"
	done
fi
unset x xflag

# @FUNCTION: icecatlinguas_export
# @INTERNAL
# @DESCRIPTION:
# Generate the list of language packs called "icecatlinguas"
# This list is used to unpack and install the xpi language packs
icecatlinguas_export() {
	if [[ ${PN} == seamonkey ]] ; then
		[[ ${PV} =~ alpha ]] && ! [[ -n ${MOZ_GENERATE_LANGPACKS} ]] && return
	else
		[[ ${PV} =~ alpha|beta ]] && ! [[ -n ${MOZ_GENERATE_LANGPACKS} ]] && return
	fi
	local lingua lflag
	icecatlinguas=()
	# Set icecatlinguas based on the enabled l10n_* USE flags.
	for lingua in "${MOZ_LANGS[@]}"; do
		# strip region subtag if $x is in the list
		if has ${lingua} en en-US; then
			# For gnuzilla products, en and en_US are handled internally
			continue
		elif has ${lingua} "${MOZ_TOO_REGIONALIZED_FOR_L10N[@]}" ; then
			lflag=${lingua%%-*}
		else
			lflag=${lingua}
		fi
		use l10n_${lflag/[_@]/-} && icecatlinguas+=( ${lingua} )
	done
	# Compatibility code - Check LINGUAS and warn if anything set there isn't enabled via l10n
	for lingua in ${LINGUAS}; do
		if has ${lingua//[_@]/-} en en-US; then
			# For gnuzilla products, en and en_US are handled internally
			continue
		# If this language is supported by ${P},
		elif has ${lingua} "${MOZ_LANGS[@]//-/_}"; then
			# Warn the language is missing, if it isn't already there
			has ${lingua//[_@]/-} "${icecatlinguas[@]//[_@]/-}" || \
				ewarn "LINGUAS value ${lingua} is not enabled using L10N use flags"
			continue
		# For each short lingua that isn't in MOZ_LANGS,
		# We used to add *all* long MOZ_LANGS to the icecatlinguas list,
		# but we stopped doing that due to bug 325195.
		else
			:
		fi
		einfo "Sorry, but ${P} does not support the ${lingua} locale in LINGUAS"
	done
}

# @FUNCTION: icecatlinguas_src_unpack
# @DESCRIPTION:
# Unpack xpi language packs according to the user's LINGUAS settings
icecatlinguas_src_unpack() {
	local x
	einfo "LOL"
	if ! [[ -n ${MOZ_GENERATE_LANGPACKS} ]]; then
		icecatlinguas_export
		for x in "${icecatlinguas[@]}"; do
			# FIXME: Add support for unpacking xpis to portage
			xpi_unpack "${MOZ_P}.${x}${MOZ_LANGPACK_UNOFFICIAL:+.unofficial}.xpi"
		done
		if [[ "${icecatlinguas[*]}" != "" && "${icecatlinguas[*]}" != "en" ]]; then
			einfo "Selected language packs (first will be default): ${icecatlinguas[*]}"
		fi
	fi
}
# For the phase function export
icecatlinguas-v2_src_unpack() {
	icecatlinguas_src_unpack
}


# @FUNCTION: icecatlinguas_mozconfig
# @DESCRIPTION:
# if applicable, add the necessary flag to .mozconfig to support
# the generation of locales.  Note that this function requires
# mozconfig_annontate to already be declared via an inherit of
# mozconfig or mozcoreconf.
icecatlinguas_mozconfig() {
	if [[ -n ${MOZ_GENERATE_LANGPACKS} ]]; then
		if declare -f mozconfig_annotate >/dev/null ; then
			mozconfig_annotate 'for building locales' --with-l10n-base=${MOZ_L10N_SOURCEDIR}
		else
			die "Could not configure l10n-base, mozconfig_annotate not declared -- missing inherit?"
		fi
	fi
}

# @FUNCTION: icecatlinguas_src_compile
# @DESCRIPTION:
# if applicable, build the selected locales.
icecatlinguas_src_compile() {
	if [[ -n ${MOZ_GENERATE_LANGPACKS} ]]; then
		# leverage BUILD_OBJ_DIR if set otherwise assume PWD.
		local x y targets=( "langpack" ) localedir="${BUILD_OBJ_DIR:-.}"
		case ${PN} in
			*firefox)
				localedir+="/browser/locales"
				;;
			seamonkey)
				localedir+="/suite/locales"
				;;
			*thunderbird)
				localedir+="/mail/locales"
				targets+=( "calendar-langpack" )
				;;
			*) die "Building locales for ${PN} is not supported."
		esac
		pushd "${localedir}" > /dev/null || die
		icecatlinguas_export
		for x in "${icecatlinguas[@]}"; do for y in "${targets[@]}"; do
			emake ${y}-${x} LOCALE_MERGEDIR="./${y}-${x}"
		done; done
		popd > /dev/null || die
	fi
}

# For the phase function export
icecatlinguas-v2_src_compile() {
	icecatlinguas_src_compile
}

# @FUNCTION: icecatlinguas_xpistage_langpacks
# @DESCRIPTION:
# Add extra langpacks to the xpi-stage dir for prebuilt plugins
#
# First argument is the path to the extension
# Second argument is the prefix of the source (same as first if unspecified)
# Remaining arguments are the modules in the extension that are localized
#  (basename of first if unspecified)
#
# Example - installing extra langpacks for lightning:
# src_install() {
# 	... # general installation steps
# 	icecatlinguas_xpistage_langpacks \
#		"${BUILD_OBJ_DIR}"/dist/xpi-stage/lightning \
#		"${WORKDIR}"/lightning \
#		lightning calendar
#	... # proceed with installation from the xpi-stage dir
# }

icecatlinguas_xpistage_langpacks() {
	local l c modpath="${1}" srcprefix="${1}" modules=( "${1##*/}" )
	shift
	if [[ -n ${1} ]] ; then srcprefix="${1}" ; shift ; fi
	if [[ -n ${1} ]] ; then modules=( $@ ) ; fi

	icecatlinguas_export
	mkdir -p "${modpath}/chrome" || die
	for l in "${icecatlinguas[@]}"; do	for c in "${modules[@]}" ; do
		if [[ -e "${srcprefix}-${l}/chrome/${c}-${l}" ]]; then
			cp -RLp -t "${modpath}/chrome" "${srcprefix}-${l}/chrome/${c}-${l}" || die
			grep "locale ${c} ${l} chrome/" "${srcprefix}-${l}/chrome.manifest" \
				>>"${modpath}/chrome.manifest" || die
		elif [[ -e "${srcprefix}/chrome/${c}-${l}" ]]; then
			cp -RLp -t "${modpath}/chrome" "${srcprefix}/chrome/${c}-${l}" || die
			grep "locale ${c} ${l} chrome/" "${srcprefix}/chrome.manifest" \
				>>"${modpath}/chrome.manifest" || die
		else
			ewarn "Locale ${l} was not found for ${c}, skipping."
		fi
	done; done
}

# @FUNCTION: icecatlinguas-v2_src_install
# @DESCRIPTION:
# Install xpi language packs according to the user's L10N settings
# NOTE - uses ${BUILD_OBJ_DIR} or PWD if unset, for source-generated langpacks
icecatlinguas_src_install() {
	local x
	icecatlinguas_export
	if [[ -n ${MOZ_GENERATE_LANGPACKS} ]] && [[ -n ${icecatlinguas[*]} ]]; then
		local repopath="${WORKDIR}/${PN}-generated-langpacks"
		mkdir -p "${repopath}" || die
		pushd "${BUILD_OBJ_DIR:-.}"/dist/*/xpi > /dev/null || die
		for x in "${icecatlinguas[@]}"; do
			cp "${MOZ_P}.${x}.langpack.xpi" \
			"${repopath}/${MOZ_P}.${x}${MOZ_LANGPACK_UNOFFICIAL:+.unofficial}.xpi" || die
			xpi_unpack "${repopath}/${MOZ_P}.${x}${MOZ_LANGPACK_UNOFFICIAL:+.unofficial}.xpi"
		done
		popd > /dev/null || die
	fi

	for x in "${icecatlinguas[@]}"; do
		if [[ -n ${MOZ_INSTALL_L10N_XPIFILE} ]]; then
			xpi_copy "${WORKDIR}/${MOZ_P}.${x}${MOZ_LANGPACK_UNOFFICIAL:+.unofficial}"
		else
			xpi_install "${WORKDIR}/${MOZ_P}.${x}${MOZ_LANGPACK_UNOFFICIAL:+.unofficial}"
		fi
	done
}

# For the phase function export
icecatlinguas-v2_src_install() {
	icecatlinguas_src_install
}
