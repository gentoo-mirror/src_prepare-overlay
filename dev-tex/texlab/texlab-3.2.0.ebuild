# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
ahash-0.4.7
aho-corasick-0.7.18
ansi_term-0.11.0
anyhow-1.0.40
arrayref-0.3.6
arrayvec-0.5.2
ascii-canvas-2.0.0
atty-0.2.14
autocfg-0.1.7
autocfg-1.0.1
base64-0.13.0
beef-0.5.0
bibutils-sys-0.1.1
bit-set-0.5.2
bit-vec-0.6.3
bitflags-1.2.1
blake2b_simd-0.5.11
byteorder-1.4.3
bytes-1.0.1
cancellation-0.1.0
cc-1.0.67
cesu8-1.1.0
cfg-if-0.1.10
cfg-if-1.0.0
chashmap-2.2.2
clap-2.33.3
cloudabi-0.0.3
combine-4.5.2
console-0.14.1
constant_time_eq-0.1.5
convert_case-0.4.0
crossbeam-0.7.3
crossbeam-channel-0.4.4
crossbeam-channel-0.5.1
crossbeam-deque-0.7.3
crossbeam-deque-0.8.0
crossbeam-epoch-0.8.2
crossbeam-epoch-0.9.3
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
crossbeam-utils-0.8.5
crunchy-0.2.2
cstree-0.5.0
derive-new-0.5.9
derive_more-0.99.14
diff-0.1.12
dirs-1.0.5
dtoa-0.4.7
either-1.6.1
ena-0.14.0
encode_unicode-0.3.6
encoding_rs-0.8.28
encoding_rs_io-0.1.7
fern-0.6.0
filetime-0.2.14
fixedbitset-0.1.9
fixedbitset-0.2.0
fnv-1.0.7
form_urlencoded-1.0.1
fsevent-sys-4.0.0
fuchsia-cprng-0.1.1
futf-0.1.4
fuzzy-matcher-0.3.7
fxhash-0.2.1
generational-arena-0.2.8
getrandom-0.1.16
getrandom-0.2.2
hashbrown-0.9.1
heck-0.3.2
hermit-abi-0.1.18
html2md-0.2.11
html5ever-0.24.1
html5ever-0.25.1
idna-0.2.2
indexmap-1.6.2
indoc-1.0.3
inotify-0.9.2
inotify-sys-0.1.5
insta-1.7.1
instant-0.1.9
itertools-0.10.0
itertools-0.8.2
itoa-0.4.7
jni-0.19.0
jni-sys-0.3.0
lalrpop-0.19.5
lalrpop-util-0.19.5
lasso-0.5.0
lazy_static-1.4.0
libc-0.2.91
linked-hash-map-0.5.4
lock_api-0.3.4
lock_api-0.4.2
log-0.4.14
logos-0.12.0
logos-derive-0.12.0
lsp-server-0.5.1
lsp-types-0.89.1
mac-0.1.1
markup5ever-0.10.1
markup5ever-0.9.0
markup5ever_rcdom-0.1.0
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.4.0
memoffset-0.5.6
memoffset-0.6.3
mio-0.7.11
miow-0.3.7
multimap-0.8.3
new_debug_unreachable-1.0.4
nom-4.2.3
nom-5.1.2
notify-5.0.0-pre.9
ntapi-0.3.6
num_cpus-1.13.0
once_cell-1.7.2
ordermap-0.3.5
owning_ref-0.3.3
parking_lot-0.11.1
parking_lot-0.4.8
parking_lot-0.9.0
parking_lot_core-0.2.14
parking_lot_core-0.6.2
parking_lot_core-0.8.3
percent-encoding-2.1.0
petgraph-0.4.13
petgraph-0.5.1
phf-0.7.24
phf-0.8.0
phf_codegen-0.7.24
phf_codegen-0.8.0
phf_generator-0.7.24
phf_generator-0.8.0
phf_macros-0.8.0
phf_shared-0.7.24
phf_shared-0.8.0
pico-args-0.4.1
ppv-lite86-0.2.10
precomputed-hash-0.1.1
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro2-0.4.30
proc-macro2-1.0.24
quote-0.6.13
quote-1.0.9
rand-0.4.6
rand-0.6.5
rand-0.7.3
rand-0.8.3
rand_chacha-0.1.1
rand_chacha-0.2.2
rand_chacha-0.3.0
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_core-0.6.2
rand_hc-0.1.0
rand_hc-0.2.0
rand_hc-0.3.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_pcg-0.2.1
rand_xorshift-0.1.1
rayon-1.5.1
rayon-core-1.9.1
rdrand-0.4.0
redox_syscall-0.1.57
redox_syscall-0.2.5
redox_users-0.3.5
regex-1.5.4
regex-syntax-0.6.25
remove_dir_all-0.5.3
roxmltree-0.7.3
rust-argon2-0.8.3
rustc-hash-1.1.0
rustc_version-0.2.3
ryu-1.0.5
salsa-0.13.2
salsa-macros-0.13.2
same-file-1.0.6
scopeguard-1.1.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.126
serde_derive-1.0.126
serde_json-1.0.64
serde_repr-0.1.7
serde_yaml-0.8.17
similar-1.3.0
siphasher-0.2.3
siphasher-0.3.5
smallvec-0.6.14
smallvec-1.6.1
smol_str-0.1.17
stable_deref_trait-1.2.0
string_cache-0.7.5
string_cache-0.8.1
string_cache_codegen-0.4.4
string_cache_codegen-0.5.1
string_cache_shared-0.3.0
stringreader-0.1.1
strsim-0.8.0
structopt-0.3.21
structopt-derive-0.4.14
strum-0.15.0
strum_macros-0.15.0
syn-0.15.44
syn-1.0.65
tempfile-3.2.0
tendril-0.4.2
term-0.5.2
terminal_size-0.1.16
text-size-1.1.0
textwrap-0.11.0
thiserror-1.0.24
thiserror-impl-1.0.24
thread_local-1.1.3
threadpool-1.8.1
time-0.1.43
tiny-keccak-2.0.2
tinyvec-1.1.1
tinyvec_macros-0.1.0
titlecase-1.1.0
triomphe-0.1.2
typed-builder-0.9.0
ucd-trie-0.1.3
unic-char-property-0.9.0
unic-char-range-0.9.0
unic-common-0.9.0
unic-segment-0.9.0
unic-ucd-segment-0.9.0
unic-ucd-version-0.9.0
unicode-bidi-0.3.4
unicode-normalization-0.1.17
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.1.0
unicode-xid-0.2.1
unindent-0.1.7
url-2.2.2
utf-8-0.7.6
utf8-ranges-1.0.4
uuid-0.8.2
v_escape-0.7.4
v_escape_derive-0.5.6
v_htmlescape-0.4.5
vec_map-0.8.2
version_check-0.1.5
version_check-0.9.3
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
wasi-0.9.0+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
xml5ever-0.16.1
xmlparser-0.10.0
yaml-rust-0.4.5
"

CARGO_GIT=(
	"https://github.com/zotero/citeproc-rs.git 4e8987e4a1679358 68c7a7c16088b5d7751641ab37299ad064cdb221"
)

inherit cargo-git flag-o-matic

DESCRIPTION="An implementation of the Language Server Protocol for LaTeX"
HOMEPAGE="https://texlab.netlify.app/"
SRC_URI="
	https://github.com/latex-lsp/texlab/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
RESTRICT="mirror"

LICENSE="Apache-2.0 Artistic-2 BSD-2 BSD CC0-1.0 GPL-3 GPL-3+ ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md texlab.pdf )

src_configure() {
	# Very fragile. TODO is to minimize the set of flags disabled
	replace-flags -O3 -O2
	replace-flags -Ofast -O2
	filter-flags -flto*

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
	doman texlab.1
}

pkg_postinst() {
	elog "Texlab requires a TeX distribution to function"
	elog "Either virtual/latex-base or dev-tex/tectonic will suffice"
	elog "You can then edit the config to use your chosen TeX distribution"
}
