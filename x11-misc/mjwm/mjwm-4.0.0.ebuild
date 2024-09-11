# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="mjwm creates JWM application menu from (freedesktop) desktop files"
HOMEPAGE="https://github.com/chiku/mjwm"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chiku/${PN}.git"
else
	SRC_URI="https://github.com/chiku/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	elog 'Please note that this program only works with JWM'
	elog 'For more informations see https://github.com/chiku/mjwm'
	elog 'Official JWM GitHub page https://github.com/joewing/jwm'
}
