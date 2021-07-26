# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler-0.2.3
adler32-1.2.0
ansi_term-0.11.0
anyhow-1.0.36
arrayref-0.3.6
arrayvec-0.5.2
atk-0.9.0
atk-sys-0.10.0
atty-0.2.14
audiotags-0.2.7182
audiotags-dev-macro-0.1.4
autocfg-1.0.1
base64-0.11.0
bitflags-1.2.1
bk-tree-0.3.0
blake3-0.3.7
bytemuck-1.4.1
byteorder-1.3.4
cairo-rs-0.9.1
cairo-sys-rs-0.10.0
cc-1.0.66
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
color_quant-1.1.0
const_fn-0.4.4
constant_time_eq-0.1.5
crc32fast-1.2.1
crossbeam-channel-0.5.0
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.1
crossbeam-utils-0.8.1
crypto-mac-0.8.0
deflate-0.8.6
digest-0.9.0
directories-next-2.0.0
dirs-sys-next-0.1.1
either-1.6.1
encoding-0.2.33
encoding-index-japanese-1.20141219.5
encoding-index-korean-1.20141219.5
encoding-index-simpchinese-1.20141219.5
encoding-index-singlebyte-1.20141219.5
encoding-index-tradchinese-1.20141219.5
encoding_index_tests-0.1.4
flate2-1.0.19
futures-0.3.8
futures-channel-0.3.8
futures-core-0.3.8
futures-executor-0.3.8
futures-io-0.3.8
futures-macro-0.3.8
futures-sink-0.3.8
futures-task-0.3.8
futures-util-0.3.8
gdk-0.13.2
gdk-pixbuf-0.9.0
gdk-pixbuf-sys-0.10.0
gdk-sys-0.10.0
generic-array-0.14.4
getrandom-0.1.15
gif-0.11.1
gio-0.9.1
gio-sys-0.10.1
glib-0.10.3
glib-macros-0.10.1
glib-sys-0.10.1
gobject-sys-0.10.0
gtk-0.9.2
gtk-sys-0.10.0
hamming-0.1.3
heck-0.3.2
hermit-abi-0.1.17
hex-0.4.2
humansize-1.1.0
id3-0.5.1
image-0.23.12
img_hash-3.1.0
itertools-0.9.0
jpeg-decoder-0.1.20
lazy_static-1.4.0
libc-0.2.81
log-0.4.11
memchr-2.3.4
memoffset-0.6.1
metaflac-0.2.4
miniz_oxide-0.3.7
miniz_oxide-0.4.3
mp4ameta-0.6.1
mp4ameta_proc-0.1.1
num-complex-0.2.4
num-integer-0.1.44
num-iter-0.1.42
num-rational-0.3.2
num-traits-0.2.14
num_cpus-1.13.0
once_cell-1.5.2
open-1.4.0
pango-0.9.1
pango-sys-0.10.0
pin-project-1.0.2
pin-project-internal-1.0.2
pin-utils-0.1.0
pkg-config-0.3.19
png-0.16.8
proc-macro-crate-0.1.5
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro-nested-0.1.6
proc-macro2-1.0.24
quote-1.0.8
rayon-1.5.0
rayon-core-1.9.0
redox_syscall-0.1.57
redox_users-0.3.5
rustdct-0.4.0
rustfft-3.0.1
scoped_threadpool-0.1.9
scopeguard-1.1.0
serde-1.0.118
serde_derive-1.0.118
slab-0.4.2
strength_reduce-0.2.3
strsim-0.8.0
structopt-0.3.21
structopt-derive-0.4.14
strum-0.18.0
strum_macros-0.18.0
subtle-2.4.0
syn-1.0.55
system-deps-1.3.2
textwrap-0.11.0
thiserror-1.0.22
thiserror-impl-1.0.22
tiff-0.6.1
time-0.1.44
toml-0.5.8
transpose-0.1.0
transpose-0.2.0
typenum-1.12.0
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
vec_map-0.8.2
version-compare-0.0.10
version_check-0.9.2
wasi-0.10.0+wasi-snapshot-preview1
wasi-0.9.0+wasi-snapshot-preview1
weezl-0.1.3
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit desktop xdg cargo

DESCRIPTION="App to find duplicates, empty folders and similar images"
HOMEPAGE="https://github.com/qarmin/czkawka"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/qarmin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
"

RESTRICT="mirror test"
LICENSE="CC-BY-4.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X wayland"

DEPEND="
	X? ( x11-libs/gtk+:3[X] )
	wayland? ( x11-libs/gtk+:3[wayland] )
"
RDEPEND="${DEPEND}"

# TODO: X: --cfg 'gdk_backend="x11"' & wayland: --cfg 'gdk_backend="wayland"'

src_install() {
	dobin ./target/release/czkawka_cli
	dobin ./target/release/czkawka_gui

	doicon ./data/icons/com.github.qarmin.czkawka.svg
	doicon ./data/icons/com.github.qarmin.czkawka-symbolic.svg

	domenu ./pkgs/com.github.qarmin.czkawka.desktop
}
