# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="857afe0e546d0fb9bca6e2d2f79f0cbd44e6a5a3"

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
LANG_COMMIT[ach]="8312cd2e0777746cca7da89502bd806e57fff7e0" # 2021-10-01
LANG_COMMIT[af]="21bf766c19d81d560aeb7fea3923acaa160a4f0b" # 2021-10-01
LANG_COMMIT[an]="c91e34ccaf8343f416f4c52249afa701a3fc4e0a" # 2021-10-01
LANG_COMMIT[ar]="42f3680edfe201b6d213a43f16e90076c12575cd" # 2021-10-03
LANG_COMMIT[ast]="d3373fc001be92440ada4bae190ec4af6a2300e7" # 2021-10-01
LANG_COMMIT[az]="be787703be426084863fa169f3721d3f21bf2335" # 2021-10-01
LANG_COMMIT[be]="3fe84e343fd703c8d070046b8222b4ac11f0e6ef" # 2021-10-01
LANG_COMMIT[bg]="4436e1c3d290c13263ad6464c54a6c1b8befffb8" # 2021-10-03
LANG_COMMIT[bn]="f20b429471ec47552978b7001c0c65fb566418cb" # 2021-10-01
LANG_COMMIT[br]="248418a1d865f820d717cfa14e760c30d7d336a2" # 2021-10-03
LANG_COMMIT[bs]="70f9ff43a06cf2a6e1cc3c4dad840a69a6e0d800" # 2021-10-01
LANG_COMMIT[ca-valencia]="5dacbd6aa2753f02866c522417b4f76336baa417" # 2021-10-01
LANG_COMMIT[ca]="4596584e995fa1eb7f611bf042f5ac5e13d758af" # 2021-10-05
LANG_COMMIT[cak]="81d73d0a12afabeec3d39f1add9bab24a7c436aa" # 2021-10-03
LANG_COMMIT[cs]="fd8c8b5ac5b66def9618e4ece2954f39b966642a" # 2021-10-05
LANG_COMMIT[cy]="14d53846be47aff8aa6765451f36c3330c139c00" # 2021-10-04
LANG_COMMIT[da]="118bfa45d08b915e6b853989ac188f49748b1f3e" # 2021-10-05
LANG_COMMIT[de]="e496eeca7b765f9e58dc54b1d550b9be3f37af7c" # 2021-10-03
LANG_COMMIT[dsb]="5bf17bfbbf9ae5712c13be9b44c29aa2243add7c" # 2021-10-04
LANG_COMMIT[el]="ab73f8d595cb8e646b781e6fc15257e6ac6d1eb0" # 2021-10-04
LANG_COMMIT[en-CA]="e2d5eb3928793e669902a9faf8b53427cc7f95dc" # 2021-10-03
LANG_COMMIT[en-GB]="f90885ab866bb2cebf14841105cd0244467ed5a9" # 2021-10-05
LANG_COMMIT[eo]="c4cb6a9bc125e1fd7423d19cc21171f2d30d7272" # 2021-10-04
LANG_COMMIT[es-AR]="4fe02d66d516bc0bd0ac5152873dd2829e21a774" # 2021-10-05
LANG_COMMIT[es-CL]="bf23e13394b1b0e39170525f6049156c3df49a0e" # 2021-10-01
LANG_COMMIT[es-ES]="614939c10ef7e68c6f3def04d0af9007970de283" # 2021-10-03
LANG_COMMIT[es-MX]="4ee2cb1cf89078fe05d4eb24727ac7d4a1c978f1" # 2021-10-03
LANG_COMMIT[et]="b1624b7f7085e7433544ed953ab01247f3481342" # 2021-10-03
LANG_COMMIT[eu]="bfde431b8b6285456c04c363a53beb114a790625" # 2021-10-03
LANG_COMMIT[fa]="c0f593608d4dd35acee52fa0d6bd93e6b4c2e260" # 2021-10-01
LANG_COMMIT[ff]="0cf866f9bc4efcaf941823c89be7103d91c27634" # 2021-10-01
LANG_COMMIT[fi]="7d1dce04c52ed4be2e5fba6f5efe9e37a693a69e" # 2021-10-03
LANG_COMMIT[fr]="d7f91f8c4befcafb71ae72f3c6e4434ad305ad78" # 2021-10-05
LANG_COMMIT[fy-NL]="a914e958999a8c7d57775d1eac2365c94795038a" # 2021-10-03
LANG_COMMIT[ga-IE]="31590cffac566446b3654fad63d25b89cf39f8c0" # 2021-10-01
LANG_COMMIT[gd]="e40ff9002dd982a7c55bfe635cf62ffd6952066b" # 2021-10-03
LANG_COMMIT[gl]="6ac8f50fac1e258310aaa03eeb5c8d94eea27e91" # 2021-10-03
LANG_COMMIT[gn]="701a34dd549e2415194d17f55ecdc82b59925a30" # 2021-10-05
LANG_COMMIT[gu-IN]="33b4409fb6154d61d7abc626b8beebcbed54f783" # 2021-10-01
LANG_COMMIT[he]="d8f521622fac035373e75bf47a01393fc52b93ce" # 2021-10-04
LANG_COMMIT[hi-IN]="27d3ba3825edc4baca17a5ab63e5efdefeab93bb" # 2021-10-01
LANG_COMMIT[hr]="b9d5f15ed366ea8394972d8c7c0ec3ae5e704088" # 2021-10-03
LANG_COMMIT[hsb]="333bbe4dafe92466515d2e90511742d4589c4f4b" # 2021-10-04
LANG_COMMIT[hu]="3513b720b5bf3dacd7da65386737c1f82b347326" # 2021-10-03
LANG_COMMIT[hy-AM]="f40443b25b7c26468459ca52fa36ded9d03d114f" # 2021-10-04
LANG_COMMIT[ia]="e591eac59604f1a2c141b94c15c48b4f2aff40f7" # 2021-10-05
LANG_COMMIT[id]="030b5b0089de5e62ab6c2c92f2e94e283d61113b" # 2021-10-05
LANG_COMMIT[is]="4e6b5190ba26aa8485b60306815f358d9977022a" # 2021-10-01
LANG_COMMIT[it]="26ee42039c45cbc2706f0243c81e30fa923e4207" # 2021-10-05
LANG_COMMIT[ja]="3198191b6de12b581f1489340c15ace82603ba9a" # 2021-10-03
LANG_COMMIT[ja-JP-mac]="8b8190acd637c363264d88c02fd3a4a33aa0220b" # 2021-10-03
LANG_COMMIT[ka]="2c6dd2ff44444353e66a855abdb317c5d36556f9" # 2021-10-03
LANG_COMMIT[kab]="370b5cf40b121eb4a8b17175b20d4fa28c444f2d" # 2021-10-03
LANG_COMMIT[kk]="24bf362bc76f87052792054741399cc4b101b201" # 2021-10-03
LANG_COMMIT[km]="a08a8f41d9e335188c7e0e0caafdf603ab979225" # 2021-10-01
LANG_COMMIT[kn]="6ed122b33cacbdeb27068b19e86b3ca7fba642b6" # 2021-10-01
LANG_COMMIT[ko]="8572ee639b483312f32a5fba549775284544942f" # 2021-10-05
LANG_COMMIT[lij]="314f068a8922444a21dfeeeeef5f8708790df9c3" # 2021-10-01
LANG_COMMIT[lt]="6a6d86ed7ce686f340e598eade417d2397e83ee0" # 2021-10-03
LANG_COMMIT[lv]="daea4ba4e7f4c8bd90009f47f2f129c9f1a32a4c" # 2021-10-03
LANG_COMMIT[mk]="0c4ca0f4fc179488beeb99fadee5099a67f66bd1" # 2021-10-01
LANG_COMMIT[mr]="118a952d786a12febdfe86ac5aefc83dd8b677d9" # 2021-10-01
LANG_COMMIT[ms]="0f44d0bcfda2db6f2d90c77bae46a55554edea27" # 2021-10-01
LANG_COMMIT[my]="ccbf0c4355d6a7d35ff28c6284a6ccd2c3ec6d06" # 2021-10-01
LANG_COMMIT[nb-NO]="15a6162c3f0189377caee1ac6893dbb39703a08b" # 2021-10-04
LANG_COMMIT[ne-NP]="c1636a1a7507710a736e6ffe4faf18ea92f45c9a" # 2021-10-01
LANG_COMMIT[nl]="c3bbc2ac80ad6a6362101c30bc7431111d400881" # 2021-10-03
LANG_COMMIT[nn-NO]="dbd0dcf563a2569aba72cb9dce7213c3302f5890" # 2021-10-05
LANG_COMMIT[oc]="c9b7868426b9bffdf305237384d0e69f870f21cd" # 2021-10-04
LANG_COMMIT[pa-IN]="83c1cd67bfdf2ffcd1276788cb1bbcccd6928b01" # 2021-10-01
LANG_COMMIT[pl]="8c67189172a7bec81ac8cc5d59586a2bcabc66a6" # 2021-10-03
LANG_COMMIT[pt-BR]="cf0ca65f5a898f654bc0b3352e6b1369a9457594" # 2021-10-05
LANG_COMMIT[pt-PT]="d7bb76ea2f7a55b903641880c7512c97c0f242cf" # 2021-10-05
LANG_COMMIT[rm]="60f49a02522c7513a6695341c49bd70bf2f9384e" # 2021-10-03
LANG_COMMIT[ro]="49055f0301f6a690d559fac6ada75a54a7ae378f" # 2021-10-03
LANG_COMMIT[ru]="e956377de7c444491e7732d2ca865306d900afda" # 2021-10-04
LANG_COMMIT[si]="2b134d24c0464fbf2b5fd323df0e32cadc13f424" # 2021-10-01
LANG_COMMIT[sk]="fbd9f922ac747dc9b242e1f27fe2d93beb430269" # 2021-10-04
LANG_COMMIT[sl]="e15d9733574a454431a6e92ca8b433d9f580b05a" # 2021-10-03
LANG_COMMIT[son]="60a3b235fe1df2316e7c039ef7c22fbe67545a85" # 2021-10-01
LANG_COMMIT[sq]="f15a32e6e6b5bfdbd09f86df36e959b1e8856f82" # 2021-10-03
LANG_COMMIT[sr]="1d61629732d5cd34e81b63a3ca8586d401a97930" # 2021-10-03
LANG_COMMIT[sv-SE]="5d0347d7b4d5137c50ed61c7833d9b2453f676e4" # 2021-10-04
LANG_COMMIT[ta]="94659c83c9d820384aa4d505d5777571c4caecd6" # 2021-10-01
LANG_COMMIT[te]="feb850d727b2b69608b01a38e4b14b58d361ddca" # 2021-10-01
LANG_COMMIT[th]="02d33e4a3c0ec2ae03878e947dda43aba5efd345" # 2021-10-03
LANG_COMMIT[tl]="9dbfa8cbb8a295248bc9163c3a40a21a423ed9ab" # 2021-10-01
LANG_COMMIT[tr]="743b9242ca41d809395eaccf38e1cecd555b097d" # 2021-10-05
LANG_COMMIT[trs]="c3bdacd8a47344a12253ea12738605e16eae0833" # 2021-10-01
LANG_COMMIT[uk]="dea604292d7d445bea10cd39b95554af5e823df9" # 2021-10-04
LANG_COMMIT[ur]="483aa9c4b69dbcadba55e20202bb1643e3e23079" # 2021-10-01
LANG_COMMIT[uz]="2ffa37e9038d5a0915ac9dbcf5b32dabbd7a831c" # 2021-10-01
LANG_COMMIT[vi]="38fa62eab974a6c59181d8c85d7c94d94c1a4cd2" # 2021-10-04
LANG_COMMIT[xh]="abc22dfb6d84aa2658b0af6bfb9df4a5c2eeb6d4" # 2021-10-01
LANG_COMMIT[zh-CN]="c2b62a8535ba7e92401e1657f41d2e064b05f4f4" # 2021-10-04
LANG_COMMIT[zh-TW]="19eb84f11577a995661e2d083f20bc3e7fc71212" # 2021-10-04

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
