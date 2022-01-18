# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info systemd cmake

DESCRIPTION="Container-based approach to boot a full Android system"
HOMEPAGE="https://anbox.io/"

if [[ "${PV}" == "99999999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/anbox/anbox.git"
	EGIT_SUBMODULES=( 'external/cpu_features' )
else
	COMMIT="84f0268012cbe322ad858d76613f4182074510ac" # 20.10.2021
	EXTCOMMIT="b9593c8b395318bb2bc42683a94f962564cc4664"
	SRC_URI="
		https://github.com/anbox/anbox/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
		https://github.com/google/cpu_features/archive/${EXTCOMMIT}.tar.gz -> cpu_features-${EXTCOMMIT}.tar.gz
	"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="X wayland systemd"

DEPEND="
	>=app-containers/lxc-3.0.0
	dev-cpp/properties-cpp
	dev-cpp/sdbus-cpp
	dev-cpp/gtest
	dev-libs/boost[threads(+)]
	dev-libs/expat
	dev-libs/protobuf
	media-libs/libsdl2
	media-libs/glm
	media-libs/mesa[egl(+),gles2]
	media-libs/sdl2-image
	sys-apps/dbus
	sys-fs/fuse:3
	sys-libs/libcap
	|| (
		sys-apps/systemd
		sys-auth/elogind
	)
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

PATCHES=(
	"${FILESDIR}/lxc.patch"
	"${FILESDIR}/no_bundled_sdbus-r1.patch"
)

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
	if ! linux_config_exists && grep -qE '(CONFIG_ANDROID_BINDER_DEVICES=*[^h][^w]binder)' "${KERNEL_DIR}"/.config; then
		eerror "  CONFIG_ANDROID_BINDER_DEVICES does not contain string 'binder'"
	fi
}

src_prepare() {
	cp "${FILESDIR}/FindGMock.cmake" "${S}/cmake" || die

	if [[ "${PV}" != "99999999" ]]; then
		mv "${WORKDIR}"/cpu_features-"${EXTCOMMIT}"/* "${S}"/external/cpu_features || die
	fi

	if use !systemd; then
		eapply "${FILESDIR}"/remove_systemd_dependency-r1.patch
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_X11=$(usex X)
		-DENABLE_WAYLAND=$(usex wayland)
		-DBUILD_SHARED_LIBS=OFF
	)
	if [[ "${PV}" != "99999999" ]]; then
		mycmakeargs+=(-DANBOX_VERSION="${PV} (${COMMIT})")
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	newbin "${FILESDIR}"/anbox-launch.sh anbox-launch

	if use systemd; then
		systemd_dounit "${FILESDIR}"/anbox-{container-manager.service,bridge.net{dev,work}}
		systemd_douserunit "${FILESDIR}"/anbox-session-manager.service
	else
		exeinto /usr/share/anbox
		doexe scripts/anbox-bridge.sh
		newinitd "${FILESDIR}"/anbox-container-manager-r1.initd anbox-container-manager
		newconfd "${FILESDIR}"/anbox-container-manager.confd anbox-container-manager
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
