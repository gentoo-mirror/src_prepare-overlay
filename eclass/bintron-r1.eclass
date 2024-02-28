# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: bintron-r1.eclass
# @MAINTAINER:
# src_prepare group
# @AUTHOR:
# Alfred Wingate <parona@protonmail.com>
# @SUPPORTED_EAPIS: 8
# @PROVIDES: chromium-2 xdg
# @BLURB: Common configuration eclass for binary packages built with Electron
# @DESCRIPTION:
# This eclass is used in Electron packages ebuilds

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_BINTRON_R1_ECLASS} ]]; then
_BINTRON_R1_ECLASS=1

inherit chromium-2 xdg

IUSE="system-ffmpeg"

# musl support?
RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	system-ffmpeg? ( >=media-video/ffmpeg-4.3[chromium] )
"
BDEPEND="
	app-alternatives/gzip
	dev-util/patchelf
"
IDEPEND="
	sys-apps/file
	sys-apps/findutils
"

# @VARIABLE: QA_PREBUILT
# @INTERNAL
# @DESCRIPTION:
# QA variable

# @VARIABLE: QA_PRESTRIPPED
# @INTERNAL
# @DESCRIPTION:
# QA variable

# The package will be already compiled,
# also most likely the package will be pre-stripped too.
QA_PREBUILT='*'
QA_PRESTRIPPED='*'

# @ECLASS_VARIABLE: BINTRON_HOME
# @DESCRIPTION:
# Path where the package contents will we installed.
: ${BINTRON_HOME:="/opt/${PN}/"}

# @ECLASS_VARIABLE: BINTRON_EXECUTABLES
# @DESCRIPTION:
# List of executable symlinks to create
: ${BINTRON_EXECUTABLES:="${PN}"}

# @FUNCTION: bintron-r1_pkg_pretend
# @DESCRIPTION:
# Runs SUID and User namespace checks
bintron-r1_pkg_pretend() {
	# see https://github.com/electron/electron/issues/17972
	chromium_suid_sandbox_check_kernel_config
}

# @FUNCTION: bintron-r1_src_prepare
# @DESCRIPTION:
# Remove pak files.
bintron-r1_src_prepare() {
	default

	pushd locales >/dev/null || die "location change for language cleanup failed"
	chromium_remove_language_paks
	popd >/dev/null || die "location reset for language cleanup failed"

	if [[ -d "${WORKDIR}/usr/share/doc/${PN}" ]]; then
		mv "${WORKDIR}/usr/share/doc/${PN}/" "${WORKDIR}/usr/share/doc/${PF}" || die
	fi

	if [[ -e "${WORKDIR}/usr/share/doc/${PF}/changelog.gz" ]]; then
		pushd "${WORKDIR}/usr/share/doc/${PF}" >/dev/null || die
		unpack "${WORKDIR}"/usr/share/doc/${PF}/changelog.*
		rm "${WORKDIR}"/usr/share/doc/${PF}/changelog.*
		popd >/dev/null || die
	fi

	if use system-ffmpeg; then
		rm libffmpeg.so || die

		local file type
		for file in $(find .); do
			type=$(file -b --mime-type "${file}")
			case ${type} in
				application/x-sharedlib|application/x-pie-executable)
					patchelf --add-rpath /usr/$(get_libdir)/chromium ${file} || die
					;;
			esac
		done
	fi
}

# @FUNCTION: bintron-r1_src_install
# @DESCRIPTION:
# Install
bintron-r1_src_install() {
	insinto "${BINTRON_HOME}"

	doins -r "${S}"/*

	local file type
	for file in $(find .); do
		type=$(file -b --mime-type "${file}")

		case ${type} in
			application/x-sharedlib|application/x-pie-executable|text/x-shellscript)
				fperms 0755 "${BINTRON_HOME}${file#./}"
				;;
		esac
	done

	for executable in ${BINTRON_EXECUTABLES[@]}; do
		dosym "${EPREFIX}${BINTRON_HOME%/}/${executable}" /usr/bin/${executable}
	done

	if [[ -d ${WORKDIR}/usr/share ]]; then
		insinto /usr
		doins -r "${WORKDIR}"/usr/share
	fi
}

fi

EXPORT_FUNCTIONS pkg_pretend src_prepare src_install
