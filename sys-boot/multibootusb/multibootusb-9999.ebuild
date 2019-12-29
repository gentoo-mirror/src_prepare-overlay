# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1

DESCRIPTION="Create multiboot live Linux on a USB disk"
HOMEPAGE="http://multibootusb.org"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mbusb/multibootusb.git"
else
	SRC_URI="https://github.com/mbusb/multibootusb/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	sys-fs/mtools
	dev-python/pyudev
	sys-apps/util-linux
	dev-python/six[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	sys-block/parted
	app-arch/p7zip
	sys-fs/udisks:2
"
