# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
PYTHON_REQ_USE="xml"

inherit python-r1

DESCRIPTION="Small scripts from src_prepare group"
HOMEPAGE="https://gitlab.com/src_prepare/scripts"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/src_prepare/scripts.git"
else
	SRC_URI="https://gitlab.com/src_prepare/scripts/-/archive/${PV}/scripts-${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/scripts-${PV}"
fi

RESTRICT="
	mirror
	!test? ( test )
"
LICENSE="GPL-3"
SLOT="0"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	app-admin/eselect
	app-portage/eix
	app-portage/euscan-ng
	app-portage/repoman
	app-shells/bash:*
	dev-lang/perl
	dev-util/pkgcheck
	sys-apps/portage
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
