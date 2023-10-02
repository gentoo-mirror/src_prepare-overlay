# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	aho-corasick@1.1.1
	anes@0.1.6
	ansi_term@0.12.1
	anstream@0.5.0
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	anstyle@1.0.3
	anyhow@1.0.75
	assert_unordered@0.3.5
	autocfg@1.1.0
	beef@0.5.2
	bitflags@1.3.2
	bitflags@2.4.0
	block-buffer@0.10.4
	bstr@1.6.2
	bumpalo@3.14.0
	cast@0.3.0
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.31
	ciborium-io@0.2.1
	ciborium-ll@0.2.1
	ciborium@0.2.1
	clap@4.4.4
	clap_builder@4.4.4
	clap_derive@4.4.2
	clap_lex@0.5.1
	colorchoice@1.0.0
	console@0.15.7
	countme@3.0.1
	cpufeatures@0.2.9
	crc32fast@1.3.2
	criterion-plot@0.5.0
	criterion@0.5.1
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	dissimilar@1.0.7
	either@1.9.0
	encode_unicode@0.3.6
	encoding_rs@0.8.33
	encoding_rs_io@0.1.7
	errno-dragonfly@0.1.2
	errno@0.3.3
	expect-test@1.4.1
	fastrand@2.0.0
	fern@0.6.2
	file-id@0.2.1
	filetime@0.2.22
	flate2@1.0.27
	fnv@1.0.7
	form_urlencoded@1.2.0
	fsevent-sys@4.1.0
	fuzzy-matcher@0.3.7
	generic-array@0.14.7
	getrandom@0.2.10
	globset@0.4.13
	half@1.8.2
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.3.3
	human_name@2.0.2
	idna@0.3.0
	inotify-sys@0.1.5
	inotify@0.9.6
	insta@1.32.0
	is-terminal@0.4.9
	isocountry@0.3.2
	itertools@0.10.5
	itertools@0.11.0
	itoa@1.0.9
	joinery@2.1.0
	js-sys@0.3.64
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy_static@1.4.0
	libc@0.2.148
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.7
	lock_api@0.4.10
	log@0.4.20
	logos-codegen@0.13.0
	logos-derive@0.13.0
	logos@0.13.0
	lsp-server@0.7.4
	lsp-types@0.94.1
	memchr@2.6.3
	memoffset@0.8.0
	memoffset@0.9.0
	miniz_oxide@0.7.1
	mio@0.8.8
	notify-debouncer-full@0.3.1
	notify@6.1.1
	num-traits@0.2.16
	num_cpus@1.16.0
	once_cell@1.18.0
	oorandom@11.1.3
	option-ext@0.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	percent-encoding@2.3.0
	pest@2.7.3
	pest_derive@2.7.3
	pest_generator@2.7.3
	pest_meta@2.7.3
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	plotters-backend@0.3.5
	plotters-svg@0.3.5
	plotters@0.3.5
	proc-macro2@1.0.67
	quote@1.0.33
	rand@0.8.5
	rand_core@0.6.4
	rayon-core@1.12.0
	rayon@1.8.0
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex-automata@0.3.8
	regex-syntax@0.6.29
	regex-syntax@0.7.5
	regex@1.9.5
	rowan@0.15.11
	rustc-hash@1.1.0
	rustix@0.38.14
	ryu@1.0.15
	same-file@1.0.6
	scopeguard@1.2.0
	serde@1.0.188
	serde_derive@1.0.188
	serde_json@1.0.107
	serde_regex@1.1.0
	serde_repr@0.1.16
	sha2@0.10.7
	similar@2.2.1
	siphasher@0.3.11
	smallstr@0.3.0
	smallvec@1.11.1
	strsim@0.10.0
	syn@2.0.37
	tempfile@3.8.0
	text-size@1.1.1
	thiserror-impl@1.0.48
	thiserror@1.0.48
	thread_local@1.1.7
	threadpool@1.8.1
	tinytemplate@1.2.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	titlecase@2.2.1
	typenum@1.17.0
	ucd-trie@0.1.6
	unicode-bidi@0.3.13
	unicode-case-mapping@0.4.0
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unidecode@0.3.0
	url@2.3.1
	utf8parse@0.2.1
	version_check@0.9.4
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	web-sys@0.3.64
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	yaml-rust@0.4.5
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
LICENSE+=" Apache-2.0 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016"

SLOT="0"
KEYWORDS="~amd64"

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
	help2man --output=texlab.1 --no-info "target/$(usex debug debug release)/texlab" || die
	doman texlab.1
	einstalldocs
}

pkg_postinst() {
	elog "Texlab requires a TeX distribution to function"
	elog "Either virtual/latex-base or dev-tex/tectonic will suffice"
	elog "You can then edit the config to use your chosen TeX distribution"
}
