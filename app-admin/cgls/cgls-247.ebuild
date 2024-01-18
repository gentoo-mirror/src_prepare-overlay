# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on:
# - https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-apps/systemd-tmpfiles/systemd-tmpfiles-246.ebuild
# - https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-boot/systemd-boot/systemd-boot-245.ebuild
# Difference: Is is possible to install this on a system running systemd.

EAPI=7

MINKV="3.11"

inherit meson

DESCRIPTION="cgls from systemd"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/systemd/systemd.git"
else
	SRC_URI="https://github.com/systemd/systemd/archive/v${PV}.tar.gz -> systemd-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

# No tests for this one (if I mised them let me know)
RESTRICT="mirror test"
LICENSE="BSD-2 GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"
IUSE="selinux"

BDEPEND="
	>=dev-util/intltool-0.50
	>=sys-apps/coreutils-8.16
	app-text/docbook-xml-dtd:4.2
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt:0
	sys-devel/m4
	virtual/pkgconfig
"
DEPEND="
	>=sys-apps/util-linux-2.30:0=
	>=sys-kernel/linux-headers-${MINKV}
	sys-apps/acl:0=
	sys-libs/libcap:0=
	selinux? ( sys-libs/libselinux:0= )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/systemd-${PV}"

PATCHES=(
	"${FILESDIR}/246-${PN}-libshared-static.patch"
)

src_configure() {
	local systemd_disable_options=(
		adm-group
		analyze
		apparmor
		audit
		backlight
		binfmt
		blkid
		bzip2
		coredump
		dbus
		efi
		elfutils
		environment-d
		fdisk
		firstboot
		gcrypt
		glib
		gnutls
		gshadow
		hibernate
		hostnamed
		hwdb
		idn
		ima
		initrd
		kernel-install
		kmod
		ldconfig
		libcryptsetup
		libcurl
		libfido2
		libidn
		libidn2
		libiptc
		link-networkd-shared
		link-systemctl-shared
		link-timesyncd-shared
		link-udev-shared
		localed
		logind
		lz4
		machined
		microhttpd
		networkd
		nss-myhostname
		nss-resolve
		nss-systemd
		openssl
		p11kit
		pam
		pcre2
		polkit
		portabled
		pstore
		pwquality
		qrencode
		quotacheck
		randomseed
		resolve
		rfkill
		seccomp
		smack
		sysusers
		timedated
		timesyncd
		tmpfiles
		tpm
		userdb
		utmp
		vconsole
		wheel-group
		xdg-autostart
		xkbcommon
		xz
		zlib
		zstd
	)
	# prepend -D and append =false, e.g. zstd becomes -Dzstd=false
	systemd_disable_options=( ${systemd_disable_options[@]/#/-D} )
	systemd_disable_options=( ${systemd_disable_options[@]/%/=false} )

	local emesonargs=(
		-Dacl=true
		-Dstandalone-binaries=true
		-Dstatic-libsystemd=true
		-Dsysvinit-path=''
		${systemd_disable_options[@]}
		$(meson_use selinux)
	)
	meson_src_configure
}

src_compile() {
	local mytargets=(
		systemd-cgls
		man/systemd-cgls.1
	)
	meson_src_compile "${mytargets[@]}"
}

src_install() {
	pushd "${BUILD_DIR}" >/dev/null || die

	newbin systemd-cgls cgls
	newman man/systemd-cgls.1 cgls.1

	popd >/dev/null || die
}
