# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="ICEcoder"

WEBAPP_MANUAL_SLOT="yes"

inherit webapp

DESCRIPTION="Browser code editor awesomeness"
HOMEPAGE="https://icecoder.net/"
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-lang/php:7.4
	virtual/httpd-php
"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned -R "${MY_HTDOCSDIR}"
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_src_install
}
