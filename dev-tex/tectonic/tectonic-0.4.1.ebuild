# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.13.0
adler-0.2.3
adler32-1.2.0
aho-corasick-0.7.13
android_log-sys-0.1.2
ansi_term-0.11.0
app_dirs2-2.3.0
ascii-0.9.3
atty-0.2.14
autocfg-0.1.7
autocfg-1.0.1
backtrace-0.3.50
base64-0.10.1
bitflags-1.2.1
block-buffer-0.7.3
block-buffer-0.9.0
block-padding-0.1.5
byte-tools-0.3.1
byte-unit-4.0.9
byteorder-1.3.4
bytes-0.4.12
cbindgen-0.16.0
cc-1.0.66
cesu8-1.1.0
cfg-if-0.1.10
cfg-if-1.0.0
clap-2.33.3
cloudabi-0.0.3
combine-3.8.1
cookie-0.12.0
cookie_store-0.7.0
core-foundation-0.7.0
core-foundation-sys-0.7.0
cpuid-bool-0.1.2
crc32fast-1.2.0
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
derivative-2.1.1
digest-0.8.1
digest-0.9.0
dtoa-0.4.6
either-1.6.0
encoding_rs-0.8.24
error-chain-0.12.4
failure-0.1.8
failure_derive-0.1.8
fake-simd-0.1.2
filetime-0.2.13
flate2-1.0.14
fnv-1.0.7
foreign-types-0.3.2
foreign-types-shared-0.1.1
fs2-0.4.3
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.30
futures-cpupool-0.1.8
generic-array-0.12.3
generic-array-0.14.4
getrandom-0.1.14
gimli-0.22.0
h2-0.1.26
hashbrown-0.9.0
headers-0.2.3
headers-core-0.1.1
heck-0.3.1
hermit-abi-0.1.15
http-0.1.21
http-body-0.1.0
httparse-1.3.4
hyper-0.12.35
hyper-tls-0.3.2
idna-0.1.5
idna-0.2.0
indexmap-1.6.0
iovec-0.1.4
itoa-0.4.6
jni-0.14.0
jni-sys-0.3.0
kernel32-sys-0.2.2
lazy_static-1.4.0
libc-0.2.81
libz-sys-1.1.2
lock_api-0.3.4
log-0.4.11
matches-0.1.8
maybe-uninit-2.0.0
md-5-0.9.1
memchr-2.3.3
memoffset-0.5.5
mime-0.3.16
mime_guess-2.0.3
miniz_oxide-0.3.7
miniz_oxide-0.4.1
mio-0.6.22
mio-uds-0.6.8
miow-0.2.1
native-tls-0.2.4
ndk-0.1.0
ndk-glue-0.1.0
ndk-sys-0.1.0
net2-0.2.34
num_cpus-1.13.0
num_enum-0.4.3
num_enum_derive-0.4.3
object-0.20.0
opaque-debug-0.2.3
opaque-debug-0.3.0
openssl-0.10.30
openssl-probe-0.1.2
openssl-sys-0.9.58
parking_lot-0.9.0
parking_lot_core-0.6.2
percent-encoding-1.0.1
percent-encoding-2.1.0
pkg-config-0.3.19
ppv-lite86-0.2.9
proc-macro-crate-0.1.5
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.20
publicsuffix-1.5.4
quote-1.0.7
rand-0.6.5
rand-0.7.3
rand_chacha-0.1.1
rand_chacha-0.2.2
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rdrand-0.4.0
redox_syscall-0.1.57
regex-1.4.2
regex-syntax-0.6.21
remove_dir_all-0.5.3
reqwest-0.9.24
rustc-demangle-0.1.16
rustc_version-0.2.3
ryu-1.0.5
same-file-1.0.6
schannel-0.1.19
scopeguard-1.1.0
security-framework-0.4.4
security-framework-sys-0.4.3
semver-0.9.0
semver-parser-0.7.0
serde-1.0.118
serde_derive-1.0.118
serde_json-1.0.57
serde_urlencoded-0.5.5
sha-1-0.8.2
sha2-0.9.2
slab-0.4.2
smallvec-0.6.13
string-0.2.1
strsim-0.8.0
structopt-0.3.21
structopt-derive-0.4.14
syn-1.0.40
synstructure-0.12.4
tempfile-3.1.0
termcolor-1.1.2
textwrap-0.11.0
thiserror-1.0.20
thiserror-impl-1.0.20
thread_local-1.0.1
time-0.1.44
tinyvec-0.3.4
tokio-0.1.22
tokio-buf-0.1.1
tokio-codec-0.1.2
tokio-current-thread-0.1.7
tokio-executor-0.1.10
tokio-fs-0.1.7
tokio-io-0.1.13
tokio-reactor-0.1.12
tokio-sync-0.1.8
tokio-tcp-0.1.4
tokio-threadpool-0.1.18
tokio-timer-0.2.13
tokio-udp-0.1.6
tokio-uds-0.2.7
toml-0.5.8
try-lock-0.2.3
try_from-0.3.2
typenum-1.12.0
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.13
unicode-segmentation-1.6.0
unicode-width-0.1.8
unicode-xid-0.2.1
unreachable-1.0.0
url-1.7.2
url-2.1.1
utf8-width-0.1.4
uuid-0.7.4
vcpkg-0.2.11
vec_map-0.8.2
version_check-0.9.2
void-1.0.2
walkdir-2.3.1
want-0.2.0
wasi-0.10.0+wasi-snapshot-preview1
wasi-0.9.0+wasi-snapshot-preview1
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
xdg-2.2.0
zip-0.5.9
"

inherit cargo flag-o-matic

DESCRIPTION="A modernized, complete, self-contained TeX/LaTeX engine."
HOMEPAGE="https://tectonic-typesetting.github.io/"
SRC_URI="
	https://github.com/tectonic-typesetting/${PN}/archive/refs/tags/${PN}@${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
S="${WORKDIR}/${PN}-${PN}-${PV}"
RESTRICT="mirror"

LICENSE="0BSD all-rights-reserved Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0 ISC MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="doc"

DEPEND="
	dev-libs/icu
	dev-libs/openssl
	media-libs/fontconfig
	media-gfx/graphite2
	media-libs/harfbuzz
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

# TODO:
# Add mdbook and then enable documentation

src_configure() {
	# Test fails with -ftree-slp-vectorize, therefore disable
	append-flags -fno-tree-slp-vectorize
	# Linker fails with lto enabled
	filter-flags -flto*
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
	#if use doc; then
	#   pushd docs
	#	mdbook build
	#	HTML_DOCS="${S}/docs"
	#   popd
	#fi
}

src_install() {
	cargo_src_install
	#einstalldocs
}

# There is feature called serialization that is enabled by default,
# too minor to bother making a useflag for it.
