# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Keep in mind that PN = scilab-bin

EAPI=7

DESCRIPTION="Scientific software package for numerical computations"
HOMEPAGE="https://www.scilab.org/"
SRC_URI="https://www.scilab.org/download/${PV}/scilab-${PV}.bin.linux-x86_64.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror test"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND=""

S="${WORKDIR}/scilab-${PV}"

QA_PREBUILT="*"
QA_PRESTRIPPED="${QA_PREBUILT}"

src_install() {
	for d in ACKNOWLEDGEMENTS  CHANGES.md  COPYING  README.md
	do
		dodoc "${d}" && rm "${d}"
	done

	mkdir -p "${D}/usr/bin" || die
	mkdir -p "${D}/opt/${PN}" || die

	mv * "${D}/opt/${PN}" || die

	pushd "${D}/usr/bin" >/dev/null || die
	ln -s ../../opt/"${PN}"/bin/?* . || die
	popd || die
}
