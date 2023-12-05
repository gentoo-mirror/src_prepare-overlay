# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala virtualx xdg

DESCRIPTION="Native Linux App for UI and UX Design built in Vala and Gtk "
HOMEPAGE="https://github.com/akiraux/akira"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/akiraux/${PN}.git"
else
	COMMIT="3b6c58ab4376f0c40cf647164354a65ba2b15a3f"
	SRC_URI="https://github.com/akiraux/Akira/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz"
	S="${WORKDIR}/${PN^}-${COMMIT}"

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/libarchive
	>=dev-libs/granite-6.0.0
	dev-libs/json-glib
	dev-libs/libgee:0.8
	dev-libs/libxml2
	>=x11-libs/cairo-1.14
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
"

pkg_setup() {
	vala_setup
}

src_prepare() {
	eapply_user

	# Remove automagic test dependencies
	sed -i \
		-e 's/\(appstream_util =\) .*/\1 disabler()/' \
		-e 's/\(desktop_file_validate =\) .*/\1 disabler()/' \
		-e 's/\(vala_lint =\) .*/\1 disabler()/' \
		meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_use test install-tests)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	dosym com.github.akiraux.akira /usr/bin/akira
}

src_test() {
	local -x PATH="${BUILD_DIR}/tests:${PATH}"
	local -x top_builddir="${S}"
	virtx meson_src_test
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
