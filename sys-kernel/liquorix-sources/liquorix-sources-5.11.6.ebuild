# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
LQX_VERSION="1"

inherit kernel-2-src-prepare-overlay
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
HOMEPAGE="https://github.com/zen-kernel"
IUSE=""

DESCRIPTION="Liquorix sources including the Gentoo patchsets for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

LQX_URI="https://github.com/zen-kernel/zen-kernel/releases/download/v${PV}-lqx${LQX_VERSION}/v${PV}-lqx${LQX_VERSION}.patch.xz"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${LQX_URI}"

UNIPATCH_LIST="${DISTDIR}/v${PV}-lqx${LQX_VERSION}.patch.xz"
UNIPATCH_STRICTORDER="yes"

K_EXTRAEINFO="For more info on liquorix-sources, and for how to report problems, see: \
${HOMEPAGE}, also go to #zen-sources on freenode"

pkg_postrm() {
	kernel-2_pkg_postrm
}
