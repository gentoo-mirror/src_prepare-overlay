# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Light Ebuild Automated Development Environment Notebook"
HOMEPAGE="https://gitlab.com/src_prepare/leaden"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/src_prepare/leaden.git"
	KEYWORDS=""
else
	# Modify SRC_URI to be suitable when first release is made
	SRC_URI="https://gitlab.com/src_prepare/leaden/-/archive/${PV}/leaden-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

BDEPEND="dev-python/PyQt5[${PYTHON_USEDEP}]"
RDEPEND="
	${BDEPEND}
	app-portage/repoman[${PYTHON_USEDEP}]
	sys-apps/portage[${PYTHON_USEDEP}]
"

src_prepare() {
	emake build
	rm leaden/ui.ui
	default_src_prepare
}
