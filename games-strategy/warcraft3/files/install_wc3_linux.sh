#!/usr/bin/env bash
set -xeuo pipefail

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
	xdotool search --class wine
}

function last_wine_window {
	for((counter=0, limit=$(($# - 1)); counter < limit; counter++)); do
		shift
	done
	echo $1
}

function start_installer {
	xvfb-run -a -f ${XAUTHORITY} openbox --sync --startup ${WORKDIR}/run_installer_in_openbox.sh &
	sleep 120
	DISPLAY=$(ps aux | awk '{if($1 == "'$(whoami)'") print $0}' | grep Xvfb\ :[0-9]* | grep -v grep | grep -o Xvfb\ :[0-9]* | awk '{print $2}')
}

function main {
	start_installer
	wine_window_stage1=($(list_wine_windows))
	installer_window=$(last_wine_window ${wine_window_stage1[@]})
# Initiate installation
	xdotool windowactivate --sync ${installer_window} key W
	wine_window_stage2=($(list_wine_windows))
	eula_window=$(last_wine_window ${wine_window_stage2[@]})
	xdotool windowactivate --sync ${eula_window} key A
	wine_window_stage3=($(list_wine_windows))
	cdkey_window=$(last_wine_window ${wine_window_stage3[@]})
# Input Gentoo as the owner
	for i in G e n t o o; do
		xdotool windowactivate --sync ${cdkey_window} key $i
	done
	xdotool windowactivate --sync ${cdkey_window} key Tab
# Input CDKEY
	for (( i=0; i<${#CDKEY}; i++ )); do
		if [ "${CDKEY:$i:1}" != "-" ]; then
			xdotool windowactivate --sync ${cdkey_window} key ${CDKEY:$i:1}
		fi
	done
	xdotool windowactivate --sync ${cdkey_window} key Tab
	xdotool windowactivate --sync ${cdkey_window} key KP_Enter
# Input location
	wine_window_stage4=($(list_wine_windows))
	location_window=$(last_wine_window ${wine_window_stage4[@]})
	xdotool windowactivate --sync ${location_window} key KP_Enter
	xdotool windowactivate --sync ${location_window} key KP_Enter
# Wait through installation
	wine_window_stage5=($(list_wine_windows))
	installation_window=$(last_wine_window ${wine_window_stage5[@]})
	while [ $(list_wine_windows | grep -c ^${installation_window}$) -eq 1 ]; do
		sleep 5
	done
	sleep 5
# No shortcut please
	wine_window_stage6=($(list_wine_windows))
	shortcut_window=$(last_wine_window ${wine_window_stage6[@]})
	xdotool windowactivate --sync ${shortcut_window} key Tab
	xdotool windowactivate --sync ${shortcut_window} key KP_Enter
# No registration please
	wine_window_stage7=($(list_wine_windows))
	registration_window=$(last_wine_window ${wine_window_stage7[@]})
	xdotool windowactivate --sync ${registration_window} key Tab
	xdotool windowactivate --sync ${registration_window} key KP_Enter
# Exit from installer
	xdotool windowactivate --sync ${installer_window} key X
}

main $@
