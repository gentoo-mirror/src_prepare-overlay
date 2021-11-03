# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Helper script for src_prepare-overlay GOG eclass that exports credentials."
HOMEPAGE="https://github.com/grepwood/lgogdownloader-export-credentials"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

SRC_URI="
	https://github.com/grepwood/${PN}/archive/refs/tags/v${PV}.tar.gz
"

RDEPEND="
	app-arch/tar
	app-arch/xz-utils
	sys-apps/coreutils
	sys-apps/sed
	>=games-util/lgogdownloader-3.8
	app-shells/bash:=
"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_compile() {
	cp "${S}/${PN}-${PV}/${PN}" "${S}"
}

src_install() {
	dobin "${PN}"
}
