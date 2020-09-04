# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
XANMOD_VERSION="1"
ETYPE="sources"
inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="A general-purpose kernel with custom settings and new features"
HOMEPAGE="https://xanmod.org"
LICENSE+=" CDDL"
KEYWORDS="~amd64"
CACHY_URI="https://raw.githubusercontent.com/hamadmarri/cachy-sched/master/patches/cachy/cachy-5.8.patch"
IUSE="cachy"
SRC_URI="${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz https://github.com/xanmod/linux/releases/download/${OKV}-xanmod${XANMOD_VERSION}/patch-${OKV}-xanmod${XANMOD_VERSION}.xz
( ${CACHY_URI} )
"

UNIPATCH_LIST_DEFAULT=""
UNIPATCH_LIST="${DISTDIR}/patch-${OKV}-xanmod${XANMOD_VERSION}.xz"

src_prepare() {

	if use cachy; then
		eapply "${DISTDIR}/cachy-5.8.patch"
	fi

	kernel-2-src-prepare-overlay_src_prepare

	rm "${S}"/.config || die

}
