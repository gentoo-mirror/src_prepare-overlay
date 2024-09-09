# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gog

DESCRIPTION="Post-apocalyptic GURPS-like role-playing game."
HOMEPAGE="https://www.gog.com/game/fallout"
SRC_URI="
	dos? (	https://archive.org/download/fallout1_dos/fallup1d.zip
		https://archive.org/download/fallout1_dos/HMIDET.386
		https://archive.org/download/fallout1_dos/HMIDRV.386 )
"
S=${WORKDIR}

LICENSE+=" FALLOUT1_EULA"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

IUSE="dos wine"

GOG_GAME_NAME="fallout_classic"
GOG_GAME_L10N="en"
GOG_GAME_PLATFORM="w"
GOG_GAME_INSTALLER="setup_fallout_2.1.0.18.exe"

BDEPEND+="
	media-gfx/icoutils
	media-gfx/imagemagick
	dos? ( app-arch/unzip )
"

RDEPEND+="
	dos?  (	games-emulation/dosbox
			app-emulation/dos32a )
	wine? (	app-emulation/wine-vanilla:=[abi_x86_32] )
"

DEPEND="${RDEPEND}"

src_unpack() {
	gog_initialize
	FALLOUT_EXE="fallout1_wine"
	gog_download_installer
	innoextract -I app -e "${GOG_GAME_NAME}/${GOG_GAME_INSTALLER}"
	wrestool -x -t14 -o . app/falloutw.exe
	convert falloutw.exe_14_99_0.ico fallout1.png
	mv fallout1-4.png fallout1.png
	if use dos; then
		cp "${DISTDIR}"/HMID*.386 app
		unzip "${DISTDIR}/fallup1d.zip" FALL11.ZIP
		unzip FALL11.ZIP FALLOUT.EXE
		mv FALLOUT.EXE app
		ln -s /usr/share/dos32a/dos32a.exe app/dos4gw.exe
		cp "${FILESDIR}/dosbox.conf" app
		FALLOUT_EXE="fallout1_dos"
	fi
	mv app fallout1
	cp "${FILESDIR}/${FALLOUT_EXE}" fallout1_exe
}

src_install() {
	insinto /usr/share/games
	doins -r fallout1
	rm -rf fallout1
	mv fallout1_exe fallout1
	insinto /usr/share/pixmaps
	doins fallout1.png
	insinto /usr/share/applications
	doins "${FILESDIR}/fallout1.desktop"
	dobin fallout1
}
