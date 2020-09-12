# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="scripts"

inherit eutils git-r3

DESCRIPTION="Small scripts from src_prepare group"
HOMEPAGE="https://gitlab.com/src_prepare/scripts"
EGIT_REPO_URI="https://gitlab.com/src_prepare/${MY_PN}.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	app-shells/bash:*
"
RDEPEND="
	${DEPEND}
"

src_install() {
	# Install the docs
	local doc
	for doc in *.md
	do
		dodoc "${doc}"
	done

	# Install the scripts
	if pushd src
	then
		local script
		for script in *
		do
			exeinto "/opt/${PN}"
			doexe "${script}"
			dosym "../../opt/${PN}/${script}" "/usr/bin/src_prepare-${script}"
		done
		popd
	else
		die "There is no ${S}/src directory"
	fi
}
