# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

#2023-06-27:
# added 1.2.13 despite it not being declared compatbile for Linux in particular.
# Works fine for me and is declared compatible for Windows and macOS.
WHITELIST_VERSIONS=(
	"~ 1.2.13"
	"~ 1.2.11"
	"~ 1.2.9"
	"~ 1.2.8"
	"~ 1.1.99"
)

DESCRIPTION="Commandline tool to customize Spotify client."
HOMEPAGE="https://spicetify.app/"
SRC_URI="
	https://github.com/spicetify/spicetify-cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/37881342/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"

# no tests
RESTRICT="test"

INSTALLDIR="/opt/${PN}"

whitelist_versions_deps() {
	local -a deps
	local version_spec version1 version2

	for index in ${!WHITELIST_VERSIONS[@]}; do
		read -r version_spec version1 version2 <<< "${WHITELIST_VERSIONS[${index}]}"

		case ${version_spec} in
			"<>")
				deps+=(
					">=media-sound/spotify-${version1}"
					"<=media-sound/spotify-${version2}"
				)
				;;
			"~")
				deps+=( "~media-sound/spotify-${version1}" )
				;;
			*)
				die "Invalid version specifier in WHITELIST_VERSIONS"
				;;
		esac
	done

	RDEPEND=" || ( ${deps[@]} )"
}
whitelist_versions_deps

whitelist_versions_elog() {
	local versions
	local version_spec version1 version2

	# Iterate in reverse
	for ((index = $(( ${#WHITELIST_VERSIONS[@]} - 1 )); index >= 0; index--)); do
		read -r version_spec version1 version2 <<< "${WHITELIST_VERSIONS[${index}]}"

		case ${version_spec} in
			"<>")
				versions+="${version1} -> ${version2}"
				;;
			"~")
				versions+="${version1}"
				;;
			*)
				die "Invalid version specifier in WHITELIST_VERSIONS"
				;;
		esac

		if [[ ${index} == 0 ]]; then
			versions+=". "
		elif [[ ${index} == 1 ]]; then
			versions+=" and "
		else
			versions+=", "
		fi
	done

	echo "${versions}"
}

src_compile() {
	ego build -ldflags "-X main.version=${PV}"
}

src_install() {
	insinto "${INSTALLDIR}"
	doins -r {CustomApps,Extensions,Themes,jsHelper,spicetify-cli}
	dobin "${FILESDIR}/spicetify"
	fperms +x "${INSTALLDIR}/spicetify-cli"
}

pkg_postinst() {
	elog "Spicetify requires a Spotify install that it can modify."
	elog "To give read and write permissions to everyone on the system to run the following commands."
	elog "# chmod a+wr /opt/spotify/spotify-client"
	elog "# chmod a+wr /opt/spotify/spotify-client/Apps -R"
	elog ""
	elog "Spicetify compatibility is limited to the following Spotify versions:"
	elog " $(whitelist_versions_elog)"
	elog ""
	elog "Otherwise you can install spotify to a user modifiable location like as a flatpak:"
	elog " https://spicetify.app/docs/advanced-usage/installation#spotify-installed-from-flatpak"
	elog ""
	elog "To install themes see:"
	elog " https://spicetify.app/docs/advanced-usage/themes"
}
