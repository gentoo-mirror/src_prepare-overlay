# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
ETYPE="sources"
inherit kernel-2-src-prepare-overlay
detect_version

DESCRIPTION="A general-purpose kernel with custom settings and new features"
HOMEPAGE="https://xanmod.org"
LICENSE+=" CDDL"
KEYWORDS="~amd64"
XANMOD_VERSION="1"
IUSE="cacule"
XANMOD_URI="https://github.com/xanmod/linux/releases/download/"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	cacule? ( ${XANMOD_URI}/${OKV}-xanmod${XANMOD_VERSION}-cacule/patch-${OKV}-xanmod${XANMOD_VERSION}-cacule.xz  )
	!cacule? ( ${XANMOD_URI}/${OKV}-xanmod${XANMOD_VERSION}/patch-${OKV}-xanmod${XANMOD_VERSION}.xz  )
	${GENPATCHES_URI}
"

src_unpack() {
UNIPATCH_LIST_DEFAULT=""
	if use cacule; then
		UNIPATCH_LIST="${DISTDIR}/patch-${OKV}-xanmod${XANMOD_VERSION}-cacule.xz "
	else
		UNIPATCH_LIST="${DISTDIR}/patch-${OKV}-xanmod${XANMOD_VERSION}.xz "
	fi
	kernel-2-src-prepare-overlay_src_unpack
}

src_prepare() {

	if use cacule; then
		eapply "${FILESDIR}/localversion.patch"
		eapply "${FILESDIR}/no_reset_on_migration.patch"
	fi

	kernel-2-src-prepare-overlay_src_prepare

	rm "${S}"/.config || die

}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-sources with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
