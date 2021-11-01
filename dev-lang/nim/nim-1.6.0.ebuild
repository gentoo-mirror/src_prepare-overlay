# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 multiprocessing toolchain-funcs

DESCRIPTION="Statically typed, compiled, garbage-collected systems programming language"
HOMEPAGE="https://nim-lang.org"
SRC_URI="https://nim-lang.org/download/${P}.tar.xz"

# Failing tests
RESTRICT="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

QA_FLAGS_IGNORED="
	usr/bin/nim_dbg
	usr/bin/nimble
	usr/bin/nimgrep
	usr/bin/nimpretty
	usr/bin/nimsuggest
	usr/bin/testament
	usr/bin/atlas
"

PATCHES=( "${FILESDIR}/paths.patch" )

function Run() {
	echo "Running: ${@}"
	PATH="${S}/bin:${PATH}" "${@}" || die "ERROR: \"${*}\" failed"
}

src_configure() {
	tc-export CC CXX LD
	export XDG_CACHE_HOME="${T}/cache"
	unset NIMBLE_DIR

	local build_type
	if use debug; then
		build_type="debug"
	else
		build_type="release"
	fi

	export nim_opts=( --parallelBuild:$(makeopts_jobs) -d:${build_type} )

	local nimcfg="$(pwd)/config/nim.cfg"
	Run touch "${nimcfg}"

	echo "gcc.exe            = \"$(tc-getCC)\""  >> "${nimcfg}"
	echo "gcc.linkerexe      = \"$(tc-getCC)\""  >> "${nimcfg}"
	echo "gcc.cpp.exe        = \"$(tc-getCXX)\"" >> "${nimcfg}"
	echo "gcc.cpp.linkerexe  = \"$(tc-getCXX)\"" >> "${nimcfg}"
}

src_compile() {
	Run bash ./build.sh
	Run nim compile ${nim_opts[@]} ./koch.nim
	Run ./koch tools ${nim_opts[@]}
}

# src_test() {
#	Run ./koch test
# }

src_install() {
	Run ./koch install "${ED}"

	exeinto /usr/bin
	local exe
	for exe in ./bin/*; do
		doexe "${exe}"
	done

	newbashcomp ./tools/nim.bash-completion nim
	newbashcomp ./dist/nimble/nimble.bash-completion nimble
}
