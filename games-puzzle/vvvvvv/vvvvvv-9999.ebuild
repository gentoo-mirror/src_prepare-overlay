# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN^^}"

inherit cmake desktop wrapper xdg

DESCRIPTION="Retro-styled 2D puzzle platformer (source-available release)"
HOMEPAGE="https://thelettervsixtim.es/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/TerryCavanagh/${MY_PN}.git"
else
	SRC_URI="https://github.com/TerryCavanagh/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}"/"${MY_PN}-${PV}"
fi
SRC_URI="
	${SRC_URI}
	https://thelettervsixtim.es/images/${PN}%20logo%20official.jpg -> ${PN}.jpg
	https://thelettervsixtim.es/makeandplay/data.zip -> ${PN}-data.zip
"

RESTRICT="mirror bindist"
LICENSE="VVVVVV-1.0"
SLOT="0"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer
"
RDEPEND="
	${DEPEND}
"

CMAKE_USE_DIR="${S}/desktop_version"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_fetch && git-r3_checkout
	else
		unpack "${P}.tar.gz"
	fi
}

src_prepare() {
	default

	cmake_src_prepare
	xdg_src_prepare
}

src_install() {
	dodoc README.md

	exeinto /opt/"${MY_PN}"
	pushd "${BUILD_DIR}"

	if [ -x "${PN}.x86_64" ]
	then
		newexe "${PN}.x86_64" "${MY_PN}"
	elif [ -x "${MY_PN}" ]
	then
		doexe "${MY_PN}"
	else
		die
	fi

	popd

	insinto /opt/"${MY_PN}"
	newins "${DISTDIR}"/"${PN}-data.zip" data.zip

	doicon "${DISTDIR}"/"${PN}.jpg"

	make_wrapper "${PN}" "./${MY_PN}" "/opt/${MY_PN}"
	make_desktop_entry "${PN}" "${MY_PN}" "${PN}" "Game;"
}
