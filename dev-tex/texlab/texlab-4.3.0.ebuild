# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	ahash-0.7.6
	aho-corasick-0.7.19
	anes-0.1.6
	ansi_term-0.12.1
	anyhow-1.0.65
	assert_unordered-0.3.5
	atty-0.2.14
	autocfg-1.1.0
	beef-0.5.2
	bitflags-1.3.2
	block-buffer-0.10.3
	bumpalo-3.11.0
	byteorder-1.4.3
	cast-0.3.0
	cfg-if-1.0.0
	chrono-0.4.22
	ciborium-0.2.0
	ciborium-io-0.2.0
	ciborium-ll-0.2.0
	clap-3.2.22
	clap_derive-3.2.18
	clap_lex-0.2.4
	console-0.15.1
	countme-3.0.1
	cpufeatures-0.2.5
	crc32fast-1.3.2
	criterion-0.4.0
	criterion-plot-0.5.0
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.10
	crossbeam-utils-0.8.11
	crypto-common-0.1.6
	dashmap-5.4.0
	derive_more-0.99.17
	digest-0.10.5
	either-1.8.0
	encode_unicode-0.3.6
	encoding_rs-0.8.31
	encoding_rs_io-0.1.7
	env_logger-0.9.1
	fastrand-1.8.0
	fern-0.6.1
	filetime-0.2.17
	fixedbitset-0.4.2
	flate2-1.0.24
	fnv-1.0.7
	form_urlencoded-1.1.0
	fsevent-sys-4.1.0
	fuzzy-matcher-0.3.7
	generic-array-0.14.6
	getrandom-0.2.7
	half-1.8.2
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.1.19
	human_name-1.3.4
	humantime-2.1.0
	idna-0.3.0
	indexmap-1.9.1
	inotify-0.9.6
	inotify-sys-0.1.5
	insta-1.20.0
	instant-0.1.12
	isocountry-0.3.2
	itertools-0.10.5
	itoa-1.0.3
	jod-thread-0.1.2
	joinery-2.1.0
	js-sys-0.3.60
	kqueue-1.0.6
	kqueue-sys-1.0.3
	lazy_static-1.4.0
	libc-0.2.133
	linked-hash-map-0.5.6
	lock_api-0.4.9
	log-0.4.17
	logos-0.12.1
	logos-derive-0.12.1
	lsp-server-0.6.0
	lsp-types-0.93.1
	memchr-2.5.0
	memoffset-0.6.5
	miniz_oxide-0.5.4
	mio-0.8.4
	notify-5.0.0
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.13.1
	once_cell-1.15.0
	oorandom-11.1.3
	os_str_bytes-6.3.0
	parking_lot_core-0.9.3
	percent-encoding-2.2.0
	pest-2.3.1
	pest_derive-2.3.1
	pest_generator-2.3.1
	pest_meta-2.3.1
	petgraph-0.6.2
	plotters-0.3.4
	plotters-backend-0.3.4
	plotters-svg-0.3.3
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.44
	quote-1.0.21
	rayon-1.5.3
	rayon-core-1.9.3
	redox_syscall-0.2.16
	regex-1.6.0
	regex-syntax-0.6.27
	remove_dir_all-0.5.3
	rowan-0.15.9
	rustc-hash-1.1.0
	rustversion-1.0.9
	ryu-1.0.11
	same-file-1.0.6
	scopeguard-1.1.0
	serde-1.0.145
	serde_derive-1.0.145
	serde_json-1.0.85
	serde_millis-0.1.1
	serde_regex-1.1.0
	serde_repr-0.1.9
	sha1-0.10.5
	similar-2.2.0
	smallstr-0.3.0
	smallvec-1.9.0
	smol_str-0.1.23
	strum-0.24.1
	strum_macros-0.24.3
	syn-1.0.100
	tempfile-3.3.0
	termcolor-1.1.3
	terminal_size-0.1.17
	text-size-1.1.0
	textwrap-0.15.1
	thiserror-1.0.36
	thiserror-impl-1.0.36
	thread_local-1.1.4
	threadpool-1.8.1
	tinytemplate-1.2.1
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	titlecase-2.2.0
	typenum-1.15.0
	ucd-trie-0.1.5
	unicode-bidi-0.3.8
	unicode-case-mapping-0.3.0
	unicode-ident-1.0.4
	unicode-normalization-0.1.22
	unicode-segmentation-1.10.0
	unidecode-0.3.0
	url-2.3.1
	uuid-1.1.2
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
	yaml-rust-0.4.5
"

inherit cargo

DESCRIPTION="LaTeX Language Server"
HOMEPAGE="https://github.com/latex-lsp/texlab"
SRC_URI="
	https://github.com/latex-lsp/texlab/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="Apache-2.0 BSD GPL-3 ISC MIT Unicode-DFS-2016 || ( Artistic CC0-1.0 )"
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
