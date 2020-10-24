# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=RMBARKER
DIST_VERSION=1.10
inherit perl-module

DEPEND+="
	dev-perl/Module-Build
"

DESCRIPTION="A filename renaming utility based on perl regular expression used by Debian"

SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	perl-module_src_install

	mv -vf "${D}"/usr/bin/rename "${D}"/usr/bin/prename || die
	mv -vf "${D}"/usr/share/man/man1/rename.1 "${D}"/usr/share/man/man1/prename.1 || die
}
