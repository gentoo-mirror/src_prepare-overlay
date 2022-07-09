# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS="27.1"

inherit elisp

DESCRIPTION="Matrix client for GNU Emacs"
HOMEPAGE="https://github.com/alphapapa/ement.el"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alphapapa/ement.el.git"
else
	SRC_URI="https://elpa.gnu.org/packages/${P}.tar"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="e2e"

RESTRICT="test"

DEPEND="
	>=app-emacs/transient-0.3.7
	>=app-emacs/persist-0.5
	>=app-emacs/plz-0.6
	>=app-emacs/taxy-0.10
	>=app-emacs/taxy-magit-section-0.12.1
	>=app-emacs/svg-lib-0.2.5
	>=app-emacs/transient-0.3.7
"

DOCS="README.org"

SITEFILE="50${PN}-gentoo.el"
