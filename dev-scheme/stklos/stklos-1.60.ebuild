# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fast and light R7RS Scheme implementation"
HOMEPAGE="https://stklos.net/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/egallesio/STklos.git"
else
	SRC_URI="https://github.com/egallesio/STklos/archive/refs/tags/${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/STklos-${P}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="threads"

DEPEND="
	dev-libs/gmp:=
	dev-libs/libpcre
	dev-libs/libffi
	dev-libs/boehm-gc[threads?]
"
RDEPEND="${DEPEND}"

DOCS=(
	AUTHORS	  ChangeLog       HACKING.md
	NEWS.md   PACKAGES-USED   PORTING-NOTES.md
	README.md SUPPORTED-SRFIS
)

src_prepare() {
	# remove bundled libs
	rm -rf "${S}"/{ffi,gc,gmp,pcre} || die

	default
}

src_configure() {
	local myconf=(
		--enable-threads=$(usex threads pthreads none)
		--without-gmp-light
		--without-provided-ffi
		--without-provided-gc
		--without-provided-regexp
	)
	econf "${myconf[@]}"
}

src_install() {
	einstalldocs

	emake DESTDIR="${D}" install-base-no-strip install-data-recursive
}
