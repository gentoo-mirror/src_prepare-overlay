# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools java-pkg-2

DESCRIPTION=" Java-based Scheme system & Language Framework"
HOMEPAGE="https://www.gnu.org/software/kawa/"
SRC_URI="https://gitlab.com/kashell/${PN^}/-/archive/${PV}/${PN^}-${PV}.tar.gz"
S="${WORKDIR}/${PN^}-${PV}"

LICENSE="MIT public-domain jemacs? ( GPL-2 ) krl? ( GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+awt +frontend jemacs krl +sax servlets +swing +xml"

COMMON_DEPEND="
	frontend? ( sys-libs/readline:0 )
	sax? ( dev-java/sax:0 )
	servlets? ( java-virtuals/servlet-api:3.0 )
"
DEPEND="
	${COMMON_DEPEND}
	>=virtual/jdk-1.8
"
RDEPEND="
	${COMMON_DEPEND}
	>=virtual/jre-1.8
"

QA_FLAGS_IGNORED="usr/bin/kawa"

src_prepare() {
	default

	java-pkg-2_src_prepare
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable frontend kawa-frontend)
		$(use_enable jemacs)
		$(use_enable krl brl)
		$(use_enable xml)
		$(use_with awt)
		$(use_with sax sax2)
		--with-java-source="$(java-pkg_get-source)"
	)

	if use jemacs && ! use swing; then
		einfo "Although the swing USE flag is disabled you chose to enable jemacs,"
		einfo "so swing is enabled anyway."
		myconf+=( "--with-swing" )
	else
		myconf+=( "$(use_with swing)" )
	fi
	if use servlets; then
		myconf+=(
			"--with-servlet=$(java-pkg_getjar servletapi-2.4 servlet-api.jar)"
		)
	fi

	econf "${myconf[@]}"
}

src_compile() {
	emake -j1
}
