# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_HASH="88a87fadae6629932d9c160f53ad5d79775f8f94"

inherit multiprocessing toolchain-funcs readme.gentoo-r1 flag-o-matic

DESCRIPTION="Port of many Plan 9 programs and libraries"
HOMEPAGE="https://9fans.github.io/plan9port/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/9fans/${PN}.git"
else
	SRC_URI="https://github.com/9fans/${PN}/archive/${GIT_HASH}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${GIT_HASH}"
fi

LICENSE="MIT RSA Apache-2.0 public-domain BitstreamVera BZIP2
		!freefonts? ( BigelowHolmes )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="X aqua -freefonts truetype"
REQUIRED_USE="?? ( X aqua )"

DEPEND="
	X? ( x11-apps/xauth )
	truetype? (
		media-libs/freetype
		media-libs/fontconfig
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-noexecstack.patch"
	"${FILESDIR}/${PN}-cflags.patch"
	"${FILESDIR}/${PN}-builderr.patch"
)

# 9port calls the installation directory "PLAN9"
PLAN9="/opt/plan9/"
EPLAN9="${EPREFIX}/${PLAN9}"

DOC_CONTENTS="Plan 9 from User Space has been successfully installed into
${PLAN9}. Your PLAN9 and PATH environment variables have
also been appropriately set, please use env-update and
source /etc/profile to bring that into immediate effect.

Please note that ${PLAN9}/bin has been appended to the
*end* or your PATH to prevent conflicts. To use the Plan9
versions of common UNIX tools, use the absolute path:
${PLAN9}/bin or the 9 command (eg: 9 troff)."
DISABLE_AUTOFORMATTING="yes"

QA_MULTILIB_PATHS="${PLAN9}/.*/.*"

src_prepare() {
	default

	if use freefonts; then
		pushd font >/dev/null || die
		rm -r big5 fixed jis luc{,m,sans} misc naga10 pelm shinonome || die
		popd >/dev/null || die
		rm -r postscript/font/luxi || die
	fi

	case "${CHOST}" in
		*apple* )
			sed -i 's/--noexecstack/-noexecstack/' src/mkhdr ||
				die "Failed to sed AFLAGS"
			;;
		* )
			rm -rf mac || die
			;;
	esac

	# Don't hardcode /bin and /usr/bin in PATH
	sed -i '/PATH/s,/bin:/usr/bin:,,' INSTALL || die "sed on \"INSTALL\" failed"

	# Don't hardcode /usr/{,local/}include and prefix /usr/include/*
	sed -Ei  \
		-e 's,-I/usr(|/local)/include ,,g'  \
		-e "s,-I/usr(|/local)/include,-I${EPREFIX}/usr\1/include,g"  \
		src/cmd/fontsrv/freetyperules.sh INSTALL $(find . -name "makefile") ||
		die "sed failed"

	# Fix paths, done in place of ./INSTALL -c
	einfo "Fixing hard-coded /usr/local/plan9 paths"
	sed -i "s,/usr/local/plan9,${EPLAN9},g" $(grep -lr "/usr/local/plan9") ||
		die "sed failed"
}

src_configure() {
	tc-export CC
	filter-flags -fno-common
	append-cflags -fcommon

	local -a myconf=(
		CC9="$(tc-getCC)"
		CC9FLAGS="'${CFLAGS} ${LDFLAGS}'"
	)

	if use X; then
		myconf+=( WSYSTYPE="x11" )
	elif use aqua; then
		local wsystype
		wsystype="$(
			awk '{if ($1 > 10.5) print "osx-cocoa"; else print "osx"}'  \
				<<< "${MACOSX_DEPLOYMENT_TARGET}"
		)"
		myconf+=( WSYSTYPE="${wsystype}" )
	else
		myconf+=( WSYSTYPE="nowsys" )
	fi

	if use truetype; then
		myconf+=( FONTSRV="fontsrv" )
	else
		myconf+=( FONTSRV= )
	fi

	printf '%s\n' "${myconf[@]}" >> LOCAL.config ||
		die "cannot create configuration"
}

src_compile() {
	# The INSTALL script builds mk then [re]builds everything using that
	NPROC="$(makeopts_jobs)" sh ./INSTALL -b || die
}

src_install() {
	einstalldocs
	readme.gentoo_create_doc

	# Clean up compiled code & source
	rm -rf src || die

	# do* plays with the executable bit, and we should not modify them
	dodir "${PLAN9}"
	cp -a ./* "${ED}/${PLAN9}/" || die

	# Build the environment variables and install them in env.d
	newenvd - 60plan9 <<-EOF
		PLAN9="${EPLAN9}"
		PATH="${EPLAN9}/bin"
		ROOTPATH="${EPLAN9}/bin"
		MANPATH="${EPLAN9}/man"
	EOF
}

pkg_postinst() {
	readme.gentoo_print_elog
}
