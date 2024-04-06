# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

MY_PN="NotepadNext"
COMMIT_NOTEPADNEXT="b6b0ccc0c380efb13663eb00d5bb8bd140b0553d"
COMMIT_SINGLEAPPLICATION="494772e98cef0aa88124f154feb575cc60b08b38"
COMMIT_UCHARDET="edae8e81cfb8092496f94da1a306c4c9f0ce32bb"
COMMIT_EDITORCONFIG="ee967262db4fdbd735f9971cc0c90cf4f3100d3a"
COMMIT_QADS="8da0713bf0d964f0c5b62e87a8aa61bcae3fa212"
COMMIT_QSIMPLEUPDATER="518b873c97688134c2e535e05db6b4b7cebcccdd"

DESCRIPTION="A cross-platform reimplementation of Notepad++ based on Qt"
HOMEPAGE="https://github.com/dail8859/NotepadNext"
SRC_URI="
	https://github.com/dail8859/${MY_PN}/archive/${COMMIT_NOTEPADNEXT}.tar.gz
		-> ${P}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${COMMIT_SINGLEAPPLICATION}.tar.gz
		-> SingleApplication-${COMMIT_SINGLEAPPLICATION}.tar.gz
	https://gitlab.freedesktop.org/uchardet/uchardet/-/archive/${COMMIT_UCHARDET}.tar.gz
		-> uchardet-${COMMIT_UCHARDET}.tar.gz
	https://github.com/editorconfig/editorconfig-core-qt/archive/${COMMIT_EDITORCONFIG}.tar.gz
		-> editorconfig-core-qt-${COMMIT_EDITORCONFIG}.tar.gz
	https://github.com/githubuser0xFFFF/Qt-Advanced-Docking-System/archive/${COMMIT_QADS}.tar.gz
		-> Qt-Advanced-Docking-System-${COMMIT_QADS}.tar.gz
	https://github.com/alex-spataru/QSimpleUpdater/archive/${COMMIT_QSIMPLEUPDATER}.tar.gz
		-> QSimpleUpdater-${COMMIT_QSIMPLEUPDATER}.tar.gz
"
S="${WORKDIR}/${MY_PN}-${COMMIT_NOTEPADNEXT}"

LICENSE="GPL-3"
# submodule licenses
LICENSE+=" MIT LGPL-2.1 MIT-no-machine-learning || ( MPL-1.1 GPL-2+ LGPL-2.1+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt6"

DEPEND="${RDEPEND}"
RDEPEND="
	x11-libs/libxcb:=
	!qt6? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
	)
	qt6? (
		dev-qt/qtbase:6[gui,network,widgets]
		dev-qt/qt5compat:6
	)
"

src_prepare() {
	default
	mv -T "${WORKDIR}"/QSimpleUpdater-"${COMMIT_QSIMPLEUPDATER}" "${S}"/src/QSimpleUpdater || die
	mv -T "${WORKDIR}"/Qt-Advanced-Docking-System-"${COMMIT_QADS}" "${S}"/src/ads || die
	mv -T "${WORKDIR}"/editorconfig-core-qt-"${COMMIT_EDITORCONFIG}" "${S}"/src/editorconfig-core-qt || die
	mv -T "${WORKDIR}"/SingleApplication-"${COMMIT_SINGLEAPPLICATION}" "${S}"/src/singleapplication || die
	mv -T "${WORKDIR}"/uchardet-"${COMMIT_UCHARDET}" "${S}"/src/uchardet || die
}

src_configure() {
	if use qt6; then
		eqmake6 src/NotepadNext.pro
	else
		eqmake5 src/NotepadNext.pro
	fi
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}
