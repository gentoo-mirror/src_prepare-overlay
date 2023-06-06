# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Commandline tool to customize Spotify client."
HOMEPAGE="https://spicetify.app/"
SRC_URI="
	https://github.com/spicetify/spicetify-cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/37881342/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"

INSTALLDIR="/opt/${PN}"

RDEPEND="
	|| (
		~media-sound/spotify-1.2.9
		~media-sound/spotify-1.2.8
		~media-sound/spotify-1.1.99
	)
"

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
	elog " 1.2.9, 1.2.8 and 1.1.99"
	elog ""
	elog "Otherwise you can install spotify to a user modifiable location like as a flatpak:"
	elog " https://spicetify.app/docs/advanced-usage/installation#spotify-installed-from-flatpak"
	elog ""
	elog "To install themes see:"
	elog " https://spicetify.app/docs/advanced-usage/themes"
}
