# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	ansi_term@0.12.1
	anyhow@1.0.79
	app_dirs2@2.5.5
	async-priority-channel@0.1.0
	async-recursion@1.0.5
	async-trait@0.1.77
	atomic-take@1.1.0
	atty@0.2.14
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.7
	bitflags@1.3.2
	bitflags@2.4.2
	block-buffer@0.10.4
	bstr@1.9.0
	btoi@0.4.3
	bumpalo@3.14.0
	byte-unit@4.0.19
	byteorder@1.5.0
	bytes@1.5.0
	cc@1.0.83
	cesu8@1.1.0
	cfg-if@1.0.0
	chrono-tz-build@0.2.1
	chrono-tz@0.8.5
	chrono@0.4.33
	clap@2.34.0
	clearscreen@2.0.1
	combine@4.6.6
	command-group@2.1.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpufeatures@0.2.12
	crc32fast@1.3.2
	crossbeam-channel@0.5.11
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crypto-common@0.1.6
	curl-sys@0.4.71+curl-8.6.0
	curl@0.4.44
	deranged@0.3.11
	deunicode@1.4.2
	digest@0.10.7
	dirs-sys@0.3.7
	dirs@4.0.0
	dunce@1.0.4
	either@1.9.0
	encoding_rs@0.8.33
	endian-type@0.1.2
	equivalent@1.0.1
	errno@0.3.8
	error-chain@0.12.4
	event-listener@2.5.3
	fastrand@2.0.1
	filetime@0.2.23
	flate2@1.0.28
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fs2@0.4.3
	fsevent-sys@4.1.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.30
	generic-array@0.14.7
	getrandom@0.2.12
	gimli@0.28.1
	gix-actor@0.20.0
	gix-config-value@0.12.5
	gix-config@0.22.0
	gix-date@0.5.1
	gix-features@0.29.0
	gix-fs@0.1.1
	gix-glob@0.7.0
	gix-hash@0.11.4
	gix-lock@5.0.1
	gix-object@0.29.2
	gix-path@0.8.4
	gix-ref@0.29.1
	gix-sec@0.8.4
	gix-tempfile@5.0.3
	gix-trace@0.1.7
	gix-utils@0.1.9
	gix-validate@0.7.7
	globset@0.4.14
	globwalk@0.8.1
	h2@0.3.24
	hashbrown@0.14.3
	headers-core@0.2.0
	headers@0.3.9
	heck@0.3.3
	hermit-abi@0.1.19
	hermit-abi@0.3.4
	hex@0.4.3
	home@0.5.9
	html-escape@0.2.13
	http-body@0.4.6
	http@0.2.11
	httparse@1.8.0
	httpdate@1.0.3
	humansize@2.1.3
	hyper-tls@0.5.0
	hyper@0.14.28
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	idna@0.5.0
	ignore-files@1.3.1
	ignore@0.4.22
	indexmap@2.2.2
	inotify-sys@0.1.5
	inotify@0.9.6
	ipnet@2.9.0
	is-docker@0.2.0
	is-wsl@0.4.0
	itoa@1.0.10
	jni-sys@0.3.0
	jni@0.21.1
	js-sys@0.3.67
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy_static@1.4.0
	libc@0.2.153
	libm@0.2.8
	libredox@0.0.1
	libz-sys@1.1.15
	linux-raw-sys@0.4.13
	lock_api@0.4.11
	log@0.4.20
	md-5@0.10.6
	memchr@2.7.1
	memmap2@0.5.10
	memoffset@0.7.1
	miette-derive@5.10.0
	miette@5.10.0
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.2
	mio@0.8.10
	native-tls@0.2.11
	ndk-context@0.1.1
	nibble_vec@0.1.0
	nix@0.26.4
	nom@7.1.3
	normalize-path@0.2.1
	notify@5.2.0
	num-conv@0.1.0
	num-traits@0.2.17
	num_cpus@1.16.0
	num_threads@0.1.6
	object@0.32.2
	once_cell@1.19.0
	open@4.2.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.2.2+3.2.1
	openssl-sys@0.9.99
	openssl@0.10.63
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	parse-zoneinfo@0.3.0
	pathdiff@0.2.1
	percent-encoding@2.3.1
	pest@2.7.6
	pest_derive@2.7.6
	pest_generator@2.7.6
	pest_meta@2.7.6
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pinot@0.1.5
	pkg-config@0.3.29
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.78
	project-origins@1.2.0
	quick-xml@0.28.2
	quote@1.0.35
	radix_trie@0.2.1
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex-automata@0.4.5
	regex-syntax@0.8.2
	regex@1.10.3
	reqwest@0.11.24
	rustc-demangle@0.1.23
	rustix@0.38.31
	rustls-pemfile@1.0.4
	ryu@1.0.16
	same-file@1.0.6
	schannel@0.1.23
	scopeguard@1.2.0
	security-framework-sys@2.9.1
	security-framework@2.9.2
	serde@1.0.196
	serde_derive@1.0.196
	serde_json@1.0.113
	serde_spanned@0.6.5
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha1_smol@1.0.0
	sha2@0.10.8
	signal-hook-registry@1.4.1
	siphasher@0.3.11
	slab@0.4.9
	slug@0.1.5
	smallvec@1.13.1
	socket2@0.4.10
	socket2@0.5.5
	strsim@0.8.0
	structopt-derive@0.4.18
	structopt@0.3.26
	syn@1.0.109
	syn@2.0.48
	sync_wrapper@0.1.2
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	tempfile@3.9.0
	tera@1.19.1
	termcolor@1.4.1
	terminfo@0.8.0
	textwrap@0.11.0
	thiserror-impl@1.0.56
	thiserror@1.0.56
	time-core@0.1.2
	time-macros@0.2.17
	time@0.3.34
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-macros@2.2.0
	tokio-native-tls@0.3.1
	tokio-stream@0.1.14
	tokio-util@0.7.10
	tokio@1.36.0
	toml@0.7.8
	toml_datetime@0.6.5
	toml_edit@0.19.15
	tower-service@0.3.2
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	typenum@1.17.0
	ucd-trie@0.1.6
	unic-char-property@0.9.0
	unic-char-range@0.9.0
	unic-common@0.9.0
	unic-segment@0.9.0
	unic-ucd-segment@0.9.0
	unic-ucd-version@0.9.0
	unicode-bidi@0.3.15
	unicode-bom@2.0.3
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	url@2.5.0
	utf8-width@0.1.7
	vcpkg@0.2.15
	vec_map@0.8.2
	version_check@0.9.4
	walkdir@2.4.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.90
	wasm-bindgen-futures@0.4.40
	wasm-bindgen-macro-support@0.2.90
	wasm-bindgen-macro@0.2.90
	wasm-bindgen-shared@0.2.90
	wasm-bindgen@0.2.90
	watchexec-events@1.0.0
	watchexec-filterer-globset@1.2.0
	watchexec-filterer-ignore@1.2.1
	watchexec-signals@1.0.0
	watchexec@2.3.2
	web-sys@0.3.67
	which@4.4.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winnow@0.5.37
	winreg@0.50.0
	xdg@2.5.2
	zip@0.6.6
"

inherit cargo

DESCRIPTION="A modernized, complete, self-contained TeX/LaTeX engine."
HOMEPAGE="https://tectonic-typesetting.github.io/"
SRC_URI="
	https://github.com/tectonic-typesetting/tectonic/archive/refs/tags/tectonic@${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-${P}"

LICENSE="MIT"
LICENSE+="
	Apache-2.0 BSD ISC MIT Unicode-DFS-2016 WTFPL-2
	|| ( Artistic-2 CC0-1.0 )
"

SLOT="0"
KEYWORDS="~amd64"

IUSE="doc"

DEPEND="
	dev-libs/icu:=
	dev-libs/openssl:=
	media-gfx/graphite2
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/harfbuzz:=
	media-libs/libpng:=
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	doc? ( app-text/mdbook )
"

QA_FLAGS_IGNORED=".*"

PATCHES=(
	"${FILESDIR}"/tectonic-0.15.0-c++17-icu-fix.patch
)

src_configure() {
	local myfeatures=(
		external-harfbuzz
	)
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
	if use doc; then
		pushd docs > /dev/null || die
		mdbook build || die
		HTML_DOCS="${S}/docs/book"
		popd > /dev/null || die
	fi
}

src_install() {
	cargo_src_install
	einstalldocs
}
