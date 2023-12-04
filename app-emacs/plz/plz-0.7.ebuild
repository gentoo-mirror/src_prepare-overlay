# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS="26.3"

inherit elisp

DESCRIPTION="An HTTP library for Emacs"
HOMEPAGE="https://github.com/alphapapa/plz.el"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alphapapa/plz.el.git"
else
	MY_PN="${PN}.el"
	SRC_URI="https://github.com/alphapapa/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${PV}"

	KEYWORDS="~amd64"

	# Tests find files git and patching them to work without is too burdensome
	RESTRICT="test"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="net-misc/curl"

SITEFILE="50${PN}-gentoo.el"

src_install() {
	elisp_src_install
	doinfo plz.info
}

src_test() {
	emake test
}
