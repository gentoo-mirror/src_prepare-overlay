# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Keep in mind that PN = scilab-bin

EAPI=7

inherit xdg

DESCRIPTION="Scientific software package for numerical computations"
HOMEPAGE="https://www.scilab.org/"
SRC_URI="https://www.scilab.org/download/${PV}/scilab-${PV}.bin.linux-x86_64.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror test"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	sci-mathematics/scilab-bin
"

S="${WORKDIR}/scilab-${PV}"

QA_PREBUILT="*"
QA_PRESTRIPPED="${QA_PREBUILT}"

src_install() {
	local d
	for d in ACKNOWLEDGEMENTS COPYING *.md
	do
		dodoc "${d}" && rm "${d}"
	done

	mkdir -p "${D}/usr/bin" || die
	mkdir -p "${D}/usr/share" || die
	mkdir -p "${D}/opt/${PN}" || die

	cp -R ./share/applications "${D}/usr/share" || die
	cp -R ./share/icons "${D}/usr/share" || die

	mv * "${D}/opt/${PN}" || die

	pushd "${D}/usr/bin" >/dev/null || die
	ln -s ../../opt/"${PN}"/bin/* . || die
	popd || die
}
