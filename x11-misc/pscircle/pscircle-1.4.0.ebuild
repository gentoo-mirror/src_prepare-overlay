# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson savedconfig systemd

DESCRIPTION="Visualizes Linux processes in a radial tree"
HOMEPAGE="https://gitlab.com/mildlyparallel/pscircle"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/mildlyparallel/${PN}.git"
else
	SRC_URI="https://gitlab.com/mildlyparallel/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="test X"
RESTRICT="!test? ( test )"

CDEPEND="
	x11-libs/cairo[X?]
	X? ( x11-libs/libX11 )
"
DEPEND="
	${CDEPEND}
	media-libs/libpng
	test? (
		dev-cpp/gtest
	)
"
RDEPEND="
	${CDEPEND}
"

PATCHES=(
	"${FILESDIR}/pscircle-1.4.0-enable-tests-with-option.patch"
)

src_prepare() {
	default

	restore_config config.h.meson
}

src_configure() {
	# Leads to test failures in argparser
	filter-lto

	local emesonargs=(
		$(meson_use test enable-tests)
		$(meson_use X enable-x11)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	einstalldocs

	systemd_douserunit examples/pscircle.service

	save_config config.h.meson
}
