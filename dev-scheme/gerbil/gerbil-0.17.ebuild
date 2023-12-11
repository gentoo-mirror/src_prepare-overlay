# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools elisp-common toolchain-funcs

DESCRIPTION="Dialect of Scheme designed for Systems Programming"
HOMEPAGE="https://cons.io/ https://github.com/vyzo/gerbil"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mighty-gerbils/gerbil"
else
	SRC_URI="https://github.com/mighty-gerbils/gerbil/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0 LGPL-2.1"
SLOT="0"
IUSE="emacs leveldb lmdb mysql +sqlite +xml yaml +zlib"

# no tests
RESTRICT="test"

SUPPORTED_GAMBIT="
	|| (
		~dev-scheme/gambit-4.9.5
		~dev-scheme/gambit-4.9.4
	)
"

RDEPEND="
	${SUPPORTED_GAMBIT}
	emacs? ( >=app-editors/emacs-23.1:* )
	leveldb? ( dev-libs/leveldb:= )
	lmdb? ( dev-db/lmdb:= )
	mysql? ( dev-db/mysql-connector-c:= )
	sqlite? ( dev-db/sqlite:3 )
	xml? ( dev-libs/libxml2 )
	yaml? ( dev-libs/libyaml )
	zlib? ( sys-libs/zlib )
	dev-libs/openssl:=
"
DEPEND="${RDEPEND}"
BDEPEND="${SUPPORTED_GAMBIT}"

SITEFILE="70${PN}-gentoo.el"

DESTDIR="${EPREFIX}/opt/gerbil"

PATCHES=(
	"${FILESDIR}/gebril-0.17-add-support-for-destdir.patch"
)

src_prepare() {
	# NIH mix of autotools and scheme doesn't install well with autotools switches
	#export GERBIL_HOME="${EPREFIX}/usr/share/${PN}"
	unset GEBRIL_HOME
	unset GERBIL_PATH

	# Verbose build process
	export GAMBCOMP_VERBOSE="yes"

	eapply_user

	eapply ${PATCHES[@]}

	# Really
	sed -i -e "s/v0.16/v${PV}/" -e "s/v0_16/v${PV/./_}/" configure.ac || die

	eautoconf

	sed -i "s|gcc|$(tc-getCC)|g" src/build.sh || die "Failed to fix CC setting"
	sed -i "s|-O2|${CFLAGS}|g" src/build.sh || die "Failed to fix CFLAGS setting"

	sed -i 's|local target_lib_gerbil="${GERBIL_BASE}/lib/gerbil"|local target_lib_gerbil="${GERBIL_BASE}"|' \
		src/build.sh || die
}

src_configure() {

	local myconf=(
		$(use_enable leveldb)
		$(use_enable lmdb)
		$(use_enable mysql)
		$(use_enable sqlite)
		$(use_enable xml libxml)
		$(use_enable yaml libyaml)
		$(use_enable zlib)
	)

	econf ${myconf[@]}
}

src_compile() {
	ewarn "Build is extremely slow and IS NOT PARALLEL ~20min"
	default
}

src_install() {
	emake DESTDIR="${D}" install

	# Move them to better positions. Quite ugly...
	mkdir -p "${D}${DESTDIR}" || die
	mv -T "${D}/usr/lib/gerbil/" "${D}${DESTDIR}" || die
	rm -rf "${D}${DESTDIR}/share" || die
	sed -i -e "s|/usr/lib/gerbil/|${DESTDIR}|" "${D}${DESTDIR}"/bin/gxc || die

	# Remove so that they can be installed with the eclass.
	if use emacs; then
		elisp-compile "${D}/usr/share/emacs/site-lisp/gerbil"/*.el ||
			die "Failed to compile elisp files"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	# Without this the programs compiled with gxc will break!
	newenvd - 99gerbil <<- EOF
	GERBIL_HOME="${DESTDIR}"
	EOF
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
