# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual to depend on any Distribution Kernel"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	|| (
		~sys-kernel/gentoo-kernel-${PV}
		~sys-kernel/gentoo-kernel-bin-${PV}
		~sys-kernel/vanilla-kernel-${PV}
		~sys-kernel/xanmod-kernel-${PV}
		~sys-kernel/xanmod-kernel-bin-${PV}
		~sys-kernel/xanmod-rt-kernel-${PV}
	)
"
