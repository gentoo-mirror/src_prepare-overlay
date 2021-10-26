# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_FRAMEWORK="5.0"

DESCRIPTION="Intermediate verification language built on .NET"
HOMEPAGE="https://github.com/boogie-org/boogie"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/boogie-org/${PN}.git"
else
	SRC_URI="https://github.com/boogie-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# TODO: src_test
RESTRICT="network-sandbox test"
LICENSE="MIT"
SLOT="0"
IUSE="debug"

DEPEND="
	virtual/dotnet-sdk:${DOTNET_FRAMEWORK}
"
RDEPEND="
	${DEPEND}
	sci-mathematics/z3
"

# Generated via dotnet
QA_PREBUILT="usr/share/boogie/BoogieDriver"

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
	dotnet restore --no-cache ./Source/Boogie.sln ||
		die "dotnet restore filed"
}

src_compile() {
	dotnet build --configuration "${DOTNET_CONFIGURATION}" ./Source/Boogie.sln ||
		die "dotnet build failed"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r ./Source/BoogieDriver/bin/${DOTNET_CONFIGURATION}/net${DOTNET_FRAMEWORK}/*

	fperms +x /usr/share/${PN}/BoogieDriver
	dosym ../share/${PN}/BoogieDriver /usr/bin/${PN}
}
