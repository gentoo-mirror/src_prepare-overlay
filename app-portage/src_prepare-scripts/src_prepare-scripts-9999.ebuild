# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit git-r3 python-r1

DESCRIPTION="Small scripts from src_prepare group"
HOMEPAGE="https://gitlab.com/src_prepare/scripts"
EGIT_REPO_URI="https://gitlab.com/src_prepare/scripts.git"

RESTRICT="
	binchecks mirror strip
	!test? ( test )
"
LICENSE="ISC"
SLOT="0"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	app-admin/eselect
	app-portage/eix
	app-portage/repoman
	app-shells/bash:*
	dev-lang/perl
	dev-util/pkgcheck
	sys-apps/portage
	|| (
		app-portage/euscan
		app-portage/euscan-ng
	)
"
DEPEND="
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
	local P_HOME="opt/${PN}"
	if pushd src
	then
		local script
		for script in *
		do
			exeinto "${P_HOME}"
			doexe "${script}"
			dosym "../../${P_HOME}/${script}" "/usr/bin/src_prepare-${script}"
		done
		popd
	else
		die "There is no ${S}/src directory"
	fi
}
