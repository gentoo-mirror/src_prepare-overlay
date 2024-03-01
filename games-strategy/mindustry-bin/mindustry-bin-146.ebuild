# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg wrapper

DESCRIPTION="A sandbox tower defense game"
HOMEPAGE="https://mindustrygame.github.io"

ICON_COMMIT="d0ff0307f5ce717ee7622e2029785bb1d76e3d18"
SRC_URI="
	https://github.com/Anuken/Mindustry/releases/download/v${PV}/Mindustry.jar
		-> ${P}.jar
	https://github.com/Anuken/Mindustry/raw/${ICON_COMMIT}/core/assets/icons/icon_64.png
		-> mindustry-bin-${ICON_COMMIT}-icon_64.png
"
S="${DISTDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip test"

RDEPEND="
	>=virtual/jre-1.7:*
"

src_unpack() {
	:
}

src_install() {
	insinto "/opt/mindustry"
	newins "${P}.jar" "mindustry.jar"

	make_wrapper mindustry "java -jar /opt/mindustry/mindustry.jar"
	make_desktop_entry mindustry mindustry mindustry "Game;StrategyGame;"
	newicon -s 64 mindustry-bin-${ICON_COMMIT}-icon_64.png mindustry.png
}
