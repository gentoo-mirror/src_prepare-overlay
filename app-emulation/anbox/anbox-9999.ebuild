# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info systemd cmake

DESCRIPTION="Container-based approach to boot a full Android system"
HOMEPAGE="https://anbox.io/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/anbox/anbox.git"
	EGIT_SUBMODULES=( 'external/cpu_features' )
	EGIT_COMMIT_DATE="${PV}"
else
	COMMIT="6c10125a7f13908d2cbe56d2d9ab09872755f265" # 29.11.2020
	EXTCOMMIT="b9593c8b395318bb2bc42683a94f962564cc4664"
	SRC_URI="
		https://github.com/anbox/anbox/archive/"${COMMIT}".tar.gz -> "${P}".tar.gz
		https://github.com/google/cpu_features/archive/"${EXTCOMMIT}".tar.gz -> cpu_features-"${EXTCOMMIT}".tar.gz
	"
	S=""${WORKDIR}"/"${PN}"-"${COMMIT}""
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="X wayland systemd"

DEPEND="
	>=app-emulation/lxc-3.0.0
	dev-cpp/properties-cpp
	dev-cpp/sdbus-cpp
	dev-cpp/gtest
	dev-libs/boost[threads]
	dev-libs/expat
	dev-libs/protobuf
	media-libs/libsdl2
	media-libs/glm
	media-libs/mesa[egl,gles2]
	media-libs/sdl2-image
	sys-apps/dbus
	sys-fs/fuse:3
	sys-libs/libcap
	|| ( sys-apps/systemd sys-auth/elogind )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

CONFIG_CHECK="
	~ANDROID_BINDERFS
	~ANDROID_BINDER_IPC
	~ASHMEM
	~BLK_DEV_LOOP
	~FUSE_FS
	~SQUASHFS
	~SQUASHFS_XZ
	~SQUASHFS_XATTR
	~TMPFS_XATTR
"

PATCHES=( ""${FILESDIR}"/no_bundled_sdbus.patch" )

pkg_pretend() {
	if use !systemd; then
		# Needed for anbox-bridge.sh
		CONFIG_CHECK="
			~NETFILTER_XT_MATCH_COMMENT
			~NETFILTER_XT_TARGET_CHECKSUM
		"
		check_extra_config
	fi
	# Check if ANDROID_BINDER_DEVICES has binder string specicied in it
	linux_config_exists && grep -qE '(CONFIG_ANDROID_BINDER_DEVICES=*[^h][^w]binder)' "${KERNEL_DIR}"/.config || eerror "  CONFIG_ANDROID_BINDER_DEVICES does not contain string 'binder'"
}

src_prepare() {
	[[ "${PV}" == "9999" ]] || mv "${WORKDIR}"/cpu_features-"${EXTCOMMIT}"/* "${S}"/external/cpu_features || die
	use !systemd && eapply "${FILESDIR}"/remove_systemd_dependency.patch
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_X11=$(usex X)
		-DENABLE_WAYLAND=$(usex wayland)
	)
	[[ "${PV}" == "9999" ]] || mycmakeargs+=(-DANBOX_VERSION="${PV}")
	cmake_src_configure
}

src_install() {
	cmake_src_install
	newbin "${FILESDIR}"/anbox-launch.sh anbox-launch
	if use systemd; then
		systemd_dounit "${FILESDIR}"/anbox-{{container,session}-manager.service,bridge.net{dev,work}}
	else
		exeinto /usr/share/anbox
		doexe "scripts/anbox-bridge.sh"
		newinitd "${FILESDIR}"/anbox-container-manager.initd anbox-container-manager
		newconfd "${FILESDIR}"/anbox.confd anbox
	fi
}

pkg_postinst() {
	einfo "Anbox requires a specially made android image installed to /usr/share/anbox/android.img. "
	einfo "You can either download it prebuilt from upstream:"
	einfo " https://build.anbox.io/android-images/"
	einfo "or to build it manually according to instructions:"
	einfo " https://github.com/anbox/anbox/blob/master/docs/build-android.md"
	einfo ""
	einfo "How to get it running:"
	einfo "First start the anbox-container-manager daemon"
	if use systemd; then
		einfo "# systemctl start anbox-container-manager"
	else
		einfo "# rc-service anbox-container-manager start"
	fi
	einfo "Then you can access the image"
	einfo "$ anbox-launch"
}
