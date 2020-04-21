BDEPEND+="
	sys-apps/sed
	sys-apps/coreutils
"

windowshelper_convert_normal_path_to_windows_path() {
	local abs_path="$1"
	if ! [[ "$1" =~ '^\/' ]]; then
		abs_path=$(readlink -f "$1")
	fi
	echo "${abs_path}" | sed 's_^_Z:_;s_/_\\_g'
}
