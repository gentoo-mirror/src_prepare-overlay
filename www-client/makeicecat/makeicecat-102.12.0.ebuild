# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="b2d463b0e331795eebe3ee62f2c58c1bd05b9899"
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
LANG_COMMIT[ace]="aa01245f9463be5f708d84d0dafd18917f80eebb" #   2023-06-02
LANG_COMMIT[ach]="f76c6bd4d425f9b96ea490e5a34784288b8d019e" #   2023-06-08
LANG_COMMIT[af]="c5f4a33c5178e129a5846c405819e3c9f5934f0d" #   2023-06-02
LANG_COMMIT[ak]="09c6aaffa4cb8528f5a5c0194be13adee86b2f64" #   2023-06-02
LANG_COMMIT[an]="79a6b3eda1ad7cbbb7c0ece553c4bc9c56d44e99" #   2023-06-08
LANG_COMMIT[ar]="ee2daa0aacc21badf832068399d929442b82f527" #   2023-06-08
LANG_COMMIT[as]="52576683ebb8dbf2e3610bfae7d9908a9abdf6db" #   2023-06-08
LANG_COMMIT[ast]="164f6f0915b6461cc4ccf333f8b8818e0bbbc09c" #   2023-06-08
LANG_COMMIT[az]="c0d195f9cc2630d4cf765a8d2df8ae21d41cbb51" #   2023-06-08
LANG_COMMIT[be]="656ff2c2f7392fc4aa60973514b10807b93a3cde" #   2023-06-08
LANG_COMMIT[bg]="8e7796a1f2c2bd92c0aac75968f269206b6426de" #   2023-06-08
LANG_COMMIT[bn]="2c3c5b00a19370fb835de9a25f5798bd783541fa" #   2023-06-08
LANG_COMMIT[bn-BD]="521220ffd66637bf40a29e20be138336e9716bb8" #   2023-06-02
LANG_COMMIT[bn-IN]="125d46f7dfbca145022b865473e9982d37d58932" #   2023-06-02
LANG_COMMIT[bo]="e8226172b9acb61e347440202cdf6bec976561c1" #   2023-06-02
LANG_COMMIT[br]="782ed03b99b43279589e0c9cbb6767206e24fd8c" #   2023-06-08
LANG_COMMIT[brx]="5e0c3f501eb6121c6d120c7d2214b26a2bf3b687" #   2023-06-02
LANG_COMMIT[bs]="8f39c650de01eb7fa87c0ae3b95fe511bf2cc3a3" #   2023-06-08
LANG_COMMIT[ca]="4259c649c0aa79fbf584a6f615f869cb4bc7b43d" #   2023-06-08
LANG_COMMIT[ca-valencia]="625f0a4536cb681bcb90168bd306c9e1cbb07c41" #   2023-06-08
LANG_COMMIT[cak]="68bb09347bffd2d1293a73dd9ce2a78d98976713" #   2023-06-08
LANG_COMMIT[ckb]="9e036134bff4370a21d7f497064c851c6dc7ead9" #   2023-06-02
LANG_COMMIT[crh]="12e752dac96ed34023c41b91e345541b112a9a90" #   2023-06-08
LANG_COMMIT[cs]="b5eb8402172b248fac43a2221a1b158c463c6fcf" #   2023-06-09
LANG_COMMIT[csb]="6eacc039390b0d014524d9289b9e3fb9aa23116a" #   2023-06-02
LANG_COMMIT[cy]="f1eab19ce033c96c1ef89b39ea14c6664ef3906e" #   2023-06-08
LANG_COMMIT[da]="cb0da11a0f17b2f1506292766c04f3f864a0a2e0" #   2023-06-08
LANG_COMMIT[de]="e21b71416a78e7265cc8e6f092f0c3695ecfd9b1" #   2023-06-09
LANG_COMMIT[dsb]="68fd28f3b636075cf97d76f6683bf805684deeb6" #   2023-06-08
LANG_COMMIT[el]="ba88bbfbbfac68580df56847d0b258f022dbaedb" #   2023-06-08
LANG_COMMIT[en-CA]="bf3dca6c3d0cc2ccbe7350546f7dbe32147a5d53" #   2023-06-08
LANG_COMMIT[en-GB]="28311aae01e9f1d27f3e48babb0814a8252e02fb" #   2023-06-08
LANG_COMMIT[en-ZA]="1749bedd7129be65bbb59c1d3fa828918c9d792c" #   2023-06-02
LANG_COMMIT[eo]="1f5d13d3d701de8230de007e5af4fd07e4cf5631" #   2023-06-08
LANG_COMMIT[es-AR]="2317493950d23368622fedfb5e1c53e7f0ed98aa" #   2023-06-09
LANG_COMMIT[es-CL]="944ea0fc36c0c75d17ba74c839912495354a9160" #   2023-06-09
LANG_COMMIT[es-ES]="9b8c7e0c39f2b6d375fcb68c930924197c5865fd" #   2023-06-08
LANG_COMMIT[es-MX]="16dd9a6740878c11511c47aeaf1d4006e2736463" #   2023-06-08
LANG_COMMIT[et]="0d0227b5d7029c9c663afda6f0723dd797dfc5cf" #   2023-06-08
LANG_COMMIT[eu]="64b0ab7ddb717e8c4758ee093177457f57c81986" #   2023-06-08
LANG_COMMIT[fa]="b3dfe954ae0218b09b8dd3ad87a02f83c2709761" #   2023-06-08
LANG_COMMIT[ff]="8cc7ee6037b6615405939d79807fd5d3daaf9b7c" #   2023-06-08
LANG_COMMIT[fi]="d58e42845a3103732999dabe66eeb376d70e1fed" #   2023-06-08
LANG_COMMIT[fr]="afca515181dcea9165669f66ed13153d615b5308" #   2023-06-08
LANG_COMMIT[frp]="6e1664e7304c134fa0a262faf3811c7838c9aecf" #   2023-06-02
LANG_COMMIT[fur]="29f072d3618c175c1b47df253d266dd2089638de" #   2023-06-08
LANG_COMMIT[fy-NL]="1eec52a377256c08e8796ff31d4e8876f9c05250" #   2023-06-08
LANG_COMMIT[ga-IE]="f49116e673ae46844b41e5b9f1dcf1e4afa88225" #   2023-06-02
LANG_COMMIT[gd]="d4ac819a33c1919073432d1941518429e0a41b41" #   2023-06-08
LANG_COMMIT[gl]="020584451fb9ca7e83012f8ccf99d4603918715f" #   2023-06-09
LANG_COMMIT[gn]="69058b29e88d7e1dba536ee235d75009a1527688" #   2023-06-08
LANG_COMMIT[gu-IN]="dc402d4eb962539d35e4aa0214531ed831119051" #   2023-06-08
LANG_COMMIT[gv]="74b7a18b3de7038151f2f764ffb83ea3a92d2f62" #   2023-06-02
LANG_COMMIT[he]="f84e7fb19b9683dc458be067a9b50b61fc576f19" #   2023-06-08
LANG_COMMIT[hi-IN]="78807a134bb619172ad960ad837b743eac3f3cca" #   2023-06-08
LANG_COMMIT[hr]="7c4440400dcd39cd8a6917ed57f79877e3860117" #   2023-06-08
LANG_COMMIT[hsb]="7fd79616455e4edb71776b39a4bbf2b76f375ec2" #   2023-06-08
LANG_COMMIT[hto]="5cfd54b4c387151a880d37e1cc1e61fc48280460" #   2023-06-02
LANG_COMMIT[hu]="e14bc1d3354173cee67d30fcb5d18f7a20719335" #   2023-06-08
LANG_COMMIT[hy-AM]="9f63da68e9e891284d56f7c7e6d49850da8a39dc" #   2023-06-08
LANG_COMMIT[hye]="704fb3c894a34249a803d98a242be16bc001f15f" #   2023-06-08
LANG_COMMIT[ia]="1cc67cc56a7d939872c199276f554c37c2cc238a" #   2023-06-08
LANG_COMMIT[id]="fca3933c4dbff50ae9d59e4602eb0c6829a51df4" #   2023-06-08
LANG_COMMIT[ilo]="14fc2e7cd2c65534efac4fc5deba58b13394ccf9" #   2023-05-24
LANG_COMMIT[is]="9c46a74e8f72757a196d922148a493d187a1d92d" #   2023-06-08
LANG_COMMIT[it]="78c82eabb48000dc0cf1b283f2c8dc43a712c1c5" #   2023-06-08
LANG_COMMIT[ixl]="68e1e80ae64e64fafdb0c7134afcb9fb4a7ac23f" #   2023-06-02
LANG_COMMIT[ja]="5763ff4ab538ca56e7c1a712144e1eb1506ff7d2" #   2023-06-08
LANG_COMMIT[ja-JP-mac]="55f30933875bb3a0a451caea5c3af9ce5a525993" #   2023-06-08
LANG_COMMIT[ka]="fe351c2caeff69f240af15b231d6e11f43cfec3e" #   2023-06-08
LANG_COMMIT[kab]="8b1a759f7977f490e2b8777ca4cdc7f726c16956" #   2023-06-09
LANG_COMMIT[kk]="35ef39b6f194c28295b550368064840d48306839" #   2023-06-08
LANG_COMMIT[km]="42fdcd9667cbe8c3c576fd0bd2073d70917a807c" #   2023-06-02
LANG_COMMIT[kn]="4ba51b5ae66923835ce23ceb1d597c3017e98000" #   2023-06-02
LANG_COMMIT[ko]="af56f4d727e2ef817bf95a671d07bfc94686edae" #   2023-06-08
LANG_COMMIT[kok]="b34d1f807ca3ffb0a0649554d36e6bd91b95f6bd" #   2023-06-02
LANG_COMMIT[ks]="a9dd0a4c6c4f0053c770a3c661451529f6573f9e" #   2023-06-02
LANG_COMMIT[ku]="0206c503eaff5d70ba3eb47bc06f50238a8954a2" #   2023-06-02
LANG_COMMIT[lb]="2e66970c575b9471cfc06f434624427d363ee92d" #   2023-06-02
LANG_COMMIT[lg]="543a5aaa04ba9409187496c3e9de59ca05b8f267" #   2023-06-02
LANG_COMMIT[lij]="068a308fdf5bf968ba8bebc535363235e74750b4" #   2023-06-08
LANG_COMMIT[lo]="f16e90a96c6d130e611d24da339da4f6563c42ab" #   2023-06-09
LANG_COMMIT[lt]="2fee3e490593a78a8ef42b3c8ea05d9d3aa14099" #   2023-06-08
LANG_COMMIT[ltg]="907a702f6bb4e2c41f80c70bf9bb668f5ef92493" #   2023-06-08
LANG_COMMIT[lv]="e4740c02ae6601d8bf25302e6416c3238215931a" #   2023-06-08
LANG_COMMIT[mai]="b71fcdaecb43beacfc9c30bf99127b59f9302ec7" #   2023-06-02
LANG_COMMIT[meh]="68d30cf342ac3ee9aaaea56c222c67c85666e58d" #   2023-06-02
LANG_COMMIT[mix]="c5d85c960e1b4f154cddfe1b78a4d21c9f0c1ce9" #   2023-06-02
LANG_COMMIT[mk]="334e3e18b23ffc2aab558150d18e0bf5e5623b3c" #   2023-06-02
LANG_COMMIT[ml]="e60c96b40b267341d3edf6cfb595b21a1a159438" #   2023-06-02
LANG_COMMIT[mn]="636974c81d113688e67c4d77dbe1083d0a2b842e" #   2023-06-02
LANG_COMMIT[mr]="2adf095e284a4fa43c1ba8e9602ffa784bc20b24" #   2023-06-08
LANG_COMMIT[ms]="3cf7ab54efacfa90896e00aec5f431b75f8399c4" #   2023-06-08
LANG_COMMIT[my]="b660e0613bc2e5b02a38effdc3299c2ee552b3b1" #   2023-06-02
LANG_COMMIT[nb-NO]="32528f47057102fc420f87f64f4842fe97f594f1" #   2023-06-08
LANG_COMMIT[ne-NP]="628d8478ccd10092abaf5f96c1d6d85dfd8e61f2" #   2023-06-02
LANG_COMMIT[nl]="137fe0308802a36b9cad9b28f274b50d700c3d5e" #   2023-06-08
LANG_COMMIT[nn-NO]="479adab9c493f125ec99c036f30f1f64f42aac70" #   2023-06-08
LANG_COMMIT[nr]="e33e0a77961ec364fcd61f145e6894caa71bf4aa" #   2023-05-24
LANG_COMMIT[nso]="e3110171f550c37cba6c8beb78e2db3536448a61" #   2023-06-02
LANG_COMMIT[ny]="13e38343b3343ac42b57dc610d42936fe0735125" #   2023-06-02
LANG_COMMIT[oc]="8502cc5292a62e0f43e509485313a9cd7b6cc6f9" #   2023-06-08
LANG_COMMIT[or]="310b081db3b6ec2e5a88af71eb6b6150afe4e39f" #   2023-06-02
LANG_COMMIT[pa-IN]="7e698dac192efad2d2c4010818cdad5e6ad50f60" #   2023-06-08
LANG_COMMIT[pai]="ee8dfd4a03e491e08b86b8866dbe545134e83ce3" #   2023-05-12
LANG_COMMIT[pbb]="512bd042a880af3d3e1617f68acc6194162f765b" #   2023-06-02
LANG_COMMIT[pl]="552bd42fbd903f1a2bfb6b421ab690a6087133fa" #   2023-06-08
LANG_COMMIT[pt-BR]="23ef093e5f29968822f720a185c386d52e3ae798" #   2023-06-08
LANG_COMMIT[pt-PT]="3643aa753e66ce09c354f6e31ecc09e2b7d5b250" #   2023-06-08
LANG_COMMIT[rm]="8ac047218c8073537c67ef3b1795a07aeeda51c0" #   2023-06-08
LANG_COMMIT[ro]="502cc0e557abd59c64df8221148af357568aa7ae" #   2023-06-08
LANG_COMMIT[ru]="bb1a535edb236ddcd5a1947f545c9747e7a53c02" #   2023-06-08
LANG_COMMIT[rw]="fe683a44163ff39ef3e27e646022cc52b91bb24e" #   2023-05-24
LANG_COMMIT[sah]="69b551a4d47ffe2dc2ec3514411b6321b3631099" #   2023-06-02
LANG_COMMIT[sat]="bdf4e8ad38597a9459377b5ed840c33cb85371dc" #   2023-06-08
LANG_COMMIT[sc]="ddaddc0948341f965bb0d1f82a6c02baaa70b23a" #   2023-06-08
LANG_COMMIT[scn]="4548b92c310dc1ffc5e6efab3214ecb4eb0464e3" #   2023-06-02
LANG_COMMIT[sco]="f936cd534ea785a5c84861baaea66ca1f6f8ae8f" #   2023-06-08
LANG_COMMIT[si]="eee348b298d3490afba03e3658064b39d031850d" #   2023-06-08
LANG_COMMIT[sk]="8fdd9ce2c86af663f79e7e71017d7ee4e29475e1" #   2023-06-09
LANG_COMMIT[sl]="be4227a893e5e9ae4277663e4c4ffc3bf974b98a" #   2023-06-08
LANG_COMMIT[son]="acfdd005384e82feffd33c9a05c77ec4bd3cb1ca" #   2023-06-02
LANG_COMMIT[sq]="89de925c7ca4752ee5b542309bde33fb0751573a" #   2023-06-08
LANG_COMMIT[sr]="52c910d9ad950f5dc6fe7966198b7374131ac970" #   2023-06-09
LANG_COMMIT[ss]="7cc03c62377db992580701b9fc7b1c44e677c842" #   2023-06-02
LANG_COMMIT[st]="d64229d1cbab6a1fdd2a6c2f9d4e66a344400ef0" #   2023-05-24
LANG_COMMIT[sv-SE]="63f2269f64001b20136243d304e1edc63b8f0ef5" #   2023-06-09
LANG_COMMIT[sw]="442d4bdf78151465ec47b70188054f8641d7e163" #   2023-06-02
LANG_COMMIT[szl]="842d2097e5fd776a64d45ba6c88c5ad3b246a122" #   2023-06-08
LANG_COMMIT[ta]="1c9dc153a9c11459955ad989c5dc4ea598c1eb4e" #   2023-06-02
LANG_COMMIT[ta-LK]="8799e6abb692941a330c1661089b07eb904cc1e3" #   2023-06-02
LANG_COMMIT[te]="48e5e6e983a64f3306f17155351b2e0b8a566f0a" #   2023-06-08
LANG_COMMIT[tg]="98d3030dc1bbb14cd6e7baf845c7c8b2062cc430" #   2023-06-08
LANG_COMMIT[th]="6dd924b0273b1926788a2818fed308b45ec4b7bb" #   2023-06-08
LANG_COMMIT[tl]="527069ae36bd8cb5374703a5a4306b1e499e4318" #   2023-06-08
LANG_COMMIT[tn]="8191cf4cdea04e9215027868aa666b828a704c93" #   2023-06-02
LANG_COMMIT[tr]="d760fee012897ffaabd33d25a4a2b3b3dfb9f022" #   2023-06-09
LANG_COMMIT[trs]="d09b41aa82e023b6c740b1fddb4fbc2b65972305" #   2023-06-08
LANG_COMMIT[ts]="3bb939aa67a7b2c17c13e0bd02292fdbd06dceb5" #   2023-05-24
LANG_COMMIT[tsz]="7e4a22890cf3b8527800660e39eca1427109fdd9" #   2023-06-02
LANG_COMMIT[uk]="fadee8136105dd7195aa2035b82a84c2b45e78ff" #   2023-06-08
LANG_COMMIT[ur]="1ae1751c720871ebabc7163c3e62bc0058aab5d2" #   2023-06-08
LANG_COMMIT[uz]="f144b3c26da48ae422d9c1516baab358d60ff254" #   2023-06-06
LANG_COMMIT[ve]="ae9c793afa0a5d4b5cc78e6bb971d4c2e4297aed" #   2023-05-24
LANG_COMMIT[vi]="162114afd00fa5f60f6239c9ae2a1d03690d5983" #   2023-06-08
LANG_COMMIT[wo]="b5b321f782726f9147fc9fc04da31da46dadfb72" #   2023-06-02
LANG_COMMIT[xcl]="b487e1f6d282a0ddaaf36acc7f87b8f7550a60e3" #   2023-06-02
LANG_COMMIT[xh]="cfac9eda5145f5a3656557f90b89852905441de7" #   2023-06-02
LANG_COMMIT[zam]="03233c171dca42da5d01e69e60bcd5dbd105bfea" #   2023-06-02
LANG_COMMIT[zh-CN]="6de1a7dffcfe75db78828886be32923e90af7aaa" #   2023-06-08
LANG_COMMIT[zh-TW]="18ddf27cb551aa5c57261b4bffea1669d7c6a07a" #   2023-06-08
LANG_COMMIT[zu]="d33193abbc2e5120c7527624d742c292d9d33a40" #   2023-06-02

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
