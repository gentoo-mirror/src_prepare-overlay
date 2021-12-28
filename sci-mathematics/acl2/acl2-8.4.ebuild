# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp-common

DESCRIPTION="Industrial strength theorem prover"
HOMEPAGE="https://www.cs.utexas.edu/users/moore/acl2/"
SRC_URI="https://github.com/acl2/acl2/archive/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+books +doc emacs"

RDEPEND=">=dev-lisp/sbcl-1.5.2:="
DEPEND="${RDEPEND}"
BDEPEND="emacs? ( >=app-editors/emacs-23.1:* )"

PATCHES=( "${FILESDIR}"/${PN}-use_make_variable.patch )

LISP="sbcl --noinform --noprint --no-sysinit --no-userinit --disable-debugger"
SAVED_NAME=saved_acl2

DOCS=( books/README.md )

src_prepare() {
	find . -type f -name "*.bak" -delete
	find . -type f -name "*.orig" -delete

	# Remove sparc binary inadvertently included in upstream
	rm books/workshops/2003/schmaltz-al-sammane-et-al/support/acl2link || die

	default
}

src_compile() {
	emake LISP="${LISP}"

	use books && emake ACL2="${S}"/${SAVED_NAME} basic
	use doc && emake ACL2="${S}"/${SAVED_NAME} DOC

	use emacs && elisp-compile emacs/*.el
}

src_install() {
	sed -e "s|${S}|/usr/share/acl2|g" -i ${SAVED_NAME} || die
	sed -e "5iexport ACL2_SYSTEM_BOOKS=/usr/share/acl2/books/"  \
		-i ${SAVED_NAME} || die

	dobin ${SAVED_NAME}
	dosym ${SAVED_NAME} /usr/bin/${PN}

	insinto /usr/share/acl2
	doins ${SAVED_NAME}.core
	use books && doins -r books

	use doc && HTML_DOCS=( doc/HTML/. )
	einstalldocs

	if use emacs ; then
		elisp-install ${PN} emacs/*{.el,elc}
		doins TAGS
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
