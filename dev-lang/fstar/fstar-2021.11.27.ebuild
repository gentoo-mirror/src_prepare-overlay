# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib

DESCRIPTION="Verification system for effectful programs"
HOMEPAGE="https://www.fstar-lang.org"
SRC_URI="https://github.com/FStarLang/FStar/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/FStar-${PV}"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	dev-ml/batteries:=
	dev-ml/ocaml-fileutils:=
	dev-ml/ocaml-process:=
	dev-ml/ocaml-stdint:=
	dev-ml/ppx_deriving:=
	dev-ml/ppx_deriving_yojson:=
	dev-ml/ppxlib:=
	dev-ml/yojson:=
	dev-ml/zarith:=

	~sci-mathematics/z3-4.8.5
	dev-libs/gmp:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-ml/menhir
	dev-ml/ocamlbuild
	dev-ml/pprint
	dev-ml/sedlex
"

src_install() {
	findlib_src_preinst

	emake PREFIX="${D}/usr" install

	dosym ${PN}.exe /usr/bin/${PN}

	dodoc *.md
}
