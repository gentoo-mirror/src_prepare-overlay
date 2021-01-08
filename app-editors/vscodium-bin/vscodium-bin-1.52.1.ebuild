# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="Open Source Software binaries of VSCode"
HOMEPAGE="https://github.com/VSCodium/vscodium"
SRC_URI="https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="bindist mirror strip test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libsecret"

DEPEND="
	>=media-libs/libpng-1.2.46:0
	>=x11-libs/gtk+-3.0:3
	x11-libs/cairo
	x11-libs/libXtst
"
RDEPEND="
	${DEPEND}
	>=net-print/cups-2.0.0
	dev-libs/nss
	sys-apps/ripgrep
	x11-libs/libXScrnSaver
	x11-libs/libnotify
	libsecret? (
		app-crypt/libsecret[crypt]
	)
"

S="${WORKDIR}"

src_prepare() {
	default

	# Unbundle ripgrep
	rm "resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg" || die
}

src_install() {
	pax-mark m code

	insinto "/opt/${PN}"
	doins -r *

	dosym "../../opt/${PN}/bin/codium" "${EPREFIX}/usr/bin/codium-bin"
	dosym "../../opt/${PN}/bin/codium" "${EPREFIX}/usr/bin/vscodium-bin"

	make_desktop_entry "codium-bin" "Codium-bin" "codium-bin" "Development;IDE"
	newicon "resources/app/resources/linux/code.png" codium-bin.png

	fperms +x "/opt/${PN}/bin/codium"
	fperms +x "/opt/${PN}/chrome-sandbox"
	fperms +x "/opt/${PN}/codium"

	dosym "../../usr/bin/rg" "${EPREFIX}/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
}
