# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/enlightenment-/}"

inherit meson

DESCRIPTION="A clipboard module for Enlightenment E21+ desktop"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/clipboard"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Obsidian-StudiosInc/${MY_PN}.git"
else
	SRC_URI="https://github.com/Obsidian-StudiosInc/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}"/"${MY_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

DEPEND="
	x11-wm/enlightenment
	dev-libs/efl[X]
"
RDEPEND="
	${DEPEND}
"
