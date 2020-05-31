 
# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A glossy client for Matrix, written in QtQuick Controls 2 and C++."
HOMEPAGE="https://gitlab.com/b0/spectral"

inherit eutils cmake-utils git-r3
EGIT_REPO_URI="https://gitlab.com/b0/spectral.git"
EGIT_SUBMODULES=("include/SortFilterProxyModel")
if [[ ${PV} != "9999" ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	app-text/cmark
	dev-qt/qtdeclarative
	dev-qt/qtgui
	dev-qt/qtmultimedia[qml]
	dev-qt/qtwidgets
	>=dev-qt/qtquickcontrols2-5.12
	>=dev-libs/libQuotient-0.6_beta1
	dev-libs/libQtOlm
	dev-libs/qtkeychain
	|| ( media-fonts/roboto media-fonts/noto )
	dev-qt/qtsvg
"

DEPEND="
	${RDEPEND}
	>=dev-qt/qtcore-5.12
"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
