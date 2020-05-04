# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="2"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"
HOMEPAGE="https://xanmod.org/"
IUSE=""

DESCRIPTION="XanMod sources including the Gentoo patchsets for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

XANMOD_URI="https://github.com/xanmod/linux/releases/download/${PV}-xanmod1/patch-${PV}-xanmod1.xz"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${XANMOD_URI}"

UNIPATCH_LIST="${DISTDIR}/patch-${PV}-xanmod1.xz"
UNIPATCH_STRICTORDER="yes"
