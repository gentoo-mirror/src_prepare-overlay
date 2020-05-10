# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="15"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit kernel-2-src-prepare-overlay
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
HOMEPAGE="http://ck.kolivas.org/"
IUSE="experimental"

DESCRIPTION="Con Kolivas sources including the Gentoo patchsets for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
CK_URI="http://ck.kolivas.org/patches/${KV_MAJOR}.0/${KV_MAJOR}.${KV_MINOR}/${KV_MAJOR}.${KV_MINOR}-ck1/patch-${KV_MAJOR}.${KV_MINOR}-ck1.xz"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CK_URI}"

UNIPATCH_LIST="${DISTDIR}/patch-${KV_MAJOR}.${KV_MINOR}-ck1.xz"
UNIPATCH_STRICTORDER="yes"
