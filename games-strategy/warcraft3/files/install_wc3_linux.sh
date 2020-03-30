#!/usr/bin/env bash
set -eu

wine_window_stage1=""
wine_window_stage2=""
wine_window_stage3=""
wine_window_stage4=""
wine_window_stage5=""
wine_window_stage6=""
wine_window_stage7=""
installer_window=""
eula_window=""
cdkey_window=""
location_window=""
installation_window=""
shortcut_window=""
registration_window=""

XAUTHORITY=$(pwd)/xauth
DISPLAY=""

function list_wine_windows {
	local array=""
	set +eu
	while [ "${array}" = "" ]; do
		sleep 5
		array=($(xdotool search --class wine))
	done
	set -eu
	echo ${array[@]}
}

function last_wine_window {
	local array=($@)
	echo ${array[$((${#array[@]}-1))]}
}

function initialize_openbox {
	xvfb-run -a -f ${XAUTHORITY} openbox --sync &
	while [ "${DISPLAY}" = "" ]; do
		DISPLAY=$(ps aux | awk '{if($1 == "'$(whoami)'") print $0}' | grep Xvfb\ :[0-9]* | grep -v grep | grep -o Xvfb\ :[0-9]* | awk '{print $2}')
	done
}

function create_wine_prefix {
	wine systeminfo
}

function start_roc_installer {
	initialize_openbox
	create_wine_prefix
	pushd ${WAR3ROC_CDROM_ROOT}
	wine install.exe &
	popd
}

function start_tft_installer {
	pushd ${WAR3TFT_CDROM_ROOT}
	wine install.exe &
	popd
}

function begin_install {
	wine_window_stage1=($(list_wine_windows))
	installer_window=$(last_wine_window ${wine_window_stage1[@]})
# Initiate installation
	xdotool windowactivate --sync ${installer_window} key W
}

function accept_eula {
	wine_window_stage2=($(list_wine_windows))
	eula_window=$(last_wine_window ${wine_window_stage2[@]})
	xdotool windowactivate --sync ${eula_window} key A
}

function pass_roc_cdkey_prompt {
	wine_window_stage3=($(list_wine_windows))
	cdkey_window=$(last_wine_window ${wine_window_stage3[@]})
# Input Gentoo as the owner
	for i in G e n t o o; do
		xdotool windowactivate --sync ${cdkey_window} key $i
	done
	xdotool windowactivate --sync ${cdkey_window} key Tab
# Input CDKEY
	for (( i=0; i<${#WAR3ROC_CDKEY}; i++ )); do
		if [ "${WAR3ROC_CDKEY:$i:1}" != "-" ]; then
			xdotool windowactivate --sync ${cdkey_window} key ${WAR3ROC_CDKEY:$i:1}
		fi
	done
	xdotool windowactivate --sync ${cdkey_window} key Tab
	xdotool windowactivate --sync ${cdkey_window} key KP_Enter
}

function pass_tft_cdkey_prompt {
	wine_window_stage3=($(list_wine_windows))
	cdkey_window=$(last_wine_window ${wine_window_stage3[@]})
# Input CDKEY
	for (( i=0; i<${#WAR3TFT_CDKEY}; i++ )); do
		if [ "${WAR3TFT_CDKEY:$i:1}" != "-" ]; then
			xdotool windowactivate --sync ${cdkey_window} key ${WAR3TFT_CDKEY:$i:1}
		fi
	done
	xdotool windowactivate --sync ${cdkey_window} key Tab
	xdotool windowactivate --sync ${cdkey_window} key KP_Enter
}

function input_location {
# Input location
	wine_window_stage4=($(list_wine_windows))
	location_window=$(last_wine_window ${wine_window_stage4[@]})
	set +e
	xdotool windowactivate --sync ${location_window} key KP_Enter
	xdotool windowactivate --sync ${location_window} key KP_Enter
	set -e
}

function wait_through_installation {
# Wait through installation
	wine_window_stage5=($(list_wine_windows))
	installation_window=$(last_wine_window ${wine_window_stage5[@]})
	while [ $(list_wine_windows | grep -c ^${installation_window}$) -eq 1 ]; do
		sleep 5
	done
	sleep 5
}

function pass_shortcut_phase {
# No shortcut please
	wine_window_stage6=($(list_wine_windows))
	shortcut_window=$(last_wine_window ${wine_window_stage6[@]})
	xdotool windowactivate --sync ${shortcut_window} key Tab
	xdotool windowactivate --sync ${shortcut_window} key KP_Enter
}

function pass_registration_phase {
# No registration please
	wine_window_stage7=($(list_wine_windows))
	registration_window=$(last_wine_window ${wine_window_stage7[@]})
	xdotool windowactivate --sync ${registration_window} key Tab
	xdotool windowactivate --sync ${registration_window} key KP_Enter
}

function exit_from_installer {
# Exit from installer
	xdotool windowclose ${installer_window}
	set +e
	while [ $(ps aux | awk '{if($1 == "'$(whoami)'") print $0}' | grep \\.exe | grep -vc grep) -gt 0 ]; do
		ps aux | awk '{if($1 == "'$(whoami)'") print $0}' | grep \\.exe | grep -v grep | awk '{print $2}' | xargs kill -15
		sleep 15
	done
	set -e
#	rm -f ${XAUTHORITY}
}

function start_patcher {
	set -x
	if [ ${TFT} -eq 1 ]; then
		wine ${DISTDIR}/War3TFT_126a_English.exe &
	else
		wine ${DISTDIR}/War3ROC_126a_English.exe &
	fi
}

function wait_for_patch_dialog {
	local array=($(list_wine_windows))
	local limit=3
	if [ ${TFT} -eq 1 ]; then
		limit=4
	fi
	while [ ${#array[@]} -ne ${limit} ]; do
		sleep 1
		array=($(list_wine_windows))
	done
	while [ $(ls ${WINEPREFIX}/drive_c/Program\ Files/Warcraft\ III | grep ^PTC.*\\.tmp$ -c) -ne 0 ]; do
		sleep 1
	done
}

function close_patcher {
	local wine_windows=($(list_wine_windows))
	local patcher_window=$(last_wine_window ${wine_windows[@]})
	xdotool windowclose ${patcher_window}
}

function close_xvfb {
	set +e
	while [ $(ps aux | awk '{if($1 == "'$(whoami)'") print $0}' | grep openbox | grep -vc grep) -gt 0 ]; do
		ps aux | awk '{if($1 == "'$(whoami)'") print $0}' | grep openbox | grep -v grep | awk '{print $2}' | xargs kill -15
		sleep 15
	done
	set -e
}

function main {
	start_roc_installer
	begin_install
	accept_eula
	pass_roc_cdkey_prompt
	input_location
	wait_through_installation
	pass_shortcut_phase
	exit_from_installer
	if [ ${TFT} -eq 1 ]; then
		start_tft_installer
		begin_install
		accept_eula
		pass_tft_cdkey_prompt
		wait_through_installation
		pass_shortcut_phase
		exit_from_installer
	fi
	if [ ${PATCH} -eq 1 ]; then
		start_patcher
		wait_for_patch_dialog
		close_patcher
	fi
	close_xvfb
}

main $@
