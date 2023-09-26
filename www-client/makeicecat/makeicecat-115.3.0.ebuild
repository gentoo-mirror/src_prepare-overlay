# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="497cdf100f405204a22f5de96f142b9d040697e8"
COMPARE_LOCALES_PV="9.0.1"
SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz
	https://archive.mozilla.org/pub/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz
	https://github.com/mozilla/compare-locales/archive/refs/tags/RELEASE_${COMPARE_LOCALES_PV//./_}.tar.gz
		-> compare-locales-${COMPARE_LOCALES_PV}.tar.gz
"

LICENSE="GPL-3"
SLOT="${PV}"
KEYWORDS="~amd64"

RESTRICT="test"

IUSE="+buildtarball"

RDEPEND="${BDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	app-arch/unzip
	app-crypt/gnupg
	dev-vcs/mercurial
	$(python_gen_any_dep '
		dev-python/jsonschema[${PYTHON_USEDEP}]
	')
"

S="${WORKDIR}/gnuzilla-${COMMIT}"

declare -A LANG_COMMIT
LANG_COMMIT[ace]="844c9b53019ae24904a75347fee1faa1bf7ebdef"			# 2023-08-05
LANG_COMMIT[ach]="2a5ebc36d1c6ef1b4f277b4414f5043a20480ed5"			# 2023-09-06
LANG_COMMIT[af]="05038f7f1f36ff6713eb849d8cfd6753b8ea6d94"			# 2023-08-31
LANG_COMMIT[ak]="035ea4b91a765342ec3d37b5ecb8f89ae8342887"			# 2023-08-31
LANG_COMMIT[an]="39a7aadbe5838d0ed26fe73ee65ad0301182337d"			# 2023-09-06
LANG_COMMIT[ar]="98c215b606899ecf0050e25700db869bd60ceb2e"			# 2023-09-06
LANG_COMMIT[as]="94534f1f6b8f625b80d7a536a0e1da1f7774b0ca"			# 2023-09-06
LANG_COMMIT[ast]="26cba132da7ef17b6b2b7a47a20fa726c6feb6f5"			# 2023-09-06
LANG_COMMIT[az]="6f019af65d763726553e4671e224a024b2389970"			# 2023-09-06
LANG_COMMIT[be]="ab9c939520577b213f45ad5f9eb9a8851e379029"			# 2023-09-24
LANG_COMMIT[bg]="e8e9d89ae32868098b66d0ba81331d7893fc2cd5"			# 2023-09-06
LANG_COMMIT[bn]="b42b4746503e65d817f5cb5005e07b2c503a5984"			# 2023-09-06
LANG_COMMIT[bn-BD]="afcbee6a0c316e31e46d960fa4eeb410125f820d"		# 2023-08-31
LANG_COMMIT[bn-IN]="5bb3623ed4036acd76b1a55058113bbf62bb3303"		# 2023-08-31
LANG_COMMIT[bo]="42f95ae54a242d1a49621d4786224af77cdca739"			# 2023-08-05
LANG_COMMIT[br]="19b13cb7767c0c114fe03b8f3be1ecfaddc26826"			# 2023-09-15
LANG_COMMIT[brx]="4f6b12102e7b1fc9770740db17adbb742c1dbced"			# 2023-09-06
LANG_COMMIT[bs]="f70bbfdc3a339a4cd4f5a7aa4b8d4983f042e6f4"			# 2023-09-06
LANG_COMMIT[ca]="4177166e7288b29466a6aa32fb0590e6cf7530dd"			# 2023-09-06
LANG_COMMIT[ca-valencia]="1556baca9d3d8891c0307dde4d8db8655f191199"	# 2023-09-06
LANG_COMMIT[cak]="07a4757b132640988749c86c8500d9eea021f7e9"			# 2023-09-06
LANG_COMMIT[ckb]="608b6673c08432e9f3cb603c25f850d8b3c902dd"			# 2023-08-31
LANG_COMMIT[crh]="9d310a0f7338f832a08051d44330f38281d83306"			# 2023-09-06
LANG_COMMIT[cs]="6743ea0eb3d4ce8d53545f35bec6d61cd862ce87"			# 2023-09-23
LANG_COMMIT[csb]="39b9f449fc716b8566f694b0f76a415246571411"			# 2023-08-31
LANG_COMMIT[cy]="c36dde60b96ae3b3b929d75dff167e1d8c0151a0"			# 2023-09-20
LANG_COMMIT[da]="c3dba3ea996b745c42fd0477d60d7d277bcc17de"			# 2023-09-15
LANG_COMMIT[de]="30ab70115f605023f1fac297f6fbfaf7d271ebd0"			# 2023-09-14
LANG_COMMIT[dsb]="f49b08f8c9e39371fce2c557bf001d5e41c2d65e"			# 2023-09-22
LANG_COMMIT[el]="0c42505dbbe519a84ffa28fde891dedc5b73a710"			# 2023-09-24
LANG_COMMIT[en-CA]="904f939676f6f75ad166afeb9ad49dc32e291399"		# 2023-09-21
LANG_COMMIT[en-GB]="29dfc476151674d7daa95f1903ca96f8bb01c42d"		# 2023-09-23
LANG_COMMIT[en-ZA]="f6d943566bf79984745d996f46b4622bb72cd1b3"		# 2023-08-31
LANG_COMMIT[eo]="bd16a6804fa072389ce47e57a4007254ad127bdc"			# 2023-09-06
LANG_COMMIT[es-AR]="b677ac6f42036b25923707d20a5cd829059a8467"		# 2023-09-24
LANG_COMMIT[es-CL]="f725c57932e8ef56472de6635dfa917aa6d30fce"		# 2023-09-24
LANG_COMMIT[es-ES]="f65dc867d3af67a86cfea2a7a2a6a009c636f4b4"		# 2023-09-21
LANG_COMMIT[es-MX]="458e7d690c3b96a81e5036d185d7186c1c3a4732"		# 2023-09-06
LANG_COMMIT[et]="7a85e6dce1b3d1f0b85af37afcfa285f5b04f05f"			# 2023-09-06
LANG_COMMIT[eu]="e587495746d2073fdaa63944907885e52552a197"			# 2023-09-23
LANG_COMMIT[fa]="45c0d6ece4ecc6bbbd0af26a1b364f8e668ff45d"			# 2023-09-06
LANG_COMMIT[ff]="18eab110853900e3bc698e9e0273c2dae03c0c43"			# 2023-09-06
LANG_COMMIT[fi]="7f4d3de8051d7b104006503e4a5b0b235ef10327"			# 2023-09-17
LANG_COMMIT[fr]="89be36ebfe42abf397593b9751de453e74e0c98a"			# 2023-09-20
LANG_COMMIT[frp]="3c5b9926ffb44324a4b5f33225870b778032a37d"			# 2023-08-05
LANG_COMMIT[fur]="5404d490d1217eb992f290d3c80a97eacc8378aa"			# 2023-09-26
LANG_COMMIT[fy-NL]="61c85a7dd2ce3f19426a609ea2a43d985979a080"		# 2023-09-25
LANG_COMMIT[ga-IE]="87dcf2b09a5c652e1f6364bc8a94eace943b0efa"		# 2023-09-06
LANG_COMMIT[gd]="0ae0fd750f053cd778a51f307ea9f3f951a56fbb"			# 2023-09-06
LANG_COMMIT[gl]="0b286482070b6d5fdccdd26f1368a2e0afe3301f"			# 2023-09-24
LANG_COMMIT[gn]="2f9c4460d583faf79491fae29593069d7f61632b"			# 2023-09-25
LANG_COMMIT[gu-IN]="7b7a4ffeee73f469715776f4d87ccbae97880a22"		# 2023-09-06
LANG_COMMIT[gv]="025c6cac9fe0191b1713087655945a0554d3a69f"			# 2023-07-06
LANG_COMMIT[he]="2fd25a0bc99c9046bd912c0dae7099a4f2eff759"			# 2023-09-22
LANG_COMMIT[hi-IN]="5a9274a792e2665c26525956e6400081e8236ca8"		# 2023-09-06
LANG_COMMIT[hr]="b6df628b327b411ac688769c83a97d4054da0120"			# 2023-09-25
LANG_COMMIT[hsb]="3f5803abcfee7ba40a7dc05a56988c0f1bb87411"			# 2023-09-22
LANG_COMMIT[hto]="c576818ee3fedf88bf91ea07b66d47951c5d0701"			# 2023-08-31
LANG_COMMIT[hu]="1132209a0944acb7eee92bb3dc3a2a703954e006"			# 2023-09-22
LANG_COMMIT[hy-AM]="d58fa3e2fd36551a282a8d3aee4807f2e8a31e36"		# 2023-09-12
LANG_COMMIT[hye]="bb9ebb17b2dd7c8b704da6c70ebe5a50ac06a49d"			# 2023-09-06
LANG_COMMIT[ia]="34d6719d2d1f51bc0a6ecadb26a2b813ac23568d"			# 2023-09-24
LANG_COMMIT[id]="86c64bfeba87b62738b65e0290da2fd10b9bc53f"			# 2023-09-06
LANG_COMMIT[ilo]="32cb92f75a596d0092c463cdeee23a8b7a986820"			# 2023-08-31
LANG_COMMIT[is]="f6031ede80e0c9b22c9515675c316ce2afe2c731"			# 2023-09-22
LANG_COMMIT[it]="bcc7a68829ef49dacad6308bfb8a2ee3e9b7cd97"			# 2023-09-26
LANG_COMMIT[ixl]="e5b63add34abe54310145bcc92c521cd2facaa51"			# 2023-08-05
LANG_COMMIT[ja]="d9cc3d615b708a490489f9d8400a0a2e962cf03d"			# 2023-09-14
LANG_COMMIT[ja-JP-mac]="26f42ba45ee60a1eaa0211ca534e9b0b911f7005"	# 2023-09-14
LANG_COMMIT[ka]="fe26223714706f6dbd1045a904ce8e7159c688ac"			# 2023-09-24
LANG_COMMIT[kab]="8473c7df4f7837f39f620528a694f839aa65f5de"			# 2023-09-10
LANG_COMMIT[kk]="4850675ad1c29608171dcac6cc59836fded9a1c6"			# 2023-09-24
LANG_COMMIT[km]="32cdc60bd84b8bb6249145e70b5c8fdcb39ac99c"			# 2023-09-06
LANG_COMMIT[kn]="21e68a00b723aa2c3cb8ea311de84ce9ecf06cd4"			# 2023-09-06
LANG_COMMIT[ko]="edd8eb252b52c1859a607faf1208873c97599d14"			# 2023-09-25
LANG_COMMIT[kok]="03d30f64e3129773b19bdcbfa1221fee291eacb0"			# 2023-08-31
LANG_COMMIT[ks]="1c0d2d21690e34ddda3ac38936afea1114810c29"			# 2023-08-31
LANG_COMMIT[ku]="28f3f434402c56a2f88b4b2394b0e78fe64777ec"			# 2023-08-31
LANG_COMMIT[lb]="41d29f28adcf308a4cf53496c83d52abc3479cd3"			# 2023-08-05
LANG_COMMIT[lg]="3359cb1deca24ec873ee035096c78c3e49a9b706"			# 2023-08-31
LANG_COMMIT[lij]="ef6019dc82cef503686f300189811b3c3eada958"			# 2023-09-21
LANG_COMMIT[lo]="002de402fff676c356d477174998d5d88e91733f"			# 2023-09-06
LANG_COMMIT[lt]="d77d857bb45cc2c736882897787d6978f4e254a2"			# 2023-09-06
LANG_COMMIT[ltg]="18c348aaaef82ad9ec6909e4179d5536a81c88d6"			# 2023-09-06
LANG_COMMIT[lv]="4b9764ab19238981cb23f350fa359f83aeceaf11"			# 2023-09-06
LANG_COMMIT[mai]="92503138ae7d2d0168d3a38aa2a81a8c4f832e37"			# 2023-09-06
LANG_COMMIT[meh]="637916d1125f97df170c4b036d99326778398a69"			# 2023-08-05
LANG_COMMIT[mix]="029f864e4d638d25f3896424fa918400f6ecfd68"			# 2023-08-05
LANG_COMMIT[mk]="2c5f0467143b861ee8af5062e0799598517f7e63"			# 2023-09-06
LANG_COMMIT[ml]="c4f2be9c93b28aa46f130c948f262affcfeb603c"			# 2023-09-06
LANG_COMMIT[mn]="ed7446396111ce4dcc3b26281e96bf51b9d29b1e"			# 2023-08-31
LANG_COMMIT[mr]="99c8d3c26fcda74f6794d6ab1364e84f6a49ad26"			# 2023-09-06
LANG_COMMIT[ms]="41c914afd75d0ae556ce79e6093c362ce9e20eba"			# 2023-09-06
LANG_COMMIT[my]="92272ec0b76c784be3491ce380f993e8e0b92759"			# 2023-09-06
LANG_COMMIT[nb-NO]="e55a2b6f39401094fe5dda8425e6dd3c423b20b2"		# 2023-09-23
LANG_COMMIT[ne-NP]="08dafca366c75df8c665b0689c4082eee1bb969e"		# 2023-09-06
LANG_COMMIT[nl]="f68432bad4ad33ca71d355cc18fe8f9ce666cd8d"			# 2023-09-25
LANG_COMMIT[nn-NO]="cb663dfd8eff6a37e7792696eec1fcab238aec38"		# 2023-09-20
LANG_COMMIT[nr]="573a9aa6c19c5e2e9937d7a0f537d8dbecc354d7"			# 2023-08-05
LANG_COMMIT[nso]="937d05cb2d65b745277abdaa082a76ebf53daf82"			# 2023-08-31
LANG_COMMIT[ny]="a582f27b50425c1658edb438616cc15349bffe12"			# 2023-08-05
LANG_COMMIT[oc]="4284531fcaa6c741e9e28229ad46b9d7e792460a"			# 2023-09-24
LANG_COMMIT[or]="4c3e242ba7298c0e5d31711067267562abcb56be"			# 2023-08-31
LANG_COMMIT[pa-IN]="3bc68857a78b38731e46d83083a6ce013a9b56e3"		# 2023-09-17
LANG_COMMIT[pai]="49fd654beb254c472f5785d6cffcbccf6970100f"			# 2023-08-05
LANG_COMMIT[pbb]="5aee05c05a1a54bdd9dee291e47e8217bb484c13"			# 2023-08-31
LANG_COMMIT[pl]="b772a36abe5365ce39fcf6fce5ca1507f0abaa13"			# 2023-09-17
LANG_COMMIT[pt-BR]="680c9011295c08efd9dc8804b6af582bb520810a"		# 2023-09-21
LANG_COMMIT[pt-PT]="8665f03a6ab2da44b4beb2c7b3a1007e0591f66b"		# 2023-09-21
LANG_COMMIT[rm]="95eaad9cff89b06be92c94877bf19839e746c2a5"			# 2023-09-18
LANG_COMMIT[ro]="aa329657a0e5bc5ccb8fc0102ca3813f0a06d66d"			# 2023-09-06
LANG_COMMIT[ru]="c951eb8346aa8502677317c5960ded15cf35cc6d"			# 2023-09-24
LANG_COMMIT[rw]="6334f98efbcc81e44963ad5d18012437e1c4d843"			# 2023-08-05
LANG_COMMIT[sah]="1a15a2d771a38dd90c2b75642c9145ed73367223"			# 2023-08-31
LANG_COMMIT[sat]="83ac6313436e257405881969f6ed756003336189"			# 2023-09-24
LANG_COMMIT[sc]="333d6c6d8abbaa7668bedbf9cb825c10eff39751"			# 2023-09-12
LANG_COMMIT[scn]="ce5ef15662bb449b0153a4ff1e662c4a7819f3cb"			# 2023-08-31
LANG_COMMIT[sco]="43c2ef80d5f64f49216b794835fb7214908751ea"			# 2023-09-06
LANG_COMMIT[si]="1d39be2477d233d4642860f492f014c3ef19d641"			# 2023-09-25
LANG_COMMIT[sk]="bf5f3e2112ef45a59b0eafa9d3390ac3c1b7eeb1"			# 2023-09-25
LANG_COMMIT[sl]="b21f57200a9bd4c99730652e506b3addf89e4dab"			# 2023-09-25
LANG_COMMIT[son]="4f79674b0eed472b22b30ae969181c8d31730a15"			# 2023-09-06
LANG_COMMIT[sq]="42a2baa9db5788bd4fc81c3d939c6995e3fa0529"			# 2023-09-06
LANG_COMMIT[sr]="bf74acf8a48f0011d4a3d7d1b68bfa84ab1b64b4"			# 2023-09-06
LANG_COMMIT[ss]="bec601c8a508d164142f9ae085ae2aba16904bab"			# 2023-08-05
LANG_COMMIT[st]="482adc426c35bac5a6331ef80f5d5b7463ce5996"			# 2023-08-05
LANG_COMMIT[sv-SE]="c38f9e9b79765aaca8cc3ff157536357d4d16166"		# 2023-09-23
LANG_COMMIT[sw]="9982a17775b727260a02c7da10824da2096c551b"			# 2023-08-31
LANG_COMMIT[szl]="9db3322fc9139612f81c2bbd3237385c5f654129"			# 2023-09-06
LANG_COMMIT[ta]="22996f0cf56166d62bb14cafea1f31aba07ab9a6"			# 2023-09-06
LANG_COMMIT[ta-LK]="ac7ce62f1f0bf551114afaf491214679a09553e4"		# 2023-08-05
LANG_COMMIT[te]="a17442b473a1773bd68003fc3cc1e129f5312113"			# 2023-09-18
LANG_COMMIT[tg]="9aceaf4373b1e2e161d8aba0bd40f69f5756f6d6"			# 2023-09-24
LANG_COMMIT[th]="3d7c36e7aef080c53b51858f807695a715a4cf9c"			# 2023-09-25
LANG_COMMIT[tl]="1710e753076cbb4d98f338655a2f67a1e42e40e2"			# 2023-09-06
LANG_COMMIT[tn]="c6567884d8d7861284a8a65a1a2b7ba6add30db2"			# 2023-08-05
LANG_COMMIT[tr]="a71e2b73a4c09b822f52c6993b1e77dbe3437d99"			# 2023-09-24
LANG_COMMIT[trs]="1ca7b1c07d3637e89fb90078614771dd3c03a278"			# 2023-09-06
LANG_COMMIT[ts]="0b2b6bbabc55009bef8396206d7077268542d677"			# 2023-08-05
LANG_COMMIT[tsz]="21ce74482b1e6921e7a324d4ae8c664e45342a57"			# 2023-08-05
LANG_COMMIT[uk]="8426cbe51e86bbe08399c1e1c037c6c96367c039"			# 2023-09-23
LANG_COMMIT[ur]="8f028a41611af56af0d5d812b2e37fc4a7087dfe"			# 2023-09-06
LANG_COMMIT[uz]="42ace9dab9a05794e34053ce3355b3be0daa712f"			# 2023-09-06
LANG_COMMIT[ve]="3bbc59de131df9e5d7462bf6f09231056eb5a5ed"			# 2023-08-05
LANG_COMMIT[vi]="6f97487158703da81939322753d8f46b7d1cc20d"			# 2023-09-20
LANG_COMMIT[wo]="e485ae738ab0c90e47d33320629c6195baf791a8"			# 2023-08-31
LANG_COMMIT[xcl]="d8594b93e5b9b7ff6e024cbb399caa6fe19544f8"			# 2023-07-06
LANG_COMMIT[xh]="d2e7cd713daaa3c681d79342bbdb798b21dcdab7"			# 2023-08-31
LANG_COMMIT[zam]="019fabc6db58bed3ad2f6b9a3fdb93f38817c9da"			# 2023-08-05
LANG_COMMIT[zh-CN]="a408bb3b2bd87ee68da783ad086eabd0807af786"		# 2023-09-23
LANG_COMMIT[zh-TW]="bd41c22a253491c14669ff90495623d9879ad4da"		# 2023-09-22
LANG_COMMIT[zu]="b796166454b4c4f0dfa67f3b32b66277f703ebc5"			# 2023-08-31

fetch_l10n() {
	local lang
	for lang in "${!LANG_COMMIT[@]}" ; do
		#en_US is handled internally
		if [[ ${lang} == en-US ]] ; then
			continue
		fi
		SRC_URI+=" https://hg.mozilla.org/l10n-central/${lang}/archive/${LANG_COMMIT[${lang}]}.zip -> icecat-lang-${lang}-${LANG_COMMIT[${lang}]}.zip"
	done
}
fetch_l10n

python_check_deps() {
	python_has_version "dev-python/jsonschema[${PYTHON_USEDEP}]"
}

src_unpack() {
	unpack "gnuzilla-${COMMIT}.tar.gz"
	for langpack in $(cd "${DISTDIR}"; ls icecat-lang-*.zip); do
		unpack ${langpack}
	done
	unpack "compare-locales-${COMPARE_LOCALES_PV}.tar.gz"
}

src_prepare() {
	default_src_prepare

	# Remove the minimum necessary for script to work offline
	sed -i '/^verify_sources$/d' makeicecat || die
	sed -i '/hg checkout ${L10N_CMP_REV}$/d' makeicecat || die

	mkdir "${S}/output" || die
	cp "${DISTDIR}/firefox-${PV}esr.source.tar.xz" "${S}/output" || die

	mkdir "${S}/output/l10n" || die
	for lang in "${!LANG_COMMIT[@]}"; do
		#en_US is handled internally
		if [[ ${lang} == en-US ]] ; then
			continue
		fi
		mv "${WORKDIR}/${lang}-${LANG_COMMIT[${lang}]}" "${S}/output/l10n/${lang}" || die
		mkdir -p "${S}/output/l10n/${lang}/browser/chrome/browser/preferences" || die
		touch "${S}/output/l10n/${lang}/browser/chrome/browser/preferences//advanced-scripts.dtd" || die
		rm -rf "${S}/output/l10n/${lang}/.hg*" || die
	done
	mv "${WORKDIR}/compare-locales-RELEASE_${COMPARE_LOCALES_PV//./_}" "${S}/output/compare-locales" || die
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
