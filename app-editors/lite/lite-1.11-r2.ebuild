# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop toolchain-funcs xdg

DESCRIPTION="A lightweight text editor written in Lua"
HOMEPAGE="https://github.com/rxi/lite"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rxi/lite.git"
else
	SRC_URI="https://github.com/rxi/lite/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND="
	media-gfx/imagemagick
"
DEPEND="
	media-libs/libsdl2
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	default

	# 1. no automagic ccache please
	# 2. respect user compiler
	# 3. respect user CFLAGS
	# 4. respect user LDFLAGS
	sed -i \
		-e '/if command -v ccache/,/fi/d' \
		-e 's/compiler="gcc"/compiler="${CC}"/' \
		-e '/^cflags=/acflags+=" ${CFLAGS}"' \
		-e '/^lflags=/alflags+=" ${LDFLAGS}"' \
		build.sh || die
}

src_compile() {
	tc-export_build_env CC
	bash -x build.sh release || die

	cp icon.ico lite.ico || die
	# This converts to 4 png files
	convert icon.ico "${PN}.png" || die
	mv lite-0.png lite-64.png || die
	mv lite-1.png lite-48.png || die
	mv lite-2.png lite-32.png || die
	mv lite-3.png lite-16.png || die
}

src_install() {
	insinto "/opt/${PN}"
	doins -r data
	exeinto "/opt/${PN}"
	doexe lite
	dosym "../../opt/${PN}/${PN}" "/usr/bin/${PN}"

	local res
	for res in 16 32 48 64
	do
		# We do this 'mv' to install to
		# /usr/share/icons/hicolor/16x16/apps/lite.png
		# instead of
		# /usr/share/icons/hicolor/16x16/apps/lite-16.png
		mv "${PN}-${res}.png" "${PN}.png" || die
		doicon -s "${res}" "${PN}.png"
	done
	doicon "${PN}.ico"
	make_desktop_entry "${PN}" "${PN^}" "${PN}" "Development;IDE"

	einstalldocs
}
