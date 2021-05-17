# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Scheme interpreter and native Scheme to C compiler"
HOMEPAGE="http://www.call-cc.org/"
SRC_URI="http://code.call-cc.org/releases/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

src_prepare() {
	default

	# Because chicken's Upstream is in the habit of using variables that
	# portage also uses :( eg. $ARCH and $A
	sed "s,A\(\s?=\|)\),chicken&,"  \
		-i Makefile.cross-linux-mingw defaults.make rules.make  || die
	sed "s,ARCH,zARCH,"  \
		-i Makefile.* defaults.make rules.make  || die
	sed -e "s,\$(PREFIX)/lib,\$(PREFIX)/$(get_libdir),"  \
		-e "s,\$(DATADIR)/doc,\$(SHAREDIR)/doc/${PF},"  \
		-i defaults.make || die

	if ! use doc; then
		rm -rf manual  || die
		# Without this Makefile tries to re-bootstrap the compiler
		touch build-version.c
	fi

	export myopts=(
		C_COMPILER_OPTIMIZATION_OPTIONS="${CFLAGS}"
		DESTDIR="${D}"
		HOSTSYSTEM="${CBUILD}"
		LINKER_OPTIONS="${LDFLAGS}"
		PLATFORM="linux"
		PREFIX="/usr"
	)
}

src_compile() {
	emake -j1 "${myopts[@]}"
}

src_test() {
	cd tests  || die
	./runtests.sh  || die
}

src_install() {
	emake -j1 "${myopts[@]}" install

	rm "${D}"/usr/share/doc/${PF}/LICENSE  || die

	einstalldocs

	# Let portage track this file (created later)
	touch "${D}"/usr/$(get_libdir)/chicken/11/types.db  || die
}

pkg_postinst() {
	# Create modules.db file in ${ROOT}
	chicken-install -update-db  || die
}
