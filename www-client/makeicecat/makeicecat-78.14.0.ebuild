# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="799c5ee63c4d65add90ff55f4948562e31a7be1a"

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
LANG_COMMIT[ach]="072c63b5bb9efa375ce77c49a16fb6afb8a4301a" # 2021-09-08
LANG_COMMIT[af]="512f965113d5eeaf79b96209d45fbfbaefc5a52e" # 2021-09-08
LANG_COMMIT[an]="156fa65dba7ed4a8e1e1547aa1007f684794633d" # 2021-09-08
LANG_COMMIT[ar]="7323579abad351707e65c58253b04a15acf26fd3" # 2021-09-08
LANG_COMMIT[ast]="8119ed77a93fbab4447bcac1d3cce18f18d76b89" # 2021-09-08
LANG_COMMIT[az]="635dfda27f79f7394a50ba0ce19084c695d32652" # 2021-09-08
LANG_COMMIT[be]="83a25de965c12c5378c8e82daf8910cd8c90c33c" # 2021-09-08
LANG_COMMIT[bg]="305998490eeddf8db403c96c057857577717dd9f" # 2021-09-08
LANG_COMMIT[bn]="d15020efe875fbe5403db8df5a7f4197bcc5a773" # 2021-09-08
LANG_COMMIT[br]="474211dd29c8748a5c965feccaea0ec994a49372" # 2021-09-08
LANG_COMMIT[bs]="a76b883b3818fca0644a297eb21c551fd3cb6b4b" # 2021-09-08
LANG_COMMIT[ca-valencia]="2d31943d740a34c34037e136871eda659781a59a" # 2021-09-08
LANG_COMMIT[ca]="95a9c5d3430533f40854a877f035e2b349f5c04d" # 2021-09-08
LANG_COMMIT[cak]="4c50aebb54b2cbb691c47029045281ba00b64ced" # 2021-09-08
LANG_COMMIT[cs]="f00e8d3078be5b5d8a350430a390387ae8481753" # 2021-09-08
LANG_COMMIT[cy]="e91f4fd258a32c1a02a5e64d234822568ff1d7d7" # 2021-09-08
LANG_COMMIT[da]="8a03c216446c591b013312b1c49dfbc87f17d327" # 2021-09-08
LANG_COMMIT[de]="5a98acd1c103b451a85080c4bd504e33987c73e5" # 2021-09-09
LANG_COMMIT[dsb]="0c19c7a75d053861f0d8dfb8e499cd2f4a7d9b07" # 2021-09-09
LANG_COMMIT[el]="2aa0f71c1bddaeb0e855b1439937fb6606f2d96b" # 2021-09-09
LANG_COMMIT[en-CA]="c45333a0f4c48487c8915826819a761a0863a648" # 2021-09-08
LANG_COMMIT[en-GB]="74ffa94105bf675865e96160ed4d1a46d59613be" # 2021-09-08
LANG_COMMIT[eo]="3ba55cf79a61ac25878309c334de6c204e093897" # 2021-09-08
LANG_COMMIT[es-AR]="3dad7d3bbcd91d671e53e32fc29bd9920eed86c9" # 2021-09-09
LANG_COMMIT[es-CL]="b5e76b2fcc68c2c014e4837b812fc089500f38dc" # 2021-09-08
LANG_COMMIT[es-ES]="b6962cd44c76b96b73f858695e7c4b109c13ef7d" # 2021-09-08
LANG_COMMIT[es-MX]="d7ccc49ce237b32d6665b46a6cf91ee93e949e71" # 2021-09-08
LANG_COMMIT[et]="b50aba0952cc20bd00d26ea7df9880081c43774c" # 2021-09-08
LANG_COMMIT[eu]="8434ec3df9f32c84422249bdf2981e1fc887c190" # 2021-09-09
LANG_COMMIT[fa]="16ef6648fc1927831a9153c7afabd0a5c189012f" # 2021-09-08
LANG_COMMIT[ff]="75b0d1f51e1ead855721b4b5c6ff42969e9a6d68" # 2021-09-08
LANG_COMMIT[fi]="ab1574e245b1ac6abd10493fff623a3c1e3f1aad" # 2021-09-08
LANG_COMMIT[fr]="31ac713e4fd9beec76c6faf0b73e7474c92463eb" # 2021-09-08
LANG_COMMIT[fy-NL]="871147c302c1d06efc9aca733ed162910d5fa0e1" # 2021-09-08
LANG_COMMIT[ga-IE]="6087034475da0e7c6981c50d19757a0cceea3ec8" # 2021-09-08
LANG_COMMIT[gd]="fbfeacd4f85341eeb5367e6f7b81d45cccfcbb2d" # 2021-09-08
LANG_COMMIT[gl]="6d1d923547a62fe8d9b4f64bacf9d379490e0665" # 2021-09-08
LANG_COMMIT[gn]="9ded506a28d4568146bbed708b8aaaa2ca1f0bf0" # 2021-09-08
LANG_COMMIT[gu-IN]="4b467f359502755f3aeb4b2860f9be2a4be0ddef" # 2021-09-08
LANG_COMMIT[he]="e81129a06261c0c9ae2c459b2fb8c4ab0bf732d5" # 2021-09-08
LANG_COMMIT[hi-IN]="00dcaa14216109c41247a7a23ee7349653fed9d2" # 2021-09-08
LANG_COMMIT[hr]="58e74618a5c18061e18b76cbb2cd62330edd46c5" # 2021-09-08
LANG_COMMIT[hsb]="486aed145232f1e9e7294ea5bbd501391e1343e4" # 2021-09-09
LANG_COMMIT[hu]="1fd9f5cefba501a055678b6dba7f9e6937f6abf2" # 2021-09-08
LANG_COMMIT[hy-AM]="7210716c1c02f68119d83835880907a64180f220" # 2021-09-08
LANG_COMMIT[ia]="a582fdabd822418ef2c554a1f1b6bf0fb0c2f64d" # 2021-09-08
LANG_COMMIT[id]="189addd2d39432d31a86785c4f8b593967021f35" # 2021-09-08
LANG_COMMIT[is]="3f22680e432fb8893d2150a87e8144708dbd25ed" # 2021-09-08
LANG_COMMIT[it]="14ba7df80f392ba91db821192c01db607bc38ede" # 2021-09-09
LANG_COMMIT[ja]="114c4fbfe9640ed01d716606577d482bf562d7f3" # 2021-09-08
LANG_COMMIT[ja-JP-mac]="ab0650ac7bb578d12dfe3647fea6aa2edd8074a8" # 2021-09-08
LANG_COMMIT[ka]="f6913041dee871ba05292a99d34f7777df52a900" # 2021-09-08
LANG_COMMIT[kab]="b76ae4dd101c0d13ccc6c94dbdecf5890d2a59bd" # 2021-09-08
LANG_COMMIT[kk]="8a1f2ce71058898929905f4df141f2b101a40458" # 2021-09-09
LANG_COMMIT[km]="5fcab0442378508e1e49a90cb989525093dc79bb" # 2021-09-08
LANG_COMMIT[kn]="4ba4d0cf753c3902775d35ec63e0bf2f7f7b7257" # 2021-09-08
LANG_COMMIT[ko]="21c0533a5f35cb8a242aa6a2fa54e25ef5d60250" # 2021-09-08
LANG_COMMIT[lij]="fcdcae3869bba48ffd78d9fde24b7fe602dc3777" # 2021-09-08
LANG_COMMIT[lt]="a30e947962e9bc6a1e49827b0ce65799d33dce49" # 2021-09-08
LANG_COMMIT[lv]="9d868f97c37b7211ca5a9afe5c5781e08051e1de" # 2021-09-08
LANG_COMMIT[mk]="300bbf5c5b290ec02d512ef0f38d17fe30d7b811" # 2021-09-08
LANG_COMMIT[mr]="0afcbc39dad7eff1d54c363f8c58b451d2968ae7" # 2021-09-08
LANG_COMMIT[ms]="5b11c9c6b2a151d824f23d462dc5e5917ec70293" # 2021-09-08
LANG_COMMIT[my]="114a4478406658670d93eef328b78035809d8a31" # 2021-09-08
LANG_COMMIT[nb-NO]="9e163e97e6479fcf225152b557428fab6856afe0" # 2021-09-08
LANG_COMMIT[ne-NP]="b7ea4e96132a360ed30f49e918635ddeae035a79" # 2021-09-08
LANG_COMMIT[nl]="419d24b8dc9298c2ecb8076c34e64091b697274e" # 2021-09-09
LANG_COMMIT[nn-NO]="d8632e9c7309432bccbf9daf90c9013d69d5dae0" # 2021-09-09
LANG_COMMIT[oc]="1cafc73c7b603ab03eb092b28d582cd979149d77" # 2021-09-08
LANG_COMMIT[pa-IN]="c62b2facf964a83f2028d86e71a4fcb5059b4446" # 2021-09-08
LANG_COMMIT[pl]="fc7f79f7b7fd2938b7000df29efacc8615ec275b" # 2021-09-08
LANG_COMMIT[pt-BR]="ef63bd5ee668f5e540fde0453bb6c4919de75fdf" # 2021-09-08
LANG_COMMIT[pt-PT]="7fb7a9197398f5748f7c578145d3f904f0de72d6" # 2021-09-08
LANG_COMMIT[rm]="67a0673d1ce5c242c6d627f29c898ae5586a0b4a" # 2021-09-08
LANG_COMMIT[ro]="476cf83721ed52383810db391ff6e84e2397b6ac" # 2021-09-08
LANG_COMMIT[ru]="9615cab55c8b3685e0d7275653b9b729eb3158de" # 2021-09-08
LANG_COMMIT[si]="a390275af25c5888f4deb9f7718fb7bb0ec824f6" # 2021-09-08
LANG_COMMIT[sk]="f5f1bfc4a2668300bf27a000dfcfc6ce1578f68a" # 2021-09-08
LANG_COMMIT[sl]="3527d10a73c855ade335a3577f605e535acbc138" # 2021-09-08
LANG_COMMIT[son]="760b15cfdcffd8f0a60f561b62abf12fbe2e9f6a" # 2021-09-08
LANG_COMMIT[sq]="cb05b1f4962ae7ff5c5a8e0208a1558114aca999" # 2021-09-08
LANG_COMMIT[sr]="989e92e116ec45e8ebf4e8d46964613e8b4894e3" # 2021-09-08
LANG_COMMIT[sv-SE]="911d0a44f15377155dfddfd9e2d76b4ce7842460" # 2021-09-09
LANG_COMMIT[ta]="2a896aa80edc2a14888a5c9613e7e3768c3ed986" # 2021-09-08
LANG_COMMIT[te]="47b6a334701f80f7a7bfa5fbdde84b680edd158a" # 2021-09-08
LANG_COMMIT[th]="2d02f05e68a8a2c14bbb95449be2ad99a5e178b9" # 2021-09-08
LANG_COMMIT[tl]="d912ce707cbefb159a4ae941ad586a6af4cf3d0d" # 2021-09-08
LANG_COMMIT[tr]="dad0c71a83805e32d4da8c9023840a6b484bf873" # 2021-09-08
LANG_COMMIT[trs]="166448ef28c1ea6746137f4fe7a03233c57d3dc4" # 2021-09-08
LANG_COMMIT[uk]="72caeed978394cbeb8376eaadfb0bd8e4874033b" # 2021-09-08
LANG_COMMIT[ur]="61aeb8c7666cd777f202100db3b35aeea0232055" # 2021-09-08
LANG_COMMIT[uz]="29c5b99cf9417d78a421f45812d46fc4e7309444" # 2021-09-08
LANG_COMMIT[vi]="f1a33912a7a18a062f9c701a01d5cf3e41b367ba" # 2021-09-08
LANG_COMMIT[xh]="2f4531df290c504b2ef9c7aae1f264d98dea0798" # 2021-09-08
LANG_COMMIT[zh-CN]="8407492b978edf36285838ce53291f2a6e4513c1" # 2021-09-09
LANG_COMMIT[zh-TW]="45b4d2f85b399c52aa2e0cde29806c63ce4e9e1a" # 2021-09-08

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
