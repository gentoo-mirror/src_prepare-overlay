# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="C++ functions matching the interface and behavior of python string methods"
HOMEPAGE="https://github.com/imageworks/pystring"

if [[ "${PV}" == "9999" ]];  then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/imageworks/pystring.git"
else
	SRC_URI="https://github.com/imageworks/pystring/archive/v"${PV}".tar.gz -> "${P}".tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="all-rights-reserved"
SLOT="0"

src_compile() {
	emake LIBDIR="${S}" install
	mkdir pystring || die
	mv pystring.h pystring || die
}

src_install() {
	dolib.so libpystring.so{,.0{,.0.0}}
	doheader -r pystring
}
