# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.0
	aho-corasick@1.1.1
	anes@0.1.6
	anstream@0.6.11
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.8
	anyhow@1.0.90
	autocfg@1.1.0
	beef@0.5.2
	bitflags@1.3.2
	bitflags@2.4.0
	bstr@1.10.0
	bumpalo@3.14.0
	cast@0.3.0
	castaway@0.2.2
	cfg-if@1.0.0
	chrono@0.4.38
	ciborium-io@0.2.1
	ciborium-ll@0.2.1
	ciborium@0.2.1
	clap@4.5.20
	clap_builder@4.5.20
	clap_derive@4.5.18
	clap_lex@0.7.0
	colorchoice@1.0.0
	compact_str@0.7.1
	countme@3.0.1
	crc32fast@1.3.2
	criterion-plot@0.5.0
	criterion@0.5.1
	crossbeam-channel@0.5.13
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.19
	dirs-sys@0.4.1
	dirs@5.0.1
	dissimilar@1.0.7
	either@1.9.0
	encoding_rs@0.8.34
	encoding_rs_io@0.1.7
	errno@0.3.8
	expect-test@1.5.0
	fastrand@2.1.1
	fern@0.7.0
	file-id@0.2.1
	filetime@0.2.22
	flate2@1.0.34
	fnv@1.0.7
	form_urlencoded@1.2.1
	fsevent-sys@4.1.0
	fuzzy-matcher@0.3.7
	getrandom@0.2.9
	half@1.8.2
	hashbrown@0.14.3
	heck@0.5.0
	hermit-abi@0.3.3
	hermit-abi@0.4.0
	human_name@2.0.4
	idna@0.5.0
	inotify-sys@0.1.5
	inotify@0.9.6
	is-terminal@0.4.13
	isocountry@0.3.2
	itertools@0.10.5
	itertools@0.13.0
	itoa@1.0.9
	js-sys@0.3.64
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy_static@1.4.0
	libc@0.2.161
	linux-raw-sys@0.4.14
	lock_api@0.4.10
	log@0.4.22
	logos-codegen@0.14.2
	logos-derive@0.14.2
	logos@0.14.2
	lsp-server@0.7.7
	lsp-types@0.95.1
	memchr@2.7.1
	memoffset@0.9.0
	minimal-lexical@0.2.1
	miniz_oxide@0.8.0
	mio@0.8.11
	multimap@0.10.0
	nom@7.1.3
	notify-debouncer-full@0.3.2
	notify@6.1.1
	num-traits@0.2.16
	num_cpus@1.16.0
	once_cell@1.20.2
	oorandom@11.1.3
	option-ext@0.2.0
	parking_lot@0.12.3
	parking_lot_core@0.9.8
	pathdiff@0.2.2
	percent-encoding@2.3.1
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	plotters-backend@0.3.5
	plotters-svg@0.3.5
	plotters@0.3.5
	proc-macro2@1.0.76
	quote@1.0.35
	rand@0.8.5
	rand_core@0.6.4
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	rowan@0.15.16
	rustc-hash@1.1.0
	rustc-hash@2.0.0
	rustix@0.38.37
	rustversion@1.0.15
	ryu@1.0.15
	same-file@1.0.6
	scopeguard@1.2.0
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.132
	serde_regex@1.1.0
	serde_repr@0.1.19
	shellexpand@3.1.0
	siphasher@0.3.11
	smallvec@1.11.1
	static_assertions@1.1.0
	strsim@0.11.0
	syn@2.0.48
	tempfile@3.13.0
	text-size@1.1.1
	thiserror-impl@1.0.64
	thiserror@1.0.64
	thread_local@1.1.7
	threadpool@1.8.1
	tinytemplate@1.2.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	titlecase@3.3.0
	uds_windows@1.1.0
	unicode-bidi@0.3.13
	unicode-case-mapping@0.4.0
	unicode-ident@1.0.12
	unicode-normalization@0.1.24
	unicode-segmentation@1.10.1
	unidecode@0.3.0
	url@2.5.2
	utf8parse@0.2.1
	versions@6.3.2
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	web-sys@0.3.64
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
"

inherit cargo

DESCRIPTION="LaTeX Language Server"
HOMEPAGE="https://github.com/latex-lsp/texlab"
SRC_URI="
	https://github.com/latex-lsp/texlab/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

BDEPEND="sys-apps/help2man"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016"

SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/texlab"

DOCS=( CHANGELOG.md README.md )

src_configure() {
	local myfeature=(
		citation
		completion
		fuzzy-matcher
	)
	cargo_src_configure
}

src_install() {
	cargo_src_install --path crates/texlab
	help2man --output=texlab.1 --no-info "$(cargo_target_dir)/texlab" || die
	doman texlab.1
	einstalldocs
}

pkg_postinst() {
	elog "Texlab requires a TeX distribution to function"
	elog "Either virtual/latex-base or dev-tex/tectonic will suffice"
	elog "You can then edit the config to use your chosen TeX distribution"
}
