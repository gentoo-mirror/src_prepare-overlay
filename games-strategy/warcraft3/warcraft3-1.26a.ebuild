# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE=""

LICENSE="Warcraft3_EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_URI="https://archive.org/download/wc3_patches/Windows/ROC/English/War3ROC_126a_English.exe https://archive.org/download/wc3_patches/Windows/TFT/English/War3TFT_126a_English.exe"

IUSE="tft video_cards_nouveau"

BDEPEND="
	sys-apps/sed
	sys-apps/coreutils
	sys-apps/grep
	sys-apps/gawk
	sys-process/procps
	media-gfx/icoutils
	media-gfx/imagemagick
	x11-misc/xvfb-run
	x11-misc/xdotool
	x11-wm/openbox"

RDEPEND="
	app-emulation/wine-vanilla[abi_x86_32,gstreamer]
	media-plugins/gst-plugins-meta[ffmpeg]
	media-video/ffmpeg[mp3,xvid]
	app-emulation/winetricks
	app-shells/bash"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	if [ -z ${WAR3ROC_CDKEY} ] || [ -z ${WAR3ROC_CDROM_ROOT} ]; then
		eerror "Missing WAR3ROC_CDKEY and WAR3ROC_CDROM_ROOT environment variables. Without them, Warcraft 3 cannot be installed."
		die
	fi
	if use tft ; then
		if [ -z ${WAR3TFT_CDKEY} ] || [ -z ${WAR3TFT_CDROM_ROOT} ]; then
			eerror "Missing WAR3TFT_CDKEY and WAR3TFT_CDROM_ROOT environment variables. Without them, The Frozen Throne expansion cannot be installed."
			die
		fi
	fi
	if use video_cards_nouveau ; then
		einfo "This USE flag has no effect just yet. This is a placeholder for https://gitlab.com/src_prepare/src_prepare-overlay/-/issues/2"
	fi
	export WINEPREFIX="$(pwd)/wineprefix"
	export WINEARCH="win32"
	export WINEDEBUG="-all"
	export HID_DEVICES=($(ls /dev | grep ^hid | sed 's_^_/dev/_'))
	export PATCH=1
	export TFT=0
	if use tft ; then
		TFT=1
	fi
	einfo "Adding temporary pseudo rw to /dev/input"
	addpredict /dev/input
	for hid_device in ${HID_DEVICES[@]}; do
		einfo "Adding temporary pseudo rw to ${hid_device}"
		addpredict ${hid_device}
	done
	if use tft ; then
		eerror "The Frozen Throne is not supported yet."
		die
	fi
	${FILESDIR}/install_wc3_linux.sh
	einfo "Installation finished."
# Everything ready, time to prepare for src_install
	mv ${WINEPREFIX}/drive_c/Program\ Files/Warcraft\ III warcraft3
	wrestool -x -t14 -n WAR3.ICO -o . warcraft3/war3.exe
	wrestool -x -t14 -n WORLDEDIT_ICON_2_MAP -o . warcraft3/worldedit.exe
	convert war3.exe_14_WAR3.ICO_0.ico warcraft3.png
	convert worldedit.exe_14_WORLDEDIT_ICON_2_MAP.ico warcraft3_worldedit.png
	mv warcraft3-8.png warcraft3.png
	mv warcraft3_worldedit-8.png warcraft3_worldedit.png
	if use tft ; then
		einfo "Stub: TFT parts here"
	fi
}

src_install() {
	insinto /usr/share/games
	doins -r warcraft3
	insinto /usr/share/pixmaps
	doins warcraft3.png
	doins warcraft3_worldedit.png
	insinto /usr/share/applications
	doins "${FILESDIR}/warcraft3.desktop"
	doins "${FILESDIR}/warcraft3_worldedit.desktop"
	dobin "${FILESDIR}/warcraft3"
	dobin "${FILESDIR}/warcraft3_worldedit"
	if use tft ; then
		einfo "Stub: TFT parts here"
	fi
}
