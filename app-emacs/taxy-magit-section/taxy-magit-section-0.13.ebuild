# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS="26.3"

inherit elisp

DESCRIPTION="Programmable taxonomical hierarchies for arbitrary objects"
HOMEPAGE="https://github.com/alphapapa/taxy.el"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alphapapa/taxy.el"
	EGIT_BRANCH="package/${PN}"
else
	SRC_URI="https://elpa.gnu.org/packages/${P}.tar"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RESTRICT="test"

DEPEND="
	>=app-emacs/magit-3.2.1
	>=app-emacs/taxy-0.10
"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_install() {
	elisp_src_install
	doinfo ${PN}.info
}
