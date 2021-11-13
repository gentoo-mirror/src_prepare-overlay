# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bintron desktop

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="
	amd64? ( https://update.code.visualstudio.com/${PV}/linux-x64/stable -> ${P}-amd64.tar.gz )
	arm? ( https://update.code.visualstudio.com/${PV}/linux-armhf/stable -> ${P}-arm.tar.gz )
	arm64? ( https://update.code.visualstudio.com/${PV}/linux-arm64/stable -> ${P}-arm64.tar.gz )
"
S="${WORKDIR}"

LICENSE="
	Apache-2.0
	BSD
	BSD-1
	BSD-2
	BSD-4
	CC-BY-4.0
	ISC
	LGPL-2.1+
	Microsoft-vscode
	MIT
	MPL-2.0
	openssl
	PYTHON
	TextMate-bundle
	Unlicense
	UoI-NCSA
	W3C
"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64"

correct_dir() {
	if use amd64; then
		cd "${WORKDIR}/VSCode-linux-x64" || die
	elif use arm; then
		cd "${WORKDIR}/VSCode-linux-armhf" || die
	elif use arm64; then
		cd "${WORKDIR}/VSCode-linux-arm64" || die
	else
		die "Visual Studio Code only supports amd64, arm and arm64"
	fi
}

src_prepare() {
	correct_dir
	bintron_src_prepare
}

src_install() {
	correct_dir
	bintron_src_install

	newicon ./resources/app/resources/linux/code.png vscode.png
	make_desktop_entry code VSCode vscode "TextEditor;Development;IDE;"
}
