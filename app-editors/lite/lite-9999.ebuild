# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="A lightweight text editor written in Lua"
HOMEPAGE="https://github.com/rxi/lite"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rxi/${PN}.git"
else
	SRC_URI="https://github.com/rxi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

BDEPEND="
	media-gfx/imagemagick
"
DEPEND="
	media-libs/libsdl2
	net-libs/libasyncns
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcursor
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/libxcb
"
RDEPEND="
	${DEPEND}
"

src_compile() {
	bash build.sh release || die

	cp icon.ico lite.ico || die
	# This converts to 4 png files
	convert icon.ico "${PN}.png" || die
	mv lite-0.png lite-64.png || die
	mv lite-1.png lite-48.png || die
	mv lite-2.png lite-32.png || die
	mv lite-3.png lite-16.png || die
}

src_install() {
	default

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
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
