# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUAJIT_V="LuaJIT-2.1.0-beta3"
LPEG_V="lpeg-0.10.2"

# What else should we do?
BUNDLE_SRC="
	http://luajit.org/download/${LUAJIT_V}.tar.gz -> ${PN}-${LUAJIT_V}.tar.gz
	http://nordman.org/mirror/lpeg/${LPEG_V}.tar.gz -> ${PN}-${LPEG_V}.tar.gz
"

inherit desktop xdg

DESCRIPTION="Lightweight editor with keyboard-centric minimalistic interface"
HOMEPAGE="https://howl.io"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/howl-editor/${PN}.git"
else
	SRC_URI="https://github.com/howl-editor/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SRC_URI="
	${BUNDLE_SRC}
	${SRC_URI}
"

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND="
	x11-libs/gtk+:3[X]
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	default

	# Instead of hooking into src_fetch it's easier to unpack
	# other sources in src_prepare for the git version.
	if [[ "${PV}" == *9999* ]]
	then
		# This is a little bit too much back-and-forth
		unpack "${PN}-${LUAJIT_V}.tar.gz"
		mv "${S}/${LUAJIT_V}" "${WORKDIR}"
		unpack "${PN}-${LPEG_V}.tar.gz"
		mv "${S}/${LPEG_V}" "${WORKDIR}"
	fi

	# Move "bundles" into a dir known by 'howl'.
	mv "${WORKDIR}/${LUAJIT_V}" src/deps/ || die
	mv "${WORKDIR}/${LPEG_V}" src/deps/ || die
}

src_compile() {
	if pushd src
	then
		# By default this fetches deps with curl/wget
		# but if we have "bundle" sources it shouldn't.
		# If you get sandbox viotlation here that means
		# the "bundles" fetched were probably incorrect.
		emake
		popd
	else
		die
	fi
}

src_install() {
	default

	if pushd src
	then
		emake PREFIX="${D}"/usr install
		popd
	else
		die
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
