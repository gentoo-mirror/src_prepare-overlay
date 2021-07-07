# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Create HTML page based off of a given overlay URL"
HOMEPAGE="https://gitlab.com/src_prepare/gen-pkgs"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="
		https://gitlab.com/src_prepare/${PN}.git
		https://github.com/xgqt/${PN}.git
	"
else
	SRC_URI="
		https://gitlab.com/src_prepare/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz
		https://github.com/xgqt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-portage/euscan-ng
	app-portage/gentoolkit
	app-portage/repoman
	sys-apps/busybox
"

src_install() {
	default

	newbin gen-pkgs.sh gen-pkgs
}
