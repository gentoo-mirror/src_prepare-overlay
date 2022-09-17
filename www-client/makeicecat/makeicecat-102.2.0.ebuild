# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="e77a1fa25ac66250e88d5d9901a2ba670edb94cc"
COMPARE_LOCALES_PV="8.2.1"
SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz
	https://github.com/mozilla/compare-locales/archive/refs/tags/RELEASE_${COMPARE_LOCALES_PV//./_}.tar.gz -> compare-locales-${COMPARE_LOCALES_PV}.tar.gz
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
	dev-perl/File-Rename
	dev-vcs/mercurial
	$(python_gen_any_dep '
		dev-python/jsonschema[${PYTHON_USEDEP}]
	')
"

S="${WORKDIR}/gnuzilla-${COMMIT}"

declare -A LANG_COMMIT
LANG_COMMIT[ace]="12366a37d00c41a11a23677cdaa1d36462dc2138" #   2022-09-13
LANG_COMMIT[ach]="503a7baec89951ce13a7894b610f72bd3053dcbf" #   2022-09-13
LANG_COMMIT[af]="4e2c7d1ddbedf6dde6c6b616037621338a9f5bd8" #   2022-09-13
LANG_COMMIT[ak]="72819ba9c82d7d07aa1cd66405e4907bdb34d34e" #   2022-09-13
LANG_COMMIT[an]="06897e40a7ea3f3fbd4ea4c09537d34aed662f79" #   2022-09-13
LANG_COMMIT[ar]="9272819b09e23a2d15be2229cc1e67f530d2cfdd" #   2022-09-13
LANG_COMMIT[as]="2407d26dd52ca9c7f76434418a54707dddaee2bd" #   2022-09-13
LANG_COMMIT[ast]="f706d22e6910cc711ed19d82ec11d86403b7852b" #   2022-09-13
LANG_COMMIT[az]="f5c2a9800add4166e31f0ea96e1499a2c28469f2" #   2022-09-13
LANG_COMMIT[be]="81e7bd487c653f9b780a0c0e5363928f81171b19" #   2022-09-16
LANG_COMMIT[bg]="5c79c77311cd1a5fd097eb4b677288ed85bbb9cb" #   2022-09-13
LANG_COMMIT[bn]="c80c87ef7193400f15888a67c93c87f22adf25a6" #   2022-09-13
LANG_COMMIT[bn-BD]="5389b54a588e2359dfec7980b3c40b08b2743eba" #   2022-09-13
LANG_COMMIT[bn-IN]="729b3f29f55f6068990592d1480dddc8aaeeab65" #   2022-09-13
LANG_COMMIT[bo]="f5e778d381fea1f8b18f4d9c7f42a50af4a44681" #   2022-09-13
LANG_COMMIT[br]="6a1bcb9851b26dd56bd3a07b49cf2022e80bf62e" #   2022-09-14
LANG_COMMIT[brx]="c77a4406c5d1f5b85d71139bb494beaea8a52f96" #   2022-09-13
LANG_COMMIT[bs]="939779cb58d692f3f7f54ca07749bdfb5c8eea28" #   2022-09-13
LANG_COMMIT[ca]="9a45ccf144f1e6c23b8d350f9e49be77a69cb59a" #   2022-09-13
LANG_COMMIT[ca-valencia]="4f60e18fc248747c2282e5429f714e8dcdba3c5a" #   2022-09-13
LANG_COMMIT[cak]="b4ef404c7de8646e30dd7d1075b4f0c58e78de83" #   2022-09-13
LANG_COMMIT[ckb]="0a013af4659eb0d0eb2f158b5c491dbb47b49ce3" #   2022-09-13
LANG_COMMIT[crh]="2db4ee36e4602be8855dcfe71c977e1e889f9202" #   2022-09-13
LANG_COMMIT[cs]="f56ef18f05df085153e13f1ca0d38849393f05c3" #   2022-09-13
LANG_COMMIT[csb]="23cedcfcdaecf4db3bba08073afe30faf8c0f8da" #   2022-09-13
LANG_COMMIT[cy]="4f9d92f04f5e1210b2a0f01528269967b33fd6a6" #   2022-09-14
LANG_COMMIT[da]="8f5b0a4e517f528d0af837ba1bcda0207909a8e9" #   2022-09-16
LANG_COMMIT[de]="fc0b9e7716bf033544632418c4dd28a78a56ed7e" #   2022-09-16
LANG_COMMIT[dsb]="297626a589b144335eb7a3e19aa2a607e207bf8a" #   2022-09-16
LANG_COMMIT[el]="df817853067fa2c1e19a8b41a296eb2874e86b55" #   2022-09-16
LANG_COMMIT[en-CA]="1d1378f1315f534daccb2115acad6201ce54d579" #   2022-09-16
LANG_COMMIT[en-GB]="17f8200a789237ce3bb7893245dc06ed15c1e736" #   2022-09-16
LANG_COMMIT[en-ZA]="f7e9a94863d32d9eda3ff706bc167bb2a50420ed" #   2022-09-13
LANG_COMMIT[eo]="4ed3471dad5df6a79af2f7b291a5962b102ce805" #   2022-09-13
LANG_COMMIT[es-AR]="f76db12a18710ae3670f44deb750bfb008fb273c" #   2022-09-16
LANG_COMMIT[es-CL]="99b308d18d161a5419e4f5b5c3b93dd552ad0e4c" #   2022-09-16
LANG_COMMIT[es-ES]="caed00aac27ba38fc87b5e141e059ff883bc003c" #   2022-09-16
LANG_COMMIT[es-MX]="d8dc45ac9c4b30b5ba4bb65a47b659e28f8f062c" #   2022-09-16
LANG_COMMIT[et]="82d23ffaa7d3d6f4dba9a4ba17f9cb667f882faf" #   2022-09-13
LANG_COMMIT[eu]="a936547bff287b1e6fc29d69c1b7668145ee787c" #   2022-09-16
LANG_COMMIT[fa]="039e1fdb7c711e6e6cd364c41abcc9b1391f90c5" #   2022-09-13
LANG_COMMIT[ff]="7bd3722d82decaf4afd9945760bed3edd8d053a6" #   2022-09-13
LANG_COMMIT[fi]="c0f14162cea25841d36b78cb482e6fae9e93a702" #   2022-09-16
LANG_COMMIT[fr]="bf1137e082c6f2a3a932b9a48e15aeef6d4dfd85" #   2022-09-16
LANG_COMMIT[frp]="7824448daf968d83a8cb9b31a151a10b55af59ea" #   2022-09-13
LANG_COMMIT[fur]="004d6197a89e44e9c77473aafeb65615b02e0aaf" #   2022-09-13
LANG_COMMIT[fy-NL]="b613099d718d964176245b5b749b039b19036ab4" #   2022-09-16
LANG_COMMIT[ga-IE]="de3daf7d3f9dd85a1effa987b2dfd59d14416dd2" #   2022-09-13
LANG_COMMIT[gd]="f04aea656d9e247f6653b8585f7dc9aeafee05b2" #   2022-09-13
LANG_COMMIT[gl]="1b8cdb87bf69daf8f01dd4d764100d68f4475fed" #   2022-09-13
LANG_COMMIT[gn]="82df570c424177c3ee223718e05dbafc9bec4e28" #   2022-09-13
LANG_COMMIT[gu-IN]="e2e41d7beaa58b16922971cd523fb58b7d6486dc" #   2022-09-13
LANG_COMMIT[gv]="a7921b96413aac95ce7ec4871dc8a384939efa01" #   2022-09-13
LANG_COMMIT[he]="a6e277bd192da8628fb383e2cc67562dd0ecebd0" #   2022-09-15
LANG_COMMIT[hi-IN]="898598e1a5c649b93f3fc6df2f1655fe13d47985" #   2022-09-13
LANG_COMMIT[hr]="2711d1515af061e5041a61feac5dfa908678db9f" #   2022-09-13
LANG_COMMIT[hsb]="fa9c8cd1ff6b9dc913d9e1a6f9e495662b6ceddf" #   2022-09-16
LANG_COMMIT[hto]="6fb9095f2ff50a539a8361fefeb7812cf8d84f16" #   2022-09-13
LANG_COMMIT[hu]="15d3bc634943eabe314e7042812a33ac34c508f7" #   2022-09-16
LANG_COMMIT[hy-AM]="06836af0bd6ef34764410378de22fe3f69407cb2" #   2022-09-13
LANG_COMMIT[hye]="e35156af326b84b335a3533be9b720a774904c02" #   2022-09-13
LANG_COMMIT[ia]="2344a567edbc0dca37564b25a3de706ad8a5bb21" #   2022-09-16
LANG_COMMIT[id]="70e9a001350cf7046ddb601a3e61a29cc309f413" #   2022-09-16
LANG_COMMIT[ilo]="487cde550ededb150a9115cb788a7e879e1b4a63" #   2022-09-13
LANG_COMMIT[is]="320095d063ed9d57ec0a848e8da1c0f2182c667c" #   2022-09-13
LANG_COMMIT[it]="187ca309e166da0a4b8690f6fb1233dcccfa04c3" #   2022-09-16
LANG_COMMIT[ixl]="247cae4829e129c9acc5d176a2d0d077e93fde2e" #   2022-09-13
LANG_COMMIT[ja]="a7827e0dd34c09342a24c1536095a81f2ca7605e" #   2022-09-16
LANG_COMMIT[ja-JP-mac]="471e3bac12124e554f035fec92a69e3028a62845" #   2022-09-16
LANG_COMMIT[ka]="cd456251c3dc07b2adf08f52e795e4e28fa5422f" #   2022-09-16
LANG_COMMIT[kab]="7ef99166af494bc756f8ad989dbc7e72093264cf" #   2022-09-15
LANG_COMMIT[kk]="450c566da64843875341aead94093e858e2364d1" #   2022-09-16
LANG_COMMIT[km]="9771ada0b5f8191b9c17b71381296c6c27cda726" #   2022-09-13
LANG_COMMIT[kn]="645aa37a2112fb6da12b58092ac869d41421769a" #   2022-09-13
LANG_COMMIT[ko]="d9bdbcccc94b7d3689305c225d39a250cb96be3a" #   2022-09-16
LANG_COMMIT[kok]="e4c27abc80532950ed23028614a164d9b86f0066" #   2022-09-13
LANG_COMMIT[ks]="c4f946f664190ecba9f527a121db5f8ca72e856c" #   2022-09-13
LANG_COMMIT[ku]="1b947082d337bdf022ff735215ce5dc1de9dd524" #   2022-09-13
LANG_COMMIT[lb]="3992259edc6412a19d43324b59be429d5df5e00e" #   2022-09-13
LANG_COMMIT[lg]="42b1ab4fcd76cc16cbb072c621992c00111fb105" #   2022-09-13
LANG_COMMIT[lij]="26bb83959bfe188fa27d3491f3b4cb90d51f0534" #   2022-09-13
LANG_COMMIT[lo]="80b80038c02beeed2f5cd778823804051d6709d1" #   2022-09-17
LANG_COMMIT[lt]="b9829891f153665df42215447e5e7b501bc80aae" #   2022-09-13
LANG_COMMIT[ltg]="ab7341bddea5e353fcc6f455d0b8959250d27d2b" #   2022-09-13
LANG_COMMIT[lv]="e5f09d03d959960f19f2f1a163871d7e2e53c6dd" #   2022-09-13
LANG_COMMIT[mai]="96a3c8168159b63ebee4dcc8e267861b81b307d7" #   2022-09-16
LANG_COMMIT[meh]="dc17308f77c7047196ee30ee5e9308ec4e32f6b6" #   2022-09-13
LANG_COMMIT[mix]="fe68c04258068c19e3c8289872379be887da0da9" #   2022-09-13
LANG_COMMIT[mk]="7884845e94f36dc46db5b54adccaff723b1fc7b2" #   2022-09-13
LANG_COMMIT[ml]="e83f3b0b5714068fb7c7110ff88876f6f91bd3c4" #   2022-09-13
LANG_COMMIT[mn]="c74847e6f9a66f4bb76f80d76459a04a1e686559" #   2022-09-13
LANG_COMMIT[mr]="030db7412202dd96d790dcbde22cfb56e246d94f" #   2022-09-13
LANG_COMMIT[ms]="40a7703e875c292d05b935cdd3a471a72510b652" #   2022-09-13
LANG_COMMIT[my]="daca400565311c9ff49598fda5c5c060f49e1f8b" #   2022-09-13
LANG_COMMIT[nb-NO]="e8f034f02b8c5d6f0a9b6d73520201394e511b65" #   2022-09-16
LANG_COMMIT[ne-NP]="eaa6ae781ba06710f9277b672987fe3ab4de1684" #   2022-09-13
LANG_COMMIT[nl]="743325f6470a1bd74aea2226b29c8557a6096308" #   2022-09-16
LANG_COMMIT[nn-NO]="f08e15466d5dea921719d0ea7b01c46d7ee2c54b" #   2022-09-13
LANG_COMMIT[nr]="7935b6ab6716f337bb210827ec63e4ab35f4f156" #   2022-09-12
LANG_COMMIT[nso]="578430ce89d96b3fd8433c77600265ada13013ed" #   2022-09-13
LANG_COMMIT[ny]="239b7a430b788eebb5f43d3f3536a9058e6c60e3" #   2022-09-13
LANG_COMMIT[oc]="6712c0e12ec26ef6d6d77114421082a7b64efe3d" #   2022-09-13
LANG_COMMIT[or]="4bb1f80e418f73c6c9c5730de483800771485092" #   2022-09-13
LANG_COMMIT[pa-IN]="8f36cc819e00993792f88a2c071c86d66b2a60b3" #   2022-09-13
LANG_COMMIT[pai]="7a31aabb3d3d8dc1e2db163ed7496e7fe95e1215" #   2022-09-13
LANG_COMMIT[pbb]="14b8e1f68d595e354f74646d76c6b7eb39709884" #   2022-09-13
LANG_COMMIT[pl]="c0e750254562c23f3e7177c158997e2adb88ea3d" #   2022-09-16
#LANG_COMMIT[ppl]="fe43d8860b063c844292ec5c626244e08932e2c9" #   2022-09-13
LANG_COMMIT[pt-BR]="6f48edc82c9b0229e3666738d70995c756901f79" #   2022-09-16
LANG_COMMIT[pt-PT]="5478d724208656b813b47f67f53cffd13bcd0f24" #   2022-09-14
LANG_COMMIT[quy]="4568b64b3a63b45ec87891854f73c150d6a8fcc8" #   2022-09-13
#LANG_COMMIT[qvi]="82121600c44fe54e2d93fe9406f93c6167d11aeb" #   2022-09-13
LANG_COMMIT[rm]="dd934a76fb016e8a347e3e7939791c1eb3160db4" #   2022-09-13
LANG_COMMIT[ro]="6654eb644058bd002a2a1fe1ac6708f8727e3d32" #   2022-09-16
LANG_COMMIT[ru]="16e69ffba967de7ef4ab0449276d6d25eaadb503" #   2022-09-17
LANG_COMMIT[rw]="eedc793d4509c9883b113c6bd4d62ca8a4cd9dc5" #   2022-09-13
LANG_COMMIT[sah]="6127d8e4322e958fd166548e89849f25e27ef609" #   2022-09-13
LANG_COMMIT[sat]="cf31b1779c112cea41ed61db8278b06513d0f2fe" #   2022-09-13
LANG_COMMIT[sc]="e2c30a7eeaf6188f6e0c24a78bf5f4e7bccdc41f" #   2022-09-13
LANG_COMMIT[scn]="7e78e4dbd5e2e491767358c3948d0df8109624d3" #   2022-09-13
LANG_COMMIT[sco]="7c986f4b5044a2edf6f4cf3bbb9c42cb9c8bd246" #   2022-09-13
LANG_COMMIT[si]="faec65dc547fcdbbc04e3969377266d4a482aa0f" #   2022-09-17
LANG_COMMIT[sk]="8814afd7f67ef07349435966036f521506546db8" #   2022-09-13
LANG_COMMIT[sl]="923af5ff58080ad52a22a2d69e29da10ad83fc87" #   2022-09-16
LANG_COMMIT[son]="d86d5d2b6eefc69a136bce3d4895f50ad058a0db" #   2022-09-13
LANG_COMMIT[sq]="49bb5fae5d9b6c0d085951e723b7c2641b5b36cc" #   2022-09-13
LANG_COMMIT[sr]="d6a0ab79b06f923a8f00702722158550c4cd3026" #   2022-09-13
LANG_COMMIT[ss]="ee962e9f461e25f122d70a1cdc2282425a53766f" #   2022-09-13
LANG_COMMIT[st]="525e4e18ec13d6092ae2b0064e036336d0f63a7b" #   2022-09-12
LANG_COMMIT[sv-SE]="d64688481165466737676bb9ea8009bb969ab39b" #   2022-09-16
LANG_COMMIT[sw]="c3ce1ca1efeb2fd49c0cf2a10d738cbce0d77c9f" #   2022-09-13
LANG_COMMIT[szl]="4b3316c4aa483fe55a84997d59d15602e795f94d" #   2022-09-13
LANG_COMMIT[ta]="48c7aab86db8dbd16969602642508ea3f2857304" #   2022-09-13
LANG_COMMIT[ta-LK]="ddd09348b41283bd710ef71f8bf4f78d1f164a2e" #   2022-09-13
LANG_COMMIT[te]="9825f7fad61163c3d3d3faa6127324e9ec1dacf0" #   2022-09-16
LANG_COMMIT[tg]="f67d3865c2365e0f2d6594c9db36cf865678d471" #   2022-09-17
LANG_COMMIT[th]="009fd08524542157fd26ea104bb379a075e81c04" #   2022-09-14
LANG_COMMIT[tl]="dad9caecd7a98017d5cede865b8aeaf4942f6618" #   2022-09-13
LANG_COMMIT[tn]="10d6cfc11d8cd144b2c15bf3d03b3d840846eda0" #   2022-09-13
LANG_COMMIT[tr]="3c7929a1cd6a6336e2a517d5e637b0cd509f195b" #   2022-09-17
LANG_COMMIT[trs]="f6d105faedcc43a4c33552cf113f1165828e6f05" #   2022-09-13
LANG_COMMIT[ts]="db49cd170c69b728f277701356f3a6f92db5486a" #   2022-09-12
LANG_COMMIT[tsz]="b42d4ea2a77aa40bd9a8eb04d5a4825f84860373" #   2022-09-13
LANG_COMMIT[uk]="eb3789c0aed90703e6f8ceb62f0a822b88519197" #   2022-09-16
LANG_COMMIT[ur]="c4e927eab511ab86a5851fac509e9b6fcafe07ce" #   2022-09-13
LANG_COMMIT[uz]="7063df917cb3c14f1921f100cf37281fd4ad7a87" #   2022-09-13
LANG_COMMIT[ve]="2924315bc7fc8dfb099f2ba4e677115ffe2dcc7d" #   2022-09-12
LANG_COMMIT[vi]="ccf8f034e46c686b623aa047a5f7381f5d74d053" #   2022-09-16
LANG_COMMIT[wo]="db6772b3e75a93c9412a4a0708fbbda0f8e56ab5" #   2022-09-13
LANG_COMMIT[xcl]="2315bf2449869ecb9d0e8d5e0bfce79b5e77e803" #   2022-09-13
LANG_COMMIT[xh]="93bc595dc32e9216d391c0c32851e8a45db913e4" #   2022-09-13
LANG_COMMIT[zam]="ba52687485718dbd524c994071cb324b90492420" #   2022-09-13
LANG_COMMIT[zh-CN]="61230fb7d0774f10f1e779bc9de2016434f5ec65" #   2022-09-16
LANG_COMMIT[zh-TW]="9bf112b21e31ab7dd90516aa68491c3276b8df4e" #   2022-09-16
LANG_COMMIT[zu]="11de97e10f9a805d1e5b954c2fe895df9cd3da79" #   2022-09-13

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
	has_version "dev-python/jsonschema[${PYTHON_USEDEP}]"
}

src_unpack() {
	unpack "makeicecat-${PV}.tar.gz"
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
