# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg-utils

DESCRIPTION="General purpose, multi-paradigm Lisp-Scheme programming language"
HOMEPAGE="https://racket-lang.org/"
SRC_URI="
	minimal? ( https://download.racket-lang.org/installers/${PV}/${PN}-minimal-${PV}-src-builtpkgs.tgz )
	!minimal? ( https://download.racket-lang.org/installers/${PV}/${P}-src-builtpkgs.tgz )
"

RESTRICT="mirror"
LICENSE="GPL-3+ LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X	+doc +futures +graphics +jit minimal +places +readline +threads"
REQUIRED_USE="
	X? ( graphics )
	futures? ( jit )
"

RDEPEND="
	!dev-tex/slatex
	dev-db/sqlite:3
	dev-libs/libffi
	X? (
	   dev-util/desktop-file-utils
	   x11-libs/gtk+:3[X]
	   x11-misc/shared-mime-info
	)
	graphics? (
		media-libs/libpng:0
		virtual/jpeg:0
		x11-libs/cairo[X?]
		x11-libs/pango[X?]
	)
	readline? (	dev-libs/libedit )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/src"

X_xdg_update() {
	if use X; then
		xdg_desktop_database_update
		xdg_icon_cache_update
	fi
}

src_prepare() {
	default

	rm -r ./bc/foreign/libffi || die "failed to remove bundled libffi"
}

src_configure() {
	# According to vapier, we should use the bundled libtool
	#   such that we don't preclude cross-compile.
	#   Thus don't use --enable-lt=/usr/bin/libtool
	# --enable-bc builds Racket w/o chez backend
	local myconf=(
		--disable-libs
		--disable-strip
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--enable-bc
		--enable-float
		--enable-foreign
		--enable-libffi
		--enable-shared
		$(use_enable X gracket)
		$(use_enable doc docs)
		$(use_enable jit)
		$(use_enable places)
		$(use_enable futures)
		$(use_enable threads pthread)
	)
	econf "${myconf[@]}"
}

src_compile() {
	if use jit; then
		# When the JIT is enabled, a few binaries need to be pax-marked
		# on hardened systems (bug 613634). The trick is to pax-mark
		# them before they're used later in the build system. The
		# following order for racketcgc and racket3m was determined by
		# digging through the Makefile in src/racket to find out which
		# targets would build those binaries but not use them.
		pushd ./bc
		emake cgc-core
		pax-mark m .libs/racketcgc
		pushd ./gc2
		emake all
		popd
		pax-mark m .libs/racket3m
		popd
	fi

	default
}

src_install() {
	default

	# bin -> binbc ; remove this when we use Chez
	pushd "${D}/usr/bin"
	for b in *bc; do
		ln -s "${b}" "${b%bc*}"
	done
	popd

	if use jit
	then
		# The final binaries need to be pax-marked, too, if you want to
		# actually use them. The src_compile marking get lost somewhere
		# in the install process.
		local f
		for f in mred mzscheme racket; do
			pax-mark m "${D}/usr/bin/${f}"
		done

		use X && pax-mark m "${D}/usr/$(get_libdir)/racket/gracket"
	fi

	# raco needs decompressed files for packages doc installation bug 662424
	if use doc; then
		docompress -x "/usr/share/doc/${PF}"
	fi

	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die

	# Create missing desktop files
	if use X; then
		newicon "${D}/usr/share/racket/drracket-exe-icon.png" "racket.png"
		make_desktop_entry "gracket" "GRacket" "racket" "Development;Education;"
		make_desktop_entry "plt-games" "PLT Games" "racket" "Education;Game;"
	fi
}

pkg_postinst() {
	X_xdg_update
}

pkg_postrm() {
	X_xdg_update
}
