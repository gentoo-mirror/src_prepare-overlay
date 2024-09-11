# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop git-r3

DESCRIPTION="Miscellaneous logos, wallpapers and other artwork from src_prepare group"
HOMEPAGE="https://gitlab.com/src_prepare/artwork"
EGIT_REPO_URI="https://gitlab.com/src_prepare/artwork"

LICENSE="CC0-1.0"
SLOT="0"
RESTRICT="binchecks mirror strip test"

arr_install() {
	local IFS=$'\n'
	local cmd="${1}"
	local files="${2}"

	if [ -n "${files}" ]; then
		echo "[F] Found following files for installation:"
		echo "${files}"
		local file
		for file in ${files}; do
			if [ -f "${file}" ]; then
				echo "[I] Installing: ${file} (using: ${cmd})"
				"${cmd}" "${file}"
			fi
		done
	fi
}

src_install() {
	local src_backgrounds=/usr/share/backgrounds/src_prepare
	local src_share=/usr/share/src_prepare

	# Wallpapers
	local wallpapers="$(find . -not -path "./.git/*" | grep -i wallpaper | grep -i -E 'jpg|png')"
	insinto "${src_backgrounds}"
	arr_install doins "${wallpapers}"

	# Logos
	local logos="$(find . -not -path "./.git/*" | grep -i logo | grep -i -E 'jpg|png|svg|xpm')"
	arr_install doicon "${logos}"

	# XCF sources
	local xcfs="$(find . -not -path "./.git/*" -type f -name '*.xcf')"
	insinto "${src_share}"
	arr_install doins "${xcfs}"

	# Docs / notices
	local docs="$(find . -not -path './.git/*' -type f -name '*README*')"
	arr_install dodoc "${docs}"
}

pkg_postinst() {
	einfo "Contributions are welcome :)"
	einfo "Repository: https://gitlab.com/src_prepare/artwork"
}
