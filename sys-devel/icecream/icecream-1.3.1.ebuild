# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user systemd

MY_P="${P/icecream/icecc}"

DESCRIPTION="Distributed compiling of C(++) code across several machines; based on distcc"
HOMEPAGE="https://github.com/icecc/icecream"
SRC_URI="https://github.com/icecc/icecream/releases/download/${PV}/${MY_P}.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND="
	sys-libs/libcap-ng
"
RDEPEND="
	${DEPEND}
	dev-util/shadowman
"

S="${WORKDIR}/${MY_P}"

#PATCHES=(
#	"${FILESDIR}/${P}-libcap-ng.patch"
#)

pkg_setup() {
	enewgroup icecream
	enewuser icecream -1 -1 /var/cache/icecream icecream
}

src_configure() {
	econf \
		--enable-shared --disable-static \
		--enable-clang-wrappers \
		--enable-clang-rewrite-includes
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die

	newconfd suse/sysconfig.icecream icecream
	newinitd "${FILESDIR}"/icecream-r2 icecream
	systemd_newunit "${FILESDIR}/icecream-scheduler.service" 'icecream-scheduler.service'
	systemd_newunit "${FILESDIR}/icecream.service" 'icecream.service'

	insinto /etc/logrotate.d
	newins suse/logrotate icecream

	insinto /usr/share/shadowman/tools
	newins - icecc <<<'/usr/libexec/icecc/bin'
}

pkg_prerm() {
	if [[ -z ${REPLACED_BY_VERSION} && ${ROOT} == / ]]; then
		eselect compiler-shadow remove icecc
	fi
}

pkg_postinst() {
	if [[ ${ROOT} == / ]]; then
		eselect compiler-shadow update icecc
	fi
}
