# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit toolchain-funcs python-r1

DESCRIPTION="A compositor for X, branch with dual kawase blur"
HOMEPAGE="https://github.com/tryone144/compton"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tryone144/compton"
else
	SRC_URI="https://github.com/tryone144/compton/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE="dbus +drm opengl +pcre xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	dev-libs/libconfig
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender
	dbus? ( sys-apps/dbus )
	opengl? ( virtual/opengl )
	pcre? ( dev-libs/libpcre:3 )
	xinerama? ( x11-libs/libXinerama )
"
RDEPEND="
	${COMMON_DEPEND}
	!x11-misc/compton
	x11-apps/xprop
	x11-apps/xwininfo
"
DEPEND="
	${COMMON_DEPEND}
	app-text/asciidoc
	virtual/pkgconfig
	x11-base/xorg-proto
	drm? ( x11-libs/libdrm )
"

if [[ ${PV} != *9999* ]]; then
	S="${WORKDIR}/compton-${PV}"
fi

nobuildit() {
	use $1 || echo yes
}

pkg_setup() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		tc-export CC
	fi
}

src_compile() {
	emake docs

	NO_DBUS=$(nobuildit dbus) \
		   NO_XINERAMA=$(nobuildit xinerama) \
		   NO_VSYNC_DRM=$(nobuildit drm) \
		   NO_VSYNC_OPENGL=$(nobuildit opengl) \
		   NO_REGEX_PCRE=$(nobuildit pcre) \
		   emake compton
}

src_install() {
	NO_DBUS=$(nobuildit dbus) \
		   NO_VSYNC_DRM=$(nobuildit drm) \
		   NO_VSYNC_OPENGL=$(nobuildit opengl) \
		   NO_REGEX_PCRE=$(nobuildit pcre) \
		   default
	docinto examples
	dodoc compton.sample.conf dbus-examples/*
	python_foreach_impl python_newscript bin/compton-convgen.py compton-convgen
}
