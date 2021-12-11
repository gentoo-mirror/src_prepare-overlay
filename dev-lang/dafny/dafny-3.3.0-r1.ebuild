# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_V=5.0
DOTNET=net${DOTNET_V}

DESCRIPTION="Verification-aware programming language"
HOMEPAGE="https://dafny-lang.github.io/dafny/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dafny-lang/${PN}.git"
else
	SRC_URI="https://github.com/dafny-lang/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# TODO: src_test
RESTRICT="network-sandbox test"
LICENSE="MIT"
SLOT="0"
IUSE="debug doc"

DEPEND="
	>=virtual/jdk-1.8.0:*
	virtual/dotnet-sdk:${DOTNET_V}
"
RDEPEND="
	${DEPEND}
	~sci-mathematics/z3-4.8.5
"
BDEPEND="
	|| ( dev-java/gradle-bin dev-java/gradle )
	doc? (
		dev-texlive/texlive-xetex
		|| ( app-text/pandoc app-text/pandoc-bin )
	)
"

DAFNY_EXES="
	usr/share/dafny/Dafny
	usr/share/dafny/DafnyLanguageServer
	usr/share/dafny/DafnyServer
"

QA_PREBUILT="${DAFNY_EXES}"

src_prepare() {
	unset _JAVA_OPTIONS
	export GRADLE_USER_HOME="${HOME}/.gradle"

	if use debug ; then
		DOTNET_CONFIGURATION=Debug
	else
		DOTNET_CONFIGURATION=Release
	fi
	export DOTNET_CONFIGURATION
	einfo "DOTNET_CONFIGURATION: ${DOTNET_CONFIGURATION}"

	default
}

src_configure() {
	ebegin "Restoring"
	dotnet restore --no-cache ./Source/Dafny.sln
	eend $? || die "dotnet restore filed"
}

src_compile() {
	ebegin "Building"
	dotnet build --configuration "${DOTNET_CONFIGURATION}" ./Source/Dafny.sln
	eend $? || die "dotnet build failed"

	use doc && emake -j1 refman-release
}

src_install() {
	insinto /usr/share/${PN}
	doins -r ./Binaries/${DOTNET}/*

	local exe
	for exe in ${DAFNY_EXES} ; do
		fperms +x "/${exe}"
		dosym "../../${exe}" "/usr/bin/$(basename "${exe,,}")"
		dosym "../../${exe}" "/usr/bin/$(basename "${exe}")"
	done

	dodoc *.md *.txt

	use doc && dodoc docs/DafnyRef/DafnyRef.pdf
}
