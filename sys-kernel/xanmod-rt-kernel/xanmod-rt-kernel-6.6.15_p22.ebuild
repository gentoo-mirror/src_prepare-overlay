# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KERNEL_IUSE_GENERIC_UKI=1
KERNEL_IUSE_MODULES_SIGN=1

inherit kernel-build

MY_P=linux-${PV%.*}
MY_PV="${PV%_p*}"

GENPATCHES_P=genpatches-${MY_PV%.*}-$(( ${MY_PV##*.} + 3 ))
GENTOO_CONFIG_VER=g11

RT_PATCHSET="${PV/*_p}"

DESCRIPTION="Linux kernel built with XanMod and Gentoo patches"
HOMEPAGE="https://www.kernel.org/ https://xanmod.org/"
SRC_URI="
	https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	mirror://sourceforge/xanmod/patch-${MY_PV}-rt${RT_PATCHSET}-xanmod1.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.base.tar.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.extras.tar.xz
	https://github.com/mgorny/gentoo-kernel-config/archive/${GENTOO_CONFIG_VER}.tar.gz
		-> gentoo-kernel-config-${GENTOO_CONFIG_VER}.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
SLOT="${MY_PV}"
KEYWORDS="-* ~amd64"
IUSE="debug"

RDEPEND="
	!sys-kernel/xanmod-kernel-bin:${SLOT}
"
BDEPEND="
	debug? ( dev-util/pahole )
"
PDEPEND="
	>=virtual/dist-kernel-${MY_PV}
"

QA_FLAGS_IGNORED="
	usr/src/linux-.*/scripts/gcc-plugins/.*.so
	usr/src/linux-.*/vmlinux
"

src_prepare() {
	# Remove linux-stable patches (see 0000_README)
	find "${WORKDIR}" -maxdepth 1 -name "1[0-4][0-9][0-9]*.patch" -exec rm {} + || die

	local PATCHES=(
		# meh, genpatches have no directory
		"${WORKDIR}"/patch-${MY_PV}-rt${RT_PATCHSET}-xanmod1
		"${WORKDIR}"/*.patch
	)
	default

	# prepare the default config
	case ${ARCH} in
		amd64)
			cp "${S}/CONFIGS/xanmod/gcc/config_x86-64-v1" .config || die
			;;
		*)
			die "Unsupported arch ${ARCH}"
			;;
	esac

	rm "${S}"/localversion* || die
	local myversion="-rt${RT_PATCHSET}-xanmod1-dist"
	echo "CONFIG_LOCALVERSION=\"${myversion}\"" > "${T}"/version.config || die
	local dist_conf_path="${WORKDIR}/gentoo-kernel-config-${GENTOO_CONFIG_VER}"

	local merge_configs=(
		"${T}"/version.config
		"${dist_conf_path}"/base.config
	)
	use debug || merge_configs+=(
		"${dist_conf_path}"/no-debug.config
		"${FILESDIR}"/no-debug-extra.config
	)

	kernel-build_merge_configs "${merge_configs[@]}"
}

# lazy workaround
kernel-install_pkg_preinst() {
	debug-print-function ${FUNCNAME} "${@}"

	local dir_ver=${PV}${KV_LOCALVERSION}
	local kernel_dir=${ED}/usr/src/linux-${dir_ver}
	local relfile=${kernel_dir}/include/config/kernel.release
	[[ ! -d ${kernel_dir} ]] &&
		die "Kernel directory ${kernel_dir} not installed!"
	[[ ! -f ${relfile} ]] &&
		die "Release file ${relfile} not installed!"
	local release
	release="$(<"${relfile}")" || die

	if [[ -L ${EROOT}/lib && ${EROOT}/lib -ef ${EROOT}/usr/lib ]]; then
		# Adjust symlinks for merged-usr.
		rm "${ED}/lib/modules/${release}"/{build,source} || die
		dosym "../../../src/linux-${dir_ver}" "/usr/lib/modules/${release}/build"
		dosym "../../../src/linux-${dir_ver}" "/usr/lib/modules/${release}/source"
	fi
}
