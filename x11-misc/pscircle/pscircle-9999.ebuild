# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Visualizes Linux processes in a radial tree"
HOMEPAGE="https://gitlab.com/mildlyparallel/pscircle"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/mildlyparallel/${PN}.git"
else
	SRC_URI="https://gitlab.com/mildlyparallel/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"

DEPEND="
	x11-libs/cairo
"
RDEPEND="
	${DEPEND}
	media-libs/libpng
	x11-libs/libX11
"
