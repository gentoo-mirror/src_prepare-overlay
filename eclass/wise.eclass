# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: wise.eclass
# @MAINTAINER:
# moog621@gmail.com
# @AUTHOR:
# moog621@gmail.com
# @SUPPORTED_EAPIS: 7
# @BLURB: Functions to work with WISE installers.
# @DESCRIPTION:
# This class will provide various bits and bobs to work with WISE installers
# that were popular in retail and shareware softwares in the 1990s.
# There are 2 key components at play.
# First, there is a Pascal program that runs in DOS, Windows and OS/2.
# There exists source code for it, but porting it to FreePascal and Linux
# proves very challenging. Instead, the DOS version is run inside of DOSBox.
# It takes a considerable amount of time, but it gets it right. Unfortunately,
# the program does not respect any directory structures or filenames, so
# we are left to pick up the pieces with key component 2: shell functions
# made for cleaning up this mess.

# In order to disable network-sandbox:
PROPERTIES+="live"

# @ECLASS_VARIABLE: WISE_INSTALLER
# @DESCRIPTION:
# WISE installer path. It can be an array!
: ${WISE_INSTALLER:=}

LICENSE+="e_wise-mit-like"
SRC_URI+="
	http://kannegieser.net/veit/programm/e_wise.arj
"

BDEPEND+="
	games-emulation/dosbox
	app-arch/p7zip
"

# @FUNCTION: wise_unpack_installers
# @DESCRIPTION:
# This function requires that a global array called WISE_INSTALLER be declared on the package's level.
# All paths in that variable will be extracted with e_wise for DOS, because a native version does not exist yet.
wise_unpack_installers() {
	mkdir wise_output
	mkdir ewise
	pushd ewise
		7z x "${DISTDIR}/e_wise.arj"
	popd
	local counter=0
	for wiseguy in ${WISE_INSTALLER[@]}; do
		wiseguy_abs=$(readlink -f ${wiseguy})
		wiseguy_dir=$(echo ${wiseguy} | sed 's/\.exe//')
		wiseguy_config="${wiseguy}.dosbox"
		cat <<EOF > "${wiseguy_config}"
[autoexec]
mount D ${WORKDIR}/ewise
mount E ${WORKDIR}/${wiseguy_dir}
mount F ${WORKDIR}
D:\\E_WISE_D.EXE F:\\${counter}.exe E:\\
exit
EOF
		mkdir ${wiseguy_dir}
		ln -s ${DISTDIR}/${wiseguy} ${counter}.exe
		pushd ${wiseguy_dir}
			elog "Extracting ${wiseguy} in DOSBox"
			SDL_VIDEODRIVER=dummy dosbox -conf ${WORKDIR}/${wiseguy_config}
			elog "Creating directory structures"
			grep filename:\ MAINDIR 00000000.BAT | sed 's/^.*filename:\ MAINDIR\\//;s/\\/\//g;s:[^/]*$::;s/\/$//' | sort -u | xargs mkdir -p
			elog "Renaming files"
			grep ^MOVE\s*.*\ MAINDIR 00000000.BAT -B1 | tr -d '\r' | sed 's/\\/\//g;s/^MOVE\s*\([^/]*\)\ MAINDIR\/\(.*\)$/\2\/\1/;s/^RENAME\ \([^/]*\)\ .*$/mv\ \1/;/^\-\-$/d' | sed 'N;s/\.EWI\n/\.EWI\ /' | sh
			for i in $(ls | grep \\.EWI$); do
				if [ $(grep -c "^RENAME\ $i\ .*$" 00000000.BAT) -eq 0 ]; then
					elog "Removing homeless file $i"
					rm -f $i
				fi
			done
			for i in $(grep EWI\ W32INST_PATH_ 00000000.BAT | awk '{print $2}'); do
				elog "Removing useless file $i"
				rm -f $i
			done
			elog "Removing useless file 00000000.BAT"
			elog "Removing useless file 00000000.TXT"
			rm -f 00000000.BAT 00000000.TXT
			mv * ${WORKDIR}/wise_output
		popd
		counter=$((${counter} + 1))
	done
}
