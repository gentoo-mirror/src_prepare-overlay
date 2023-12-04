# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
		https://gitlab.com/src_prepare/${PN}/-/archive/${PV}/${P}.tar.bz2
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-portage/euscan-ng
	app-portage/gentoolkit
	dev-util/pkgcheck
"

src_install() {
	default

	newbin gen-pkgs.sh gen-pkgs
}
