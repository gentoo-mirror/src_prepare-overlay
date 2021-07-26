# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="Image gallery application by KDE designed for desktop and touch devices"
HOMEPAGE="https://invent.kde.org/graphics/koko"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://invent.kde.org/graphics/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64"
fi
SRC_URI="
	${SRC_URI}
	http://download.geonames.org/export/dump/cities1000.zip -> ${P}-cities1000.zip
	http://download.geonames.org/export/dump/admin1CodesASCII.txt -> ${P}-admin1CodesASCII.txt
	http://download.geonames.org/export/dump/admin2Codes.txt -> ${P}-admin2Codes.txt
"

# Cmake tests
RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="LGPL-3"
SLOT="0"
IUSE="test"

BDEPEND="
	app-arch/unzip
"
RDEPEND="
	kde-frameworks/purpose:5
"
DEPEND="
	${RDEPEND}
	dev-qt/qtpositioning:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	test? (
		dev-qt/qttest
	)
"

src_prepare() {
	cmake_src_prepare

	local dump_files="
		cities1000.zip
		admin1CodesASCII.txt
		admin2Codes.txt
	"
	for f in ${dump_files}
	do
		echo "Copying: ${f}"
		cp "${DISTDIR}"/"${P}-${f}" "${S}"/src/"${f}" || die "Failed to copy: ${f}"
	done
}
