# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="3e403f023e19f70e3a2dbeed1be02050ea766ffb"

SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz -> firefox-${PV}esr.source.tar.xz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz.asc -> firefox-${PV}esr.source.tar.xz.asc
	https://archive.mozilla.org/pub/firefox/releases/89.0/KEY -> Mozilla_pgp_key-20210507.pgp
"

LICENSE="GPL-3"
SLOT="${PV}"
KEYWORDS="~amd64"

IUSE="+buildtarball"

RESTRICT="buildtarball? ( network-sandbox )"

RDEPEND="${BDEPEND}"
BDEPEND="
	app-arch/unzip
	app-crypt/gnupg
	dev-vcs/mercurial
	dev-perl/File-Rename
"

S="${WORKDIR}/gnuzilla-${COMMIT}"

MOZ_LANGS=(
	ach af an ar ast az be bg bn br bs ca-valencia ca cak cs cy
	da de dsb el en-CA en-GB en-US eo es-AR es-CL es-ES es-MX et eu
	fa ff fi fr fy-NL ga-IE gd gl gn gu-IN he hi-IN hr hsb hu hy-AM
	ia id is it ja ja-JP-mac ka kab kk km kn ko lij lt lv mk mr ms my
	nb-NO ne-NP nl nn-NO oc pa-IN pl pt-BR pt-PT rm ro ru
	si sk sl son sq sr sv-SE ta te th tl tr trs uk ur uz vi
	xh zh-CN zh-TW
)

declare -A LANG_COMMIT
LANG_COMMIT[ach]="b9ace4ac3b961d3fe6ee5a719c8f6f25032aff66" # 2021-08-10
LANG_COMMIT[af]="05d5b0dece841cdcc9dc2b80648fe6f11cf65d0a" # 2021-07-23
LANG_COMMIT[an]="da867cc5c5d4c3e3adca4e243c73ea98615fa694" # 2021-07-23
LANG_COMMIT[ar]="b94e1db9c25b7a3bcd604c748b3bc22365c911bd" # 2021-07-23
LANG_COMMIT[ast]="d8ec4a61ce9f2ed3a3471ef33b12aada225875fe" # 2021-08-08
LANG_COMMIT[az]="8edd2f8e8502637c213980e838241a9f152b00df" # 2021-07-23
LANG_COMMIT[be]="93a0a84446bb38c65d7b9b499288ca1283557fe5" # 2021-08-06
LANG_COMMIT[bg]="30edd840ed33cfcd1f387dd150cee4eab5ddd3f1" # 2021-07-23
LANG_COMMIT[bn]="f04052157cfa363f5f70f57d10c2a4fbdb9f2be5" # 2021-08-10
LANG_COMMIT[br]="87c5c81096b3bfbb5a4e04ab162017343989e906" # 2021-08-10
LANG_COMMIT[bs]="04521a8225e6429ddbfba1914bce7ab9271b4b8d" # 2021-07-23
LANG_COMMIT[ca-valencia]="4682f2336c61417d1bc4d13e2a5d24c1a37d7b3d" # 2021-07-23
LANG_COMMIT[ca]="a604d981b43d980be2f8bb4f316c8ac71017d6c6" # 2021-08-10
LANG_COMMIT[cak]="4c9a74f7e1646b1e269e6cb58f36b26db5c5e713" # 2021-07-23
LANG_COMMIT[cs]="5e0338e53de3faca7213fe29fb6f9e468fa72f85" # 2021-08-10
LANG_COMMIT[cy]="271c50db12e49b7dd823b145a0d3313a7e65efe1" # 2021-08-10
LANG_COMMIT[da]="09af9e75156ed0dada6d2931465a410419356759" # 2021-08-10
LANG_COMMIT[de]="3ab98d82f02b4a0219fa992079d3391f093ce10b" # 2021-07-31
LANG_COMMIT[dsb]="5db1215f11be41c90c937fade00859cac161d341" # 2021-08-10
LANG_COMMIT[el]="b53a08d9b323b8cd865588b151f6a1999b763cd7" # 2021-08-06
LANG_COMMIT[en-CA]="0baabcd1430cbe1d6f53b86254042c9c8c07197c" # 2021-08-05
LANG_COMMIT[en-GB]="455f0b3bc23e9e3aba0be4ebd2d2233bd2bebc7e" # 2021-08-07
LANG_COMMIT[eo]="033a8a18258621452f8c08c6bbf00dffa2a1cdf6" # 2021-08-10
LANG_COMMIT[es-AR]="ee6d8f024181f3f6a4878567a07b4fa75434b23f" # 2021-08-10
LANG_COMMIT[es-CL]="deddc613232d5914d0680a661813f821cbb7f7f2" # 2021-08-08
LANG_COMMIT[es-ES]="0ac945930090ca89d3b99576f40e5adcf3b1a6fb" # 2021-08-10
LANG_COMMIT[es-MX]="91d6d00a7ea86b7b53973865ff07d5c554190f34" # 2021-08-10
LANG_COMMIT[et]="1a17a4c483d0fff52154ea0b4d8e9a32a141270f" # 2021-07-23
LANG_COMMIT[eu]="c5f1285301883aad6df51f72a6c3f8823753bbda" # 2021-08-09
LANG_COMMIT[fa]="50312135239513ff2db7954a84233f6653fde111" # 2021-07-23
LANG_COMMIT[ff]="304e4927d6e8f42f9022340890c9e32dfccb87ec" # 2021-08-10
LANG_COMMIT[fi]="fc228e62d6afe45635ea481249d95c1fdda5966e" # 2021-08-08
LANG_COMMIT[fr]="0fad5fa75170243b7435a8a0f0724e209e4271b7" # 2021-08-10
LANG_COMMIT[fy-NL]="fd2e98a23b5c424dd3efcc181a2209ba9d21bb6a" # 2021-08-10
LANG_COMMIT[ga-IE]="46bf7c97b6ddf330b40f4c94b00dde738ef661d5" # 2021-07-23
LANG_COMMIT[gd]="cc8f367dd7d89cfeccfbfd33cde893be3468a84f" # 2021-07-23
LANG_COMMIT[gl]="ce7af1693ea6f44c17f5719e160f4ad10e55455c" # 2021-08-10
LANG_COMMIT[gn]="f140b5db04c003263b60a99eb2d737397ac78322" # 2021-08-10
LANG_COMMIT[gu-IN]="5d25f524c6de4931c82e0f0a5174b78d8bf59854" # 2021-07-23
LANG_COMMIT[he]="a140661c32a2073acb364319d4bcf585f2b30ac3" # 2021-08-10
LANG_COMMIT[hi-IN]="08aaa769cd4ff2fc5dfde70fad5df4ab66cce04a" # 2021-07-31
LANG_COMMIT[hr]="1169b47a6930818f358dadc8104f7098c39799ec" # 2021-08-10
LANG_COMMIT[hsb]="d2d81fc3124935fa77d7a4af27e04ff4d1ddb38f" # 2021-08-10
LANG_COMMIT[hu]="0772e5d2ad9b3c98f13e6c8b6313d6cd0a17d545" # 2021-08-10
LANG_COMMIT[hy-AM]="32aa7cee4549908b9a59494f61f9f3e90588d82e" # 2021-08-10
LANG_COMMIT[ia]="ed52833b76ae71b5e758ffca57f35a5deb5f4349" # 2021-08-10
LANG_COMMIT[id]="48587cba65a0af698c964ce78a2a6ed4fb67242d" # 2021-07-23
LANG_COMMIT[is]="3d06194f15597000a826a33a9d39085524e9368e" # 2021-07-23
LANG_COMMIT[it]="a68611d18facf03cb809ffd443bdbc8d8ccd486c" # 2021-08-10
LANG_COMMIT[ja]="a64a0c6b581d5b79b9d91463095507e5f62195b6" # 2021-08-09
LANG_COMMIT[ja-JP-mac]="6b711b106c9fdeef3194b87046960b9954812d0b" # 2021-08-09
LANG_COMMIT[ka]="8d31bdc092ae660999ba09aeb97361657b1e3494" # 2021-08-10
LANG_COMMIT[kab]="9bdc79af6456914c5bb36736377b79cba4d4b447" # 2021-08-10
LANG_COMMIT[kk]="c5708971bb17e52c797e5a5c27caea34374bf13d" # 2021-08-05
LANG_COMMIT[km]="8171a05931b460fb3386cdf717487bbda9071877" # 2021-08-10
LANG_COMMIT[kn]="7cd0dbea0793f72e77f24955af4806a0dc5b692f" # 2021-07-23
LANG_COMMIT[ko]="4776ba272d30a9c1d0f6638d80a1112a834d8ba0" # 2021-08-10
LANG_COMMIT[lij]="44442dfd16c6463f030e72ebdd45cee9f5268755" # 2021-08-10
LANG_COMMIT[lt]="f7248c0b5ce64efd5d2dd08e2cee98cf4e5b11ef" # 2021-08-10
LANG_COMMIT[lv]="0f38de437c588becc649e2ab4ff1dffec1447246" # 2021-07-23
LANG_COMMIT[mk]="df9c9d12cbd7c3be1427327836b565f7219b1159" # 2021-07-23
LANG_COMMIT[mr]="9e2e3fd93cf7ac46ed842de32792e8a82db82a9c" # 2021-08-10
LANG_COMMIT[ms]="fd7a8d80caa94a3363ebc641b6c9e7a26a23d7e6" # 2021-07-23
LANG_COMMIT[my]="a0a697f6ddd334515c7994837ebfbb2a6f5bdf42" # 2021-08-05
LANG_COMMIT[nb-NO]="87707ea2299beb50b79593f2313d7ceda64a8069" # 2021-08-10
LANG_COMMIT[ne-NP]="04cb7df10a77bb618647b08e9c2c18393fa55e77" # 2021-07-23
LANG_COMMIT[nl]="acc1ef55e38fab2346d35fcf26bafc0b06c78eef" # 2021-08-10
LANG_COMMIT[nn-NO]="b7ade1720098262a56ff5fcdb7bde5d4ab14f50e" # 2021-08-07
LANG_COMMIT[oc]="cf6ef16d5317b3c317efabf8b859f14a6aa23d13" # 2021-08-10
LANG_COMMIT[pa-IN]="a564dd8e79676f4ac392940a4097b3519e8a79a5" # 2021-08-10
LANG_COMMIT[pl]="9040f38771ba2c7089eb6a1556710a9dffcb3003" # 2021-08-10
LANG_COMMIT[pt-BR]="c1664cadb76d571e98f6d509396aeaf4d01b104b" # 2021-08-10
LANG_COMMIT[pt-PT]="818e0040613215139f9f11a906aceec1946af04c" # 2021-08-10
LANG_COMMIT[rm]="cf799c85ee5365c05d259c71e3b7c08d79eebfa6" # 2021-08-10
LANG_COMMIT[ro]="cf1a5a5d14f80f63ea3beebd3bf96057061cc30f" # 2021-07-28
LANG_COMMIT[ru]="496708ac9afd9f27b56402259ed252ed090dc389" # 2021-08-10
LANG_COMMIT[si]="5b45c57f9e90bb2eabd80dba630c07a20fa06041" # 2021-07-23
LANG_COMMIT[sk]="e0863ee6f8982e0ac4d6db7dd59c257c92fa36b6" # 2021-08-06
LANG_COMMIT[sl]="bb991bc066d5d196e20197e4d4cc98f348bf4f27" # 2021-08-10
LANG_COMMIT[son]="b75cf4268b6081b1cfd1fad0d7710645e31f4a79" # 2021-07-23
LANG_COMMIT[sq]="1a8b669b9479e2c09a730537d6d10dd400070a33" # 2021-08-04
LANG_COMMIT[sr]="6a189ee16214d1e88ad39bafb034f3dfc9ca0177" # 2021-08-10
LANG_COMMIT[sv-SE]="10c07d7eaeb41914818c27e645cb92252f23026a" # 2021-08-05
LANG_COMMIT[ta]="53fceea5603e7dc75251f596bb23f437566348e9" # 2021-07-23
LANG_COMMIT[te]="7f7a8344a806202e01d0c2d9d3fadc74dc1a2a51" # 2021-08-10
LANG_COMMIT[th]="2e78917f43c690e9112ca3b340d9faf4f9342440" # 2021-08-10
LANG_COMMIT[tl]="cc6375276fa9c67dc822c39881e42805601e36c0" # 2021-08-10
LANG_COMMIT[tr]="2dca136a2f6a2b4c02e34a4dc387bb335b4e965f" # 2021-08-08
LANG_COMMIT[trs]="f78bea51bf3f8d8bf7520ddd207166c5708ac0c2" # 2021-08-10
LANG_COMMIT[uk]="e57d96caca8154202a96fd22890b70587a1f77a5" # 2021-08-05
LANG_COMMIT[ur]="ac8a79bb919d8827b51c5d8ba6a7a279a9a12c9c" # 2021-07-23
LANG_COMMIT[uz]="d92cadb694d3f1f13d395c601d83c485ff538939" # 2021-08-10
LANG_COMMIT[vi]="220e76cf636f7844d547dbaa05aa683b1246e36d" # 2021-08-10
LANG_COMMIT[xh]="ee4bf8f05b2b18c4073d48ca56f537e8aaa70f28" # 2021-07-23
LANG_COMMIT[zh-CN]="29b1b1f63bb22afe90f038006a8436699810b363" # 2021-08-05
LANG_COMMIT[zh-TW]="f2cbe5e9013fbd51305f567457ddccb9ca60bbfc" # 2021-08-10

fetch_l10n() {
	local lang
	for lang in "${MOZ_LANGS[@]}" ; do
		#en_US is handled internally
		if [[ ${lang} == en-US ]] ; then
			continue
		fi
		SRC_URI+=" https://hg.mozilla.org/l10n-central/${lang}/archive/${LANG_COMMIT[${lang}]}.zip -> icecat-lang-${lang}-${LANG_COMMIT[${lang}]}.zip"
	done
}
fetch_l10n

src_unpack() {
	unpack "makeicecat-${PV}.tar.gz"
	for langpack in $(cd "${DISTDIR}"; ls icecat-lang-*.zip); do
		unpack ${langpack}
	done
}

src_prepare() {
	default_src_prepare

	# Making sure that latest Mozilla public key is available for verying the firefox tarball
	gpg --import "${DISTDIR}/Mozilla_pgp_key-20210507.pgp" || die

	mkdir "${S}/output" || die
	cp "${DISTDIR}/firefox-${PV}esr.source.tar.xz" "${S}/output" || die
	cp "${DISTDIR}/firefox-${PV}esr.source.tar.xz.asc" "${S}/output" || die

	mkdir "${S}/output/l10n" || die
	for lang in ${MOZ_LANGS[@]}; do
		#en_US is handled internally
		if [[ ${lang} == en-US ]] ; then
			continue
		fi
		mv "${WORKDIR}/${lang}-${LANG_COMMIT[${lang}]}" "${S}/output/l10n/${lang}" || die
		mkdir -p "${S}/output/l10n/${lang}/browser/chrome/browser/preferences" || die
		touch "${S}/output/l10n/${lang}/browser/chrome/browser/preferences//advanced-scripts.dtd" || die
		rm -rf "${S}/output/l10n/${lang}/.hg*" || die
	done
}

src_compile() {
	if use buildtarball; then
		./makeicecat || die
	fi
}

src_install() {
	insinto "/usr/src/makeicecat-${PV}"
	doins -r "${S}/"{artwork,CHANGELOG,COPYING,data,makeicecat,README,tools}
	fperms +x "/usr/src/makeicecat-${PV}"/{makeicecat,tools/{AddonsScraper.py,buildbinaries,createdebsrcrepo,gnupload}}
	if use buildtarball; then
		insinto /usr/src/makeicecat-"${PV}"/output
		doins "${S}/output/icecat-${PV}-gnu1.tar.bz2"
	fi
}

pkg_postinst() {
	if ! use buildtarball; then
		einfo "You haven't enabled buildtarball, therefore you have to create the tarball yourself."
		einfo "You can create the tarball in /usr/share/makeicecat-${PV} by starting the script manually."
		einfo "   ./makeicecat"
		einfo "It will take a while so be prepared."
	fi
}
