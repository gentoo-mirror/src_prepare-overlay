# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ie. 2021.12.20 -> 2021-12-25
MY_PV="${PV//./-}"
MY_PN="${PN^}"

inherit xdg

DESCRIPTION="Fluent icon theme for Linux desktops"
HOMEPAGE="https://github.com/vinceliuice/Fluent-icon-theme"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vinceliuice/${MY_PN}.git"
else
	SRC_URI="https://github.com/vinceliuice/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_PN}-${MY_PV}"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="+black +hardlink -round"
RESTRICT="binchecks strip test"

BDEPEND="sys-apps/util-linux[hardlink(-)?]"

src_prepare() {
	default

	sed -i '/gtk-update-icon-cache/d' install.sh || die
}

src_install() {
	dodir /usr/share/icons
	local myinstallopts=(
		--all
		--dest "${ED}/usr/share/icons"
		$(usex black '--black' '')
		$(usex round '--round' '')
	)
	bash ./install.sh "${myinstallopts[@]}" || die "install script failed"

	if use hardlink; then
		einfo "Linking duplicate icons... (may take a long time)"
		hardlink -pot "${ED}/usr/share/icons" || die "hardlink failed"
	fi

	einstalldocs
}
