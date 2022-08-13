# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

go-module_set_globals

DESCRIPTION="Commandline tool to customize Spotify client."
HOMEPAGE="https://github.com/khanhas/spicetify-cli"
SRC_URI="
	https://github.com/khanhas/spicetify-cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/37881342/packages/generic/spicetify-cli/${PV}/spicetify-cli-${PV}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

INSTALLDIR="/opt/${PN}"

RDEPEND="~media-sound/spotify-1.1.84"

PATCHES=( "${FILESDIR}/add_gentoo_install_dir-2.10.2.patch" )

src_compile() {
	ego build
}

src_install() {
	insinto "${INSTALLDIR}"
	doins -r {CustomApps,Extensions,Themes,jsHelper,spicetify-cli}
	dobin "${FILESDIR}/spicetify"
	fperms +x "${INSTALLDIR}/spicetify-cli"
}

pkg_postinst() {
	elog "Spicetify requires a Spotify install that it can modify. Version 1.1.84 is"
	elog "supported by this version of spicetify. To be able to modify system installed "
	elog "Spotify like media-sound/spotify then you have to allow spicetify to read and write"
	elog "to its install location like shown below."
	elog "# chmod a+wr /opt/spotify/spotify-client"
	elog "# chmod a+wr /opt/spotify/spotify-client/Apps -R"
	elog ""
	elog "Otherwise you can install spotify to a user modifiable location like as a flatpak:"
	elog "https://github.com/khanhas/spicetify-cli/wiki/Installation#spotify-installed-from-flatpak"
}
