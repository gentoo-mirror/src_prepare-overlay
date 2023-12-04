# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS="26.1"

inherit elisp

DESCRIPTION="Timestamp and date/time library"
HOMEPAGE="https://github.com/alphapapa/ts.el"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alphapapa/ts.el.git"
else
	MY_PN="${PN}.el"
	SRC_URI="https://github.com/alphapapa/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${PV}"

	KEYWORDS="~amd64"
	RESTRICT="test"
fi

LICENSE="GPL-3"
SLOT="0"

SITEFILE="50${PN}-gentoo.el"

DEPEND="
	>=app-emacs/dash-2.14.1
	>=app-emacs/s-1.12.0
"
RDEPEND="${DEPEND}"

src_test() {
	emake test
}
