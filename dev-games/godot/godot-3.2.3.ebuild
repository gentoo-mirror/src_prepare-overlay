# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit python-any-r1 scons-utils flag-o-matic llvm desktop xdg

DESCRIPTION="Multi-platform 2D and 3D game engine"
HOMEPAGE="http://godotengine.org"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/godotengine/${PN}.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://github.com/godotengine/${PN}/archive/${PV}-stable.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}-stable"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE="
	+udev
	debug
	llvm
	lto
	pulseaudio
"

DEPEND="
	>=app-arch/bzip2-1.0.6-r6
	>=app-arch/lz4-0_p120
	>=app-arch/xz-utils-5.0.8
	>=app-arch/zstd-1.4.4
	>=dev-libs/json-c-0.11-r1
	>=media-libs/alsa-lib-1.0.28
	>=media-libs/flac-1.3.1-r1
	>=media-libs/freetype-2.5.3-r1:2
	>=media-libs/libogg-1.3.1
	>=media-libs/libpng-1.6.16:0=
	>=media-libs/libsndfile-1.0.25-r1
	>=media-libs/libvorbis-1.3.4
	>=media-libs/mesa-10.2.8[gles2]
	>=net-libs/libasyncns-0.8-r3
	>=sys-apps/attr-2.4.47-r1
	>=sys-apps/tcp-wrappers-7.6.22-r1
	>=sys-apps/util-linux-2.25.2-r2
	>=sys-libs/gdbm-1.11
	>=sys-libs/glibc-2.20-r2
	>=sys-libs/libcap-2.22-r2
	>=sys-libs/zlib-1.2.8-r1
	>=x11-libs/libX11-1.6.2
	>=x11-libs/libXcursor-1.1.14
	>=x11-libs/libXinerama-1.1.3
	dev-libs/libpcre2[pcre32]
	media-libs/libtheora
	media-libs/libvpx
	media-libs/libwebp
	media-libs/opus
	media-libs/opusfile
	net-libs/enet:=
	net-libs/mbedtls
	net-libs/miniupnpc
	virtual/glu
	llvm? (
		>=sys-devel/llvm-3.6.0:=
	)
	!llvm? (
		>=sys-devel/gcc-4.6.4:*[cxx]
	)
	pulseaudio? (
		>=media-sound/pulseaudio-5.0-r7
	)
	udev? (
		virtual/udev
	)
"
RDEPEND="
	${DEPEND}
"

pkg_setup() {
	llvm_pkg_setup
	python-any-r1_pkg_setup
}

src_configure() {
	if use llvm && ! tc-is-clang; then
		einfo "Enforcing the use of clang due to USE=llvm ..."
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
	fi

	strip-unsupported-flags

	myesconsargs=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		builtin_enet=no
		builtin_freetype=no
		builtin_libogg=no
		builtin_libpng=no
		builtin_libtheora=no
		builtin_libvorbis=no
		builtin_libvpx=no
		builtin_libwebp=no
		builtin_mbedtls=no
		builtin_miniupnpc=no
		builtin_opus=no
		builtin_pcre2=no
		builtin_zlib=no
		builtin_zstd=no
		module_enet_enabled=yes
		module_freetype_enabled=yes
		module_mbedtls_enabled=yes
		module_opus_enabled=yes
		module_theora_enabled=yes
		module_vorbis_enabled=yes
		module_webp_enabled=yes
		platform=x11
		progress=yes
		pulseaudio=$(usex pulseaudio)
		target=$(usex debug debug release_debug)
		tools=yes
		udev=$(usex udev)
		use_lld=$(usex llvm)
		use_llvm=$(usex llvm)
		use_lto=$(usex lto)
		verbose=yes
	)
}

src_compile() {
	escons "${myesconsargs[@]}"
}

src_install() {
	einstalldocs

	newicon icon.svg "${PN}.svg"

	if use llvm
	then
		dobin "bin/${PN}.x11.opt.tools.64.llvm"
		dosym "${EPREFIX}/usr/bin/${PN}.x11.opt.tools.64.llvm" "${EPREFIX}/usr/bin/${PN}"
	else
		dobin "bin/${PN}.x11.opt.tools.64"
		dosym "${EPREFIX}/usr/bin/${PN}.x11.opt.tools.64" "${EPREFIX}/usr/bin/${PN}"
	fi

	make_desktop_entry godot Godot
}
