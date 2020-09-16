# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="scripts"

inherit eutils git-r3

DESCRIPTION="Small scripts from src_prepare group"
HOMEPAGE="https://gitlab.com/src_prepare/scripts"
EGIT_REPO_URI="https://gitlab.com/src_prepare/${MY_PN}.git"

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	app-shells/bash:*
"
DEPEND="
	${RDEPEND}
	test? (
		  dev-python/pylint
		  || (
			 dev-util/shellcheck
			 dev-util/shellcheck-bin
		  )
	)
"

src_test() {
	bash ./test.sh || die "Tests failed"
}

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
