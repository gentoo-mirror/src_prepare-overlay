# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop bintron

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io/"
SRC_URI="https://github.com/atom/atom/releases/download/v${PV}/atom-amd64.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/atom-${PV}-amd64"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

src_install() {
	doicon "${S}"/atom.png
	make_desktop_entry atom Atom atom "TextEditor;Development;IDE;"

	bintron_src_install
}
