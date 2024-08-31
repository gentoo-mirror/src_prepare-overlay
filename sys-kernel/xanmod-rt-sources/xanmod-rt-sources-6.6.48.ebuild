# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

XANMOD_VERSION=1
RT_PATCHSET="40"

K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="55"

ETYPE="sources"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Full XanMod sources with CONFIG_PREEMPT_RT and including the Gentoo patchset"
HOMEPAGE="https://xanmod.org"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	https://downloads.sourceforge.net/xanmod/patch-${OKV}-rt${RT_PATCHSET}-xanmod${XANMOD_VERSION}.xz
	${GENPATCHES_URI}
"
LICENSE+=" CDDL"

KEYWORDS="~amd64"

src_unpack() {
	UNIPATCH_STRICTORDER=1
	UNIPATCH_LIST_DEFAULT="${DISTDIR}/patch-${OKV}-rt${RT_PATCHSET}-xanmod${XANMOD_VERSION}.xz "
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1*_linux-${KV_MAJOR}.${KV_MINOR}.*.patch"
	kernel-2_src_unpack
}

src_prepare() {
	default

	# 627796
	sed \
		"s/default PREEMPT_NONE/default PREEMPT_RT/g" \
		-i "${S}/kernel/Kconfig.preempt" || die "sed failed"
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-sources with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
