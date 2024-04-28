# Copyright 1999-2024 Gentoo Authors
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
	SRC_URI="https://github.com/alphapapa/ement.el/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/ement.el-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	>=app-emacs/transient-0.3.7
	>=app-emacs/persist-0.5
	>=app-emacs/plz-0.6
	>=app-emacs/taxy-0.10
	>=app-emacs/taxy-magit-section-0.13
	>=app-emacs/svg-lib-0.2.5
	>=app-emacs/transient-0.3.7
"

DOCS="README.org"

SITEFILE="50${PN}-gentoo.el"

elisp-enable-tests ert "${S}/tests" -l tests/ement-tests.el
