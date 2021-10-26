# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_FRAMEWORK="5.0"

DESCRIPTION="Verification-aware programming language"
HOMEPAGE="https://dafny-lang.github.io/dafny/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dafny-lang/${PN}.git"
else
	SRC_URI="https://github.com/dafny-lang/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# TODO: src_test
RESTRICT="network-sandbox test"
LICENSE="MIT"
SLOT="0"
IUSE="debug"

BDEPEND="
	|| ( dev-java/gradle-bin dev-java/gradle )
"
DEPEND="
	>=virtual/jdk-1.8.0:*
	virtual/dotnet-sdk:${DOTNET_FRAMEWORK}
"
RDEPEND="
	${DEPEND}
	sci-mathematics/z3
"

DAFNY_EXES="
	usr/share/dafny/Dafny
	usr/share/dafny/DafnyLanguageServer
	usr/share/dafny/DafnyServer
"

QA_PREBUILT="${DAFNY_EXES}"

src_prepare() {
	if use debug; then
		DOTNET_CONFIGURATION="Debug"
	else
		DOTNET_CONFIGURATION="Release"
	fi
	export DOTNET_CONFIGURATION
	einfo "DOTNET_CONFIGURATION=${DOTNET_CONFIGURATION}"

	default
}

src_configure() {
	dotnet restore --no-cache ./Source/Dafny.sln ||
		die "dotnet restore filed"
}

src_compile() {
	dotnet build --configuration "${DOTNET_CONFIGURATION}" ./Source/Dafny.sln ||
		die "dotnet build failed"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r ./Binaries/net${DOTNET_FRAMEWORK}/*

	local exe
	for exe in ${DAFNY_EXES}; do
		# fix permissions (make executable)
		fperms +x "/${exe}"
		# create symlinks to bin (also convert to a lowercase name)
		dosym "../../${exe}" "/usr/bin/$(basename "${exe,,}")"
	done
}
