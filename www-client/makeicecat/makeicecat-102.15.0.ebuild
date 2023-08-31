# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="400fbfdbc0c1ac9c68c9f52fd2ab6899bc8e8bd0"
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
LANG_COMMIT[ace]="844c9b53019ae24904a75347fee1faa1bf7ebdef" # 2023-08-05
LANG_COMMIT[ach]="69ed4659f8f6cb3fbe8f982b4835f634ac442d57" # 2023-08-23
LANG_COMMIT[af]="f5ff8a54cb5d82953d778b9421651a593c4f3140" # 2023-08-23
LANG_COMMIT[ak]="5d23e00b2eb26fa401eb1d14ef1fa5b55b28d0ed" # 2023-08-05
LANG_COMMIT[an]="fa6faeb2f566d83b26cde3271ca30cbbd6acc7cb" # 2023-08-23
LANG_COMMIT[ar]="d8af0aa3b7b364aea82f4298d909d33f2c2e9d63" # 2023-08-23
LANG_COMMIT[as]="70ed114ecfc924b8c8ecf3f8bfe7cab2d1694092" # 2023-08-23
LANG_COMMIT[ast]="4e3854cb863c897106639eb725cc009a8025a69a" # 2023-08-23
LANG_COMMIT[az]="49075c5de6609747ac377a1f0c14a4bc46b26313" # 2023-08-23
LANG_COMMIT[be]="2f60b8ce75258165ed79ea5e99f7e1c727040774" # 2023-08-27
LANG_COMMIT[bg]="227139f5a0cb55317ab05ad49740628d37cdf15e" # 2023-08-23
LANG_COMMIT[bn]="e4a4a72e409d62ce5f4513d05024e0907b039142" # 2023-08-23
LANG_COMMIT[bn-BD]="e9a847a38ca3cd483d920b78846b8e464c1a1575" # 2023-08-23
LANG_COMMIT[bn-IN]="c5d65c562138c5b3b1acc1cd11a1de151f0637d5" # 2023-08-05
LANG_COMMIT[bo]="42f95ae54a242d1a49621d4786224af77cdca739" # 2023-08-05
LANG_COMMIT[br]="daf24739ff8720deec1611a2b7751fcbfea43d66" # 2023-08-23
LANG_COMMIT[brx]="2e21a7e53d5dfe498eed9f3b11336b4970f6fad8" # 2023-08-23
LANG_COMMIT[bs]="956e21e925277e202114f24dcff465b4e3e9cd4c" # 2023-08-23
LANG_COMMIT[ca]="dc56b72e4621ecc8327754834bd96be8550ac918" # 2023-08-23
LANG_COMMIT[ca-valencia]="9af2cb4a3db160ef5e5a31f08c9bc3ff97e6e18c" # 2023-08-23
LANG_COMMIT[cak]="09c82e7e75657d0beb13bad57c60560fbe228c58" # 2023-08-23
LANG_COMMIT[ckb]="f0a3c49e40257af9111958c3e57826cacc40ad71" # 2023-08-05
LANG_COMMIT[crh]="60ecb75369c306dffb63ada3d72ca6a3e3cc9009" # 2023-08-23
LANG_COMMIT[cs]="671e35fca7cca34d1e80e0aeba4c3287654e2b19" # 2023-08-30
LANG_COMMIT[csb]="ef304f75a965fa20fbf82788c130b5e8c776a7e7" # 2023-08-05
LANG_COMMIT[cy]="53aff2ee6f8168b548bcf54b7af41267154f09e8" # 2023-08-29
LANG_COMMIT[da]="e152f021eb94d2649f1c17ad87b4b9d74b8fedcf" # 2023-08-31
LANG_COMMIT[de]="e30791cc3d4acbbe4638e0c2bf87b8cfaafee5cd" # 2023-08-24
LANG_COMMIT[dsb]="17ee046f1f155f07e3b8dbf6c37393ef0350fdfe" # 2023-08-24
LANG_COMMIT[el]="0d4f218725ef347a321cf682a623b2b3f2f7bf0f" # 2023-08-29
LANG_COMMIT[en-CA]="b0d8afc69fb548f7720a6c277ca0df4d6844e7c5" # 2023-08-23
LANG_COMMIT[en-GB]="4a167a105945e57ff848f081b1cb35145590f890" # 2023-08-25
LANG_COMMIT[en-ZA]="f6cae438ad1bc08e096bfc370ae275a70065caf5" # 2023-08-05
LANG_COMMIT[eo]="aeb33cd0813057db6f18d9d980c37939c50edf7c" # 2023-08-26
LANG_COMMIT[es-AR]="09e5489e238f335ef604f9f1a5d12917c0452389" # 2023-08-30
LANG_COMMIT[es-CL]="a33a1892f870f18125dd9f562a9d6779de9d8778" # 2023-08-30
LANG_COMMIT[es-ES]="c829646149509bc5f73d102e1b11a49d353db66b" # 2023-08-30
LANG_COMMIT[es-MX]="381c9af03782b9b63bd329bfe03720b57b23ff02" # 2023-08-30
LANG_COMMIT[et]="7f341f77bfaf2ee64f8adbadcfab7b2c7b63d3d4" # 2023-08-23
LANG_COMMIT[eu]="2ad125fb918991d0eb255dbb9555bd3465cf5730" # 2023-08-27
LANG_COMMIT[fa]="78c91edb9340c317b684cf2009847a36ccda6e65" # 2023-08-23
LANG_COMMIT[ff]="3ff00534a58888f310c7ac17f3cb88bc0ee95dda" # 2023-08-23
LANG_COMMIT[fi]="e4fe3aeb2ca1fd50110a3cdf69a7c78e9f1a1f9e" # 2023-08-23
LANG_COMMIT[fr]="ad4ef5f276d5b5cf443a62a8fc344619aecbe8d3" # 2023-08-24
LANG_COMMIT[frp]="3c5b9926ffb44324a4b5f33225870b778032a37d" # 2023-08-05
LANG_COMMIT[fur]="4719f6f698c8fe55332fb240484be13d50b33e51" # 2023-08-31
LANG_COMMIT[fy-NL]="3ee65a7e68d78806ee3cebcac13abbb1c1784aa1" # 2023-08-25
LANG_COMMIT[ga-IE]="6b7bb9c793e121170f6701b47f8175f8a006c3de" # 2023-08-23
LANG_COMMIT[gd]="11e72c25bad4bf5095c0e4e0a75e817c0cd31f3e" # 2023-08-23
LANG_COMMIT[gl]="80151ff4092812b0e862f45237a8bf6a52d2d34b" # 2023-08-23
LANG_COMMIT[gn]="208155e516ca4b22c878e1b3e72cb003b1faf16e" # 2023-08-31
LANG_COMMIT[gu-IN]="6d6e364e207b07806b53b15711ad1c8b9c03479d" # 2023-08-23
LANG_COMMIT[gv]="025c6cac9fe0191b1713087655945a0554d3a69f" # 2023-07-06
LANG_COMMIT[he]="215fc1f5e7070b5a6345d69a274fb4d763b65c02" # 2023-08-31
LANG_COMMIT[hi-IN]="cedfb2099f55f46be4aec4348947ff2aec84eb0a" # 2023-08-23
LANG_COMMIT[hr]="41283ee1432a48d815c358bfb5195a55ea43c33d" # 2023-08-23
LANG_COMMIT[hsb]="ad4c00089c04a90b4516244f1e482daa86fac153" # 2023-08-24
LANG_COMMIT[hto]="e60951e056f2756654c93f1eb8f1e1157195a139" # 2023-08-05
LANG_COMMIT[hu]="75cb2c510bd2c20c3430f746692ac517661775ed" # 2023-08-24
LANG_COMMIT[hy-AM]="d91a636478d78b52cb91d02b650e3a759a0b95d0" # 2023-08-23
LANG_COMMIT[hye]="a2c9f29718e5bf8e4ea534e7226576df7f153645" # 2023-08-23
LANG_COMMIT[ia]="3c42b6ba4b1271b2c8c3b41da8e12671600fc912" # 2023-08-24
LANG_COMMIT[id]="3f293538b78fa7a7cf89ed9297cbc50751ee0e16" # 2023-08-23
LANG_COMMIT[ilo]="fa1c9743401625f8df91d6dda4858d45fd9e003a" # 2023-08-05
LANG_COMMIT[is]="209b52e4d81caa61ca9b8f829e15193128a241ce" # 2023-08-24
LANG_COMMIT[it]="adf606c3f286c7f85f056837c742249a58e0cb73" # 2023-08-31
LANG_COMMIT[ixl]="e5b63add34abe54310145bcc92c521cd2facaa51" # 2023-08-05
LANG_COMMIT[ja]="154ed142d8962de24d30a93047db3c2b17470a62" # 2023-08-24
LANG_COMMIT[ja-JP-mac]="1d543357135dd7700646eda94acdf71c0bb28b55" # 2023-08-24
LANG_COMMIT[ka]="0633f863bab377f2d63c1973860b8d8dbdccb81c" # 2023-08-23
LANG_COMMIT[kab]="a26fa17bd6c9e6a6f4c7c375f87e5619162f2cda" # 2023-08-31
LANG_COMMIT[kk]="253943111f7cc3d6d29ff9fa157b5decd17cdb99" # 2023-08-25
LANG_COMMIT[km]="7accb9861d2960a7a37418aa16d87f94c6508fbe" # 2023-08-05
LANG_COMMIT[kn]="f18cb0f59521dd35dd108af223160bd4abed0f1c" # 2023-08-05
LANG_COMMIT[ko]="9e9d736484370eca75ace87766fb7908a86a6a35" # 2023-08-23
LANG_COMMIT[kok]="902fba2081bd2b41cb3e6aee57a84ad12506165d" # 2023-08-05
LANG_COMMIT[ks]="dac3f2a2fb89ff7eb463d876938382a96ffd9f98" # 2023-08-05
LANG_COMMIT[ku]="2599deacced3bc30c8bc0a1b045c1299293626f8" # 2023-08-05
LANG_COMMIT[lb]="41d29f28adcf308a4cf53496c83d52abc3479cd3" # 2023-08-05
LANG_COMMIT[lg]="018fb863a8f6708d1125e13a0a02eda5f929c1d8" # 2023-08-05
LANG_COMMIT[lij]="00aa93ca015a1e43b6ff65d73d79220c5b6e3039" # 2023-08-24
LANG_COMMIT[lo]="81ceec8d2dc2e6fd67accd46c00f3127af0559fc" # 2023-08-23
LANG_COMMIT[lt]="5f33fb898231856ac43f9b5a6ccbcbfcb55414a8" # 2023-08-23
LANG_COMMIT[ltg]="3d7ca88f292d854d5fb49a64035620689f83cba4" # 2023-08-23
LANG_COMMIT[lv]="213cbbdb5c679601afb77163d53f558dd0ead0b5" # 2023-08-23
LANG_COMMIT[mai]="9c527ee4ef22bac19ecd575cf4d7f002c78fdcaa" # 2023-08-05
LANG_COMMIT[meh]="637916d1125f97df170c4b036d99326778398a69" # 2023-08-05
LANG_COMMIT[mix]="029f864e4d638d25f3896424fa918400f6ecfd68" # 2023-08-05
LANG_COMMIT[mk]="8071c758a4c503941b58685857f31a626ed8a397" # 2023-08-05
LANG_COMMIT[ml]="dc149902cb38abc85303493d452196242c1bd09f" # 2023-08-23
LANG_COMMIT[mn]="ac28b2e6485a3393bffd1b29bd2bf6d34e7f7bc6" # 2023-08-05
LANG_COMMIT[mr]="d70a2d73de9b0a54c4072f02df5dbae116b1700d" # 2023-08-23
LANG_COMMIT[ms]="6fff96aba19036c9296cd3c04ddaabc5ca005e0b" # 2023-08-23
LANG_COMMIT[my]="1ebbaf14d6f4141da7202cf4bfa289c3bd2b9acb" # 2023-08-23
LANG_COMMIT[nb-NO]="06931fc666a4539a420422bda73314afbe163dbb" # 2023-08-24
LANG_COMMIT[ne-NP]="cf1eb4c204917e348bd341790e2da528c3199bc6" # 2023-08-23
LANG_COMMIT[nl]="f4243c435b65a9a03052f29cdab7192ac3820628" # 2023-08-24
LANG_COMMIT[nn-NO]="05963c7c5ce7c2d442bf63e3de5d14deab0f818d" # 2023-08-31
LANG_COMMIT[nr]="573a9aa6c19c5e2e9937d7a0f537d8dbecc354d7" # 2023-08-05
LANG_COMMIT[nso]="c7b5829fd08ffa9a31ea71c0cff62c39471aa829" # 2023-08-05
LANG_COMMIT[ny]="a582f27b50425c1658edb438616cc15349bffe12" # 2023-08-05
LANG_COMMIT[oc]="d4e829bd5a3cc5089968fbb3b60a70e5a6cdfe6f" # 2023-08-23
LANG_COMMIT[or]="a3e72918066a3c8ab8c5c19fb043b4e8dc5ac9f5" # 2023-08-05
LANG_COMMIT[pa-IN]="bdfb926c5da04fe2b4c8f364b6b018547c8af318" # 2023-08-28
LANG_COMMIT[pai]="49fd654beb254c472f5785d6cffcbccf6970100f" # 2023-08-05
LANG_COMMIT[pbb]="bf04be4f42fef2787eb7e4b898e86fda690968d2" # 2023-08-05
LANG_COMMIT[pl]="436866ee0a9a6b028aa7ab696e8f1e965581a4f5" # 2023-08-23
LANG_COMMIT[pt-BR]="2a03700d9aeb1cffda1f34bd55dab615a730c665" # 2023-08-24
LANG_COMMIT[pt-PT]="b54aae823b1ab17ed9744fb95795422e6b9b3513" # 2023-08-28
LANG_COMMIT[rm]="eb7c4ea72f846b8f49ce786e6db42650b7b2a6ed" # 2023-08-23
LANG_COMMIT[ro]="daa5c61f5590c9284d39eecd07ea3d4398c2b54a" # 2023-08-25
LANG_COMMIT[ru]="c100ce39c74abb71c478eaac7bd0a52a1e074061" # 2023-08-30
LANG_COMMIT[rw]="6334f98efbcc81e44963ad5d18012437e1c4d843" # 2023-08-05
LANG_COMMIT[sah]="cf0843a3165eeea67b91293f10a7b0e188358fb7" # 2023-08-05
LANG_COMMIT[sat]="ec48d950e2bd21fa926d91d739992e7786015b37" # 2023-08-26
LANG_COMMIT[sc]="dda0fb63b378cc669375275168a3f266125f44b9" # 2023-08-15
LANG_COMMIT[scn]="05d182b0c70e61ebb9e0d0a055042d69f3f9644b" # 2023-08-05
LANG_COMMIT[sco]="728bae01d93808527732defd9f5d9528adefd2f2" # 2023-08-23
LANG_COMMIT[si]="634ad5c8848e28cb4ad60f4023db61ae7207f307" # 2023-08-27
LANG_COMMIT[sk]="290db77e73b02f661ced0fbd77c4197775e70673" # 2023-08-28
LANG_COMMIT[sl]="a9a7e82400420514383417341e60b002a9b4281f" # 2023-08-23
LANG_COMMIT[son]="8b68cb0168911fb0a82d95ca12e14ed86d6bf509" # 2023-08-23
LANG_COMMIT[sq]="84509862a3ad1994cb16231b67fb412449a9aee3" # 2023-08-23
LANG_COMMIT[sr]="94d06d4640c9fe94e72c6209418805b6592c05ef" # 2023-08-23
LANG_COMMIT[ss]="bec601c8a508d164142f9ae085ae2aba16904bab" # 2023-08-05
LANG_COMMIT[st]="482adc426c35bac5a6331ef80f5d5b7463ce5996" # 2023-08-05
LANG_COMMIT[sv-SE]="30c0048cb7d864e4224fca94b70c532533d8da00" # 2023-08-27
LANG_COMMIT[sw]="18f48e46374baf347c2a6ce16f2195ba23155aa0" # 2023-08-05
LANG_COMMIT[szl]="aaee567014901828c4488800c6983e62ff1e8bde" # 2023-08-23
LANG_COMMIT[ta]="9fa29bbb2e0f4eedbc4940010315a0b693035bb7" # 2023-08-23
LANG_COMMIT[ta-LK]="ac7ce62f1f0bf551114afaf491214679a09553e4" # 2023-08-05
LANG_COMMIT[te]="908a1176f1c9fd7f7d4c708e66d75879c061f0db" # 2023-08-23
LANG_COMMIT[tg]="d004cbb212b9e0e6ecde40753705f974feb3992d" # 2023-08-25
LANG_COMMIT[th]="30bf0074efbf8e0334ecda12520d23e05abb0420" # 2023-08-23
LANG_COMMIT[tl]="b9c49e698fdcc30f7d3492af35a5c365423ab49d" # 2023-08-23
LANG_COMMIT[tn]="c6567884d8d7861284a8a65a1a2b7ba6add30db2" # 2023-08-05
LANG_COMMIT[tr]="9f918c1fd678e1113ba857c84f3bb5ef4bf7bd48" # 2023-08-28
LANG_COMMIT[trs]="e2bc934c217d29f34934a57929e9bd41f77b0894" # 2023-08-23
LANG_COMMIT[ts]="0b2b6bbabc55009bef8396206d7077268542d677" # 2023-08-05
LANG_COMMIT[tsz]="21ce74482b1e6921e7a324d4ae8c664e45342a57" # 2023-08-05
LANG_COMMIT[uk]="c33fa4bf1d508a4eda937ed1570f316a9bda200d" # 2023-08-24
LANG_COMMIT[ur]="d5ee2bbf3d35dbef7cf5215a197ef5657eec1280" # 2023-08-23
LANG_COMMIT[uz]="41e331b7be28e771dc1eb7f8bf8b3eeee1557cdc" # 2023-08-05
LANG_COMMIT[ve]="3bbc59de131df9e5d7462bf6f09231056eb5a5ed" # 2023-08-05
LANG_COMMIT[vi]="8be48be1a062aea2d636a9c9ffdfed5eae2a1619" # 2023-08-31
LANG_COMMIT[wo]="737e3e9697ac1fbe181be5b4ad45915c5187dd5e" # 2023-08-23
LANG_COMMIT[xcl]="d8594b93e5b9b7ff6e024cbb399caa6fe19544f8" # 2023-07-06
LANG_COMMIT[xh]="49037ce4cd8e868a288cc3607274c93b0ee2f185" # 2023-08-23
LANG_COMMIT[zam]="019fabc6db58bed3ad2f6b9a3fdb93f38817c9da" # 2023-08-05
LANG_COMMIT[zh-CN]="4d63abbddf7eb3eb6c75184008cf4428be48b843" # 2023-08-28
LANG_COMMIT[zh-TW]="4fd8cda6ef74e397cee09a3f384e9eb214bd460e" # 2023-08-24
LANG_COMMIT[zu]="d5beff720495777db64123a09449546ae14f3344" # 2023-08-05

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

	# brand.dtd's removed in l10n's
	sed -i -e '/find l10n.*brand.dtd/d' makeicecat || die

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
