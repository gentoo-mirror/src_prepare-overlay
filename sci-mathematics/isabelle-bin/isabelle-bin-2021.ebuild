# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

MY_P="Isabelle${PV}"

DESCRIPTION="Generic proof assistant with higher-order logic"
HOMEPAGE="https://isabelle.in.tum.de/overview.html"
SRC_URI="https://isabelle.in.tum.de/dist/${MY_P}_linux.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

RESTRICT="bindist test"
LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="-* ~amd64"

RDEPEND="
	!sci-mathematics/isabelle
"

QA_PREBUILT=".*"

src_install() {
	local ISABELLE_HOME="/opt/isabelle"

	local doc
	for doc in ANNOUNCE CONTRIBUTORS COPYRIGHT NEWS README; do
		if [[ -f ${doc} ]]; then
			dodoc ${doc}
			rm ${doc} || die
		fi
	done

	mkdir -p "${ED}/${ISABELLE_HOME}" || die
	cp -r ./* "${ED}/${ISABELLE_HOME}" || die

	local isabelle_env='env USER_HOME=${HOME}/.cache/isabelle'
	local wrap
	for wrap in ${PN} ${MY_P} Isabelle isabelle; do
		make_wrapper ${wrap} "${isabelle_env} ${ISABELLE_HOME}/${MY_P}" "${ISABELLE_HOME}"
	done

	doicon ./lib/icons/isabelle-mini.xpm
	doicon ./lib/icons/isabelle.xpm

	make_desktop_entry isabelle Isabelle isabelle "Education;Science;Math;"
}
