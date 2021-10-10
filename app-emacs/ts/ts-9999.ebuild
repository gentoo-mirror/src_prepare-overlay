# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
NEED_EMACS="26.1"

inherit elisp git-r3

DESCRIPTION="Timestamp and date/time library"
HOMEPAGE="https://github.com/alphapapa/ts.el"

EGIT_REPO_URI="https://github.com/alphapapa/ts.el.git"
EGIT_BRANCH="master"
EGIT_CLONE_TYPE="single"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"

SITEFILE="50${PN}-gentoo.el"

BDEPEND="
	>=app-emacs/dash-2.14.1
	>=app-emacs/s-1.12.0
"

RDEPEND="${BDEPEND}"

src_test() {
	emake test
}
