# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BINTRON_NAME="balena-etcher"
BINTRON_HOME="/opt/balenaEtcher/"

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt
	lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit bintron-r1 unpacker

DESCRIPTION="Flash OS images to SD cards & USB drives, safely and easily."
HOMEPAGE="https://etcher.io"
SRC_URI="https://github.com/balena-io/etcher/releases/download/v${PV}/balena-etcher_${PV}_amd64.deb"
S="${WORKDIR}/opt/balenaEtcher/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror test"

RDEPEND="
	virtual/libudev
"

QA_PREBUILT="/opt/balenaEtcher/*"
