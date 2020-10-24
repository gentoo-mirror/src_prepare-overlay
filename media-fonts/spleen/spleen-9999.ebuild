# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font font-ebdftopcf

DESCRIPTION="Monospaced bitmap font"
HOMEPAGE="https://www.cambus.net/spleen-monospaced-bitmap-fonts/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcambus/${PN}.git"
else
	SRC_URI="https://github.com/fcambus/${PN}/archive/1.7.0.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="BSD-2"
SLOT="0"

DOCS=(
	AUTHORS
	ChangeLog
	README.md
)
