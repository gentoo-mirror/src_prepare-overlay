# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	aho-corasick@0.7.20
	aho-corasick@1.0.1
	anes@0.1.6
	ansi_term@0.12.1
	anstream@0.3.2
	anstyle-parse@0.2.0
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anstyle@1.0.0
	anyhow@1.0.71
	assert_unordered@0.3.5
	autocfg@1.1.0
	beef@0.5.2
	bitflags@1.3.2
	block-buffer@0.10.4
	bstr@1.4.0
	bumpalo@3.12.2
	cast@0.3.0
	cc@1.0.79
	cfg-if@1.0.0
	chrono@0.4.24
	ciborium-io@0.2.1
	ciborium-ll@0.2.1
	ciborium@0.2.1
	clap@4.3.0
	clap_builder@4.3.0
	clap_derive@4.3.0
	clap_lex@0.5.0
	colorchoice@1.0.0
	console@0.15.6
	countme@3.0.1
	cpufeatures@0.2.7
	crc32fast@1.3.2
	criterion-plot@0.5.0
	criterion@0.5.1
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.14
	crossbeam-utils@0.8.15
	crypto-common@0.1.6
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	either@1.8.1
	encode_unicode@0.3.6
	encoding_rs@0.8.32
	encoding_rs_io@0.1.7
	errno-dragonfly@0.1.2
	errno@0.3.1
	fastrand@1.9.0
	fern@0.6.2
	filetime@0.2.21
	flate2@1.0.26
	fnv@1.0.7
	form_urlencoded@1.1.0
	fsevent-sys@4.1.0
	fuzzy-matcher@0.3.7
	generic-array@0.14.7
	getrandom@0.2.9
	globset@0.4.10
	half@1.8.2
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.2.6
	hermit-abi@0.3.1
	human_name@2.0.2
	idna@0.3.0
	inotify-sys@0.1.5
	inotify@0.9.6
	insta@1.29.0
	instant@0.1.12
	io-lifetimes@1.0.10
	is-terminal@0.4.7
	isocountry@0.3.2
	itertools@0.10.5
	itoa@1.0.6
	joinery@2.1.0
	js-sys@0.3.63
	kqueue-sys@1.0.3
	kqueue@1.0.7
	lazy_static@1.4.0
	libc@0.2.144
	linked-hash-map@0.5.6
	linux-raw-sys@0.3.8
	lock_api@0.4.9
	log@0.4.17
	logos-codegen@0.13.0
	logos-derive@0.13.0
	logos@0.13.0
	lsp-server@0.7.0
	lsp-types@0.94.0
	memchr@2.5.0
	memoffset@0.8.0
	miniz_oxide@0.7.1
	mio@0.8.6
	notify@6.0.0
	num-integer@0.1.45
	num-traits@0.2.15
	num_cpus@1.15.0
	once_cell@1.17.1
	oorandom@11.1.3
	option-ext@0.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.7
	percent-encoding@2.2.0
	pest@2.6.0
	pest_derive@2.6.0
	pest_generator@2.6.0
	pest_meta@2.6.0
	phf@0.11.1
	phf_codegen@0.11.1
	phf_generator@0.11.1
	phf_shared@0.11.1
	plotters-backend@0.3.4
	plotters-svg@0.3.3
	plotters@0.3.4
	proc-macro2@1.0.58
	quote@1.0.27
	rand@0.8.5
	rand_core@0.6.4
	rayon-core@1.11.0
	rayon@1.7.0
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex-automata@0.1.10
	regex-syntax@0.6.29
	regex-syntax@0.7.1
	regex@1.8.1
	rowan@0.15.11
	rustc-hash@1.1.0
	rustix@0.37.19
	ryu@1.0.13
	same-file@1.0.6
	scopeguard@1.1.0
	serde@1.0.163
	serde_derive@1.0.163
	serde_json@1.0.96
	serde_regex@1.1.0
	serde_repr@0.1.12
	sha2@0.10.6
	similar@2.2.1
	siphasher@0.3.10
	smallstr@0.3.0
	smallvec@1.10.0
	smol_str@0.2.0
	strsim@0.10.0
	syn@2.0.16
	tempfile@3.5.0
	text-size@1.1.0
	thiserror-impl@1.0.40
	thiserror@1.0.40
	thread_local@1.1.7
	threadpool@1.8.1
	tinytemplate@1.2.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	titlecase@2.2.1
	typenum@1.16.0
	ucd-trie@0.1.5
	unicode-bidi@0.3.13
	unicode-case-mapping@0.4.0
	unicode-ident@1.0.8
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unidecode@0.3.0
	url@2.3.1
	utf8parse@0.2.1
	version_check@0.9.4
	walkdir@2.3.3
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.86
	wasm-bindgen-macro-support@0.2.86
	wasm-bindgen-macro@0.2.86
	wasm-bindgen-shared@0.2.86
	wasm-bindgen@0.2.86
	web-sys@0.3.63
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.0
	yaml-rust@0.4.5
"

inherit cargo

DESCRIPTION="LaTeX Language Server"
HOMEPAGE="https://github.com/latex-lsp/texlab"
SRC_URI="
	https://github.com/latex-lsp/texlab/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
LICENSE+="
	Apache-2.0 BSD ISC MIT Unicode-DFS-2016
	|| ( Artistic CC0-1.0 )
"

SLOT="0"
KEYWORDS="~amd64"

DOCS=( CHANGELOG.md README.md  docs/ )

src_configure() {
	local myfeature=(
		citation
		completion
		fuzzy-matcher
	)
	cargo_src_configure
}

src_install() {
	cargo_src_install
	einstalldocs
}

pkg_postinst() {
	elog "Texlab requires a TeX distribution to function"
	elog "Either virtual/latex-base or dev-tex/tectonic will suffice"
	elog "You can then edit the config to use your chosen TeX distribution"
}
