# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS="27.1"

inherit elisp

DESCRIPTION="Emacs SVG libraries for creatings tags, icons and bars"
HOMEPAGE="https://github.com/rougier/svg-lib"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rougier/svg-lib"
else
	SRC_URI="https://elpa.gnu.org/packages/svg-lib-${PV}.tar -> ${P}.tar"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RESTRICT="test"

SITEFILE="50${PN}-gentoo.el"
