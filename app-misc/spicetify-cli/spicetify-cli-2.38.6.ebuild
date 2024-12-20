# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PN="cli"

WHITELIST_VERSIONS=(
	"<> 1.2.14 1.2.53"
)

whitelist_versions() {
	local version_spec version1 version2
	local -a deps

	SPOTIFY_VERSIONS=

	# Iterate in reverse for elog
	for ((index = $(( ${#WHITELIST_VERSIONS[@]} - 1 )); index >= 0; index--)); do
		read -r version_spec version1 version2 <<< "${WHITELIST_VERSIONS[${index}]}"

		case ${version_spec} in
			"<>")
				deps[$index]="( <=media-sound/spotify-${version2} >=media-sound/spotify-${version1} )"
				SPOTIFY_VERSIONS+="${version1} -> ${version2}"
				;;
			"~")
				deps[$index]="~media-sound/spotify-${version1}"
				SPOTIFY_VERSIONS+="${version1}"
				;;
			*)
				die "Invalid version specifier in WHITELIST_VERSIONS"
				;;
		esac

		if [[ ${index} == 0 ]]; then
			SPOTIFY_VERSIONS+=". "
		elif [[ ${index} == 1 ]]; then
			SPOTIFY_VERSIONS+=" and "
		else
			SPOTIFY_VERSIONS+=", "
		fi
	done

	RDEPEND=" || ( ${deps[@]} )"
}
whitelist_versions

DESCRIPTION="Commandline tool to customize Spotify client."
HOMEPAGE="https://spicetify.app/"
SRC_URI="
	https://github.com/spicetify/cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/37881342/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0 BSD LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"

# no tests
RESTRICT="test"

INSTALLDIR="/opt/${PN}"

src_compile() {
	ego build -ldflags "-X main.version=${PV}"
}

src_install() {
	insinto "${INSTALLDIR}"
	doins -r {CustomApps,Extensions,Themes,jsHelper,cli}
	newbin - spicetify <<-EOF
	#!/usr/bin/env sh
	exec /opt/spicetify-cli/cli \$@
	EOF
	fperms +x "${INSTALLDIR}/cli"
}

pkg_postinst() {
	elog "Spicetify requires a Spotify install that it can modify."
	elog "To give read and write permissions to everyone on the system to run the following commands as root."
	elog "# chmod a+wr /opt/spotify/spotify-client"
	elog "# chmod a+wr /opt/spotify/spotify-client/Apps -R"
	elog ""
	elog "WARNING: Do not run spicetify as root please"
	elog ""
	elog "Spicetify compatibility is limited to the following Spotify versions:"
	elog " ${SPOTIFY_VERSIONS}"
	elog ""
	elog "Otherwise you can install spotify to a user modifiable location like as a flatpak:"
	elog " https://spicetify.app/docs/advanced-usage/installation#spotify-installed-from-flatpak"
	elog ""
	elog "To install themes see:"
	elog " https://spicetify.app/docs/advanced-usage/themes"

	if $(has_version -r ">=media-sound/spotify-1.2.25"); then
		elog ""
		elog "The New Releases custom app no longer works with Spotify 1.2.25 and higher. As an alternative,"
		elog "please use What's New which was created by Spotify and can be enabled via Experimental Features"
		elog "if it isn't already enabled."
	fi
}
