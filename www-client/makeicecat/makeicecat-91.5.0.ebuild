# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="c0a504578cb694522c65bb6c36396df8142d4a2a"
L10N_REV_COMP="587012866a2b6898d37be3d50016be437989f67e"
SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz -> firefox-${PV}esr.source.tar.xz
	https://hg.mozilla.org/l10n/compare-locales/archive/${L10N_REV_COMP}.zip -> icecat-compare-locales-${L10N_REV_COMP}.zip
"

LICENSE="GPL-3"
SLOT="${PV}"
KEYWORDS="~amd64"

IUSE="+buildtarball"

RDEPEND="${BDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	app-arch/unzip
	app-crypt/gnupg
	dev-perl/File-Rename
	dev-python/jsonschema
	dev-vcs/mercurial
"

S="${WORKDIR}/gnuzilla-${COMMIT}"

declare -A LANG_COMMIT
LANG_COMMIT[ace]="e383f0804626e6d703e7341a2c80c77a4b225e71" #   2022-01-06
LANG_COMMIT[ach]="9aa43a02f35a4ea0679e5d139283df58a0a1ec7a" #   2022-01-07
LANG_COMMIT[af]="162654a20c86192e124df9766ec5ecd54143d085" #   2022-01-06
LANG_COMMIT[ak]="016d55423f1da4b5de32ee8cbcf7898118d12473" #   2022-01-06
LANG_COMMIT[an]="d10834e1c7ba839ba9c372205f4371c4d3c19791" #   2022-01-06
LANG_COMMIT[ar]="372c39194cb3d6632a5d965d89651eb512896445" #   2022-01-15
LANG_COMMIT[as]="b44ae7a12113d545a666f18033c91858d368273b" #   2022-01-06
LANG_COMMIT[ast]="fafa76db5181d9a81fc10c740b719b972277ebe9" #   2022-01-06
LANG_COMMIT[az]="8deb838d7fb7f94f5add61979a5388d7f579bc57" #   2022-01-06
LANG_COMMIT[be]="b59bd16f1f6565a52c1075d7da5a50645d698d81" #   2022-01-09
LANG_COMMIT[bg]="a66f62fc489ce4f99da3bfed14b3a79e93faf6f9" #   2022-01-06
LANG_COMMIT[bn]="7acbeb8d7875791b758f93e68e24d731ddcbaecf" #   2022-01-06
LANG_COMMIT[bn-BD]="ef9e05815b7bf3e0c39f6bd6a0f7865a5b2dca28" #   2022-01-06
LANG_COMMIT[bn-IN]="fe46ec9c6a1fab36c0715dc2a5df86f957a531ed" #   2022-01-06
LANG_COMMIT[bo]="97059fd9d1a83e254bf84da12f1612062e82d271" #   2022-01-06
LANG_COMMIT[br]="ccdac27a048eb8cfa59ce34e1282077d59e0df18" #   2022-01-06
LANG_COMMIT[brx]="573ec21d6a1aebf6a342533bb06b77c79b6e994b" #   2022-01-06
LANG_COMMIT[bs]="3d175bb18ae52bd07f2b80292bccaa81d19c102c" #   2022-01-06
LANG_COMMIT[ca]="8e22b90b3e309f26c8c774ed4e2dd1f1bfe4d45e" #   2022-01-06
LANG_COMMIT[ca-valencia]="591b9c3e08c5a4a14d2a8ea572b49b1ad1107be4" #   2022-01-06
LANG_COMMIT[cak]="574da1c25c89fba5128670941d676f0f2b615cc2" #   2022-01-06
LANG_COMMIT[ckb]="bd043d903599db44feb371bf29d4a3d510a48a0a" #   2022-01-06
LANG_COMMIT[crh]="4c656ffb07a816452cd2bac628fdc064858170a5" #   2022-01-06
LANG_COMMIT[cs]="8350dbf215e0df75d850e34d4a1133f54ebd76cb" #   2022-01-06
LANG_COMMIT[csb]="cfca971fd3676f22b831325bdcaf89d2dae8da6d" #   2022-01-06
LANG_COMMIT[cy]="6d91f9fc6c4542487279e78d58149c2576f695e2" #   2022-01-10
LANG_COMMIT[da]="602900879d8b525d5ffa5963647f34bd68a30ffc" #   2022-01-14
LANG_COMMIT[de]="14170b044462c1bb15d6a1fbf239612c57762e80" #   2022-01-08
LANG_COMMIT[dsb]="24b6f6457aebe0bd4ba34ae8f3fb3cffa11ac49b" #   2022-01-06
LANG_COMMIT[el]="7cf901c83b065a67791e7c9d7afaa779e5941741" #   2022-01-10
LANG_COMMIT[en-CA]="a8b9e88b6bdc4187401d10cc7f938a8632f4dd24" #   2022-01-06
LANG_COMMIT[en-GB]="92b8f831e3cb8ded8082c00d04ffbca0f1ec8e08" #   2022-01-14
LANG_COMMIT[en-ZA]="8b696d61e2f653738e1e9d38086f0464bc4c5f9e" #   2022-01-06
LANG_COMMIT[eo]="4f7dec829ffd444f47af87c4110f75a726ab4d1c" #   2022-01-15
LANG_COMMIT[es-AR]="269c5fc08d0df9f64733d91215b169c02d5ed3a0" #   2022-01-10
LANG_COMMIT[es-CL]="2de5cb01abd1d0b0c7e4f3881d7163ac5b195d53" #   2022-01-10
LANG_COMMIT[es-ES]="62fe6d41b4bde8bdc200f73b4b8c8abd3f116a25" #   2022-01-06
LANG_COMMIT[es-MX]="995db99855689118a0d3c4a59e22183cca8bc64e" #   2022-01-13
LANG_COMMIT[et]="699d9910692822bbc51939f3a69720c4ca491751" #   2022-01-14
LANG_COMMIT[eu]="144ac468fe5dba58e559c96a9f8dfca4d4d27d54" #   2022-01-09
LANG_COMMIT[fa]="d7de1ce29673fab4c4ef5f2a2031bcfc8f3ae529" #   2022-01-06
LANG_COMMIT[ff]="c292e27a51265717bd768c31e82cf785a647a907" #   2022-01-06
LANG_COMMIT[fi]="2c1ca220f525b459411a414b0ae6e48b1c607bff" #   2022-01-15
LANG_COMMIT[fr]="bb68f9f1514b859a2f514cf998ea1c993dffd9b8" #   2022-01-13
LANG_COMMIT[frp]="1f7e8a74a38847bb61bdaa59b9c4087232409beb" #   2022-01-06
LANG_COMMIT[fur]="fdbd5ee5502ea9e45c717cc71f3f6138d0791393" #   2022-01-06
LANG_COMMIT[fy-NL]="1bf15dd5ce096698e820a9fea0260e6b20f469e7" #   2022-01-11
LANG_COMMIT[ga-IE]="2d955174d7ab6068656b2f02e4d8c689bb2399bf" #   2022-01-10
LANG_COMMIT[gd]="068b491ef0351c3a7cf96a5891209d3424533741" #   2022-01-06
LANG_COMMIT[gl]="6b1e778ad6fc7b4de13c285b2cd49e66217cc29a" #   2022-01-08
LANG_COMMIT[gn]="2a48c0965a2cc757e61fb825d6fbf5a5df8bc89e" #   2022-01-11
LANG_COMMIT[gu-IN]="89a969afad02c6e0d4da914e1bc8833a812ed180" #   2022-01-06
LANG_COMMIT[gv]="f2fc53ab3d11da177cc94ad7ed6e136ab27bf269" #   2022-01-06
LANG_COMMIT[he]="77d9c684a5025f737aec905217fe80bb04a114a2" #   2022-01-11
LANG_COMMIT[hi-IN]="2afb324e5aa325b8c1ddf2d0c497b19393210311" #   2022-01-06
LANG_COMMIT[hr]="9ec279a424459bc31dc987c3afee75f12fa154ae" #   2022-01-06
LANG_COMMIT[hsb]="cadcb40cebffd77b3555bcb29a743c0f9c8983ef" #   2022-01-06
LANG_COMMIT[hto]="dc63a5c6a9c9cc98602262b039b6b11c76d628e5" #   2022-01-06
LANG_COMMIT[hu]="bced011d214d940ed8a0904999510c7c7e4c3ede" #   2022-01-07
LANG_COMMIT[hy-AM]="905a992fb0cac81750ac835bdd59ead2cb6776ea" #   2022-01-06
LANG_COMMIT[hye]="e64a455b2822f3146294671d24e55eedbc0cb895" #   2022-01-15
LANG_COMMIT[ia]="9c0b7db277afe964d5d3e0f0b7b43954037afab7" #   2022-01-08
LANG_COMMIT[id]="1c709914fa1b748a58f1df37c9b3041bfc60a5ad" #   2022-01-15
LANG_COMMIT[ilo]="a0b9dc5857dbdecc57f876f053014002cf2305cd" #   2022-01-06
LANG_COMMIT[is]="b885038ccddce2d86bd2c7c39ecbff9b8d72b76f" #   2022-01-15
LANG_COMMIT[it]="2f6d1661dff743a0b2bca268a28d07ffba0dcaa6" #   2022-01-15
LANG_COMMIT[ixl]="30f2e0882d6575df16ac173592d2571865e7fb86" #   2022-01-06
LANG_COMMIT[ja]="f82d1c2145df987cba9f8033c637629150e9f6b0" #   2022-01-09
LANG_COMMIT[ja-JP-mac]="ba087cc68f762ca1eb004d74fd127e574ec70562" #   2022-01-09
LANG_COMMIT[ka]="6fdebe8145bba97f9575a339ba42e5fd0b12b821" #   2022-01-06
LANG_COMMIT[kab]="3ade97b633b4592ab456adec7911d00b88b4f6b4" #   2022-01-06
LANG_COMMIT[kk]="0e0198a23650e034147033d1abbf15cb6ba5352a" #   2022-01-15
LANG_COMMIT[km]="c04f31c98e50315177467bd4e079200d3b38b835" #   2022-01-06
LANG_COMMIT[kn]="0bc693a82c819a27e71f41828c040e7be4b92785" #   2022-01-06
LANG_COMMIT[ko]="1792012e77ad2939eff8f82454aefb0971eb3fbb" #   2022-01-15
LANG_COMMIT[kok]="018ac9d9490b9fe77e3ce9106dea30b0267446d4" #   2022-01-06
LANG_COMMIT[ks]="f4054f6adbb2bd896ad8d41011cf699d23e088ec" #   2022-01-06
LANG_COMMIT[ku]="188de086338d1a719909bf4266035d17c4ff329e" #   2022-01-06
LANG_COMMIT[lb]="669793c5dcd5f3f83ad212448042938a6b9b7040" #   2022-01-06
LANG_COMMIT[lg]="a7feffb631646312c88e2d1c03047e805841f911" #   2022-01-06
LANG_COMMIT[lij]="9f53ef4274e72b3692ce6eb00ca9af63e3724774" #   2022-01-06
LANG_COMMIT[lo]="942d94da48979eb60bcd62d825f7f9337314999f" #   2022-01-06
LANG_COMMIT[lt]="97fe61f173017b8522b945bb265d521372b85b46" #   2022-01-15
LANG_COMMIT[ltg]="aef3846002688408b845347518fdd63e37a5e158" #   2022-01-06
LANG_COMMIT[lv]="af4d460804b6e128a9c04fcbf41c5fc755a8c2ae" #   2022-01-06
LANG_COMMIT[mai]="c7d1b95f94a004d63cec7215aeac4fcc60d98929" #   2022-01-06
LANG_COMMIT[meh]="7bda4bae19046b97e55f3e2ee6c252addb6efba1" #   2022-01-06
LANG_COMMIT[mix]="71f9cc54878550e63a59129386a1c16c8d46730a" #   2022-01-06
LANG_COMMIT[mk]="c473f0b380bd14c98754cb38cdc287c5b0df99a0" #   2022-01-06
LANG_COMMIT[ml]="94e82a9b8446e0d56c3344b20c90af26082a65f6" #   2022-01-06
LANG_COMMIT[mn]="1e68058a8a8462eb225781cfffa9b08517218275" #   2022-01-06
LANG_COMMIT[mr]="69d18f54944345840b8fbd84c306f457fdb5d446" #   2022-01-06
LANG_COMMIT[ms]="24348be7c84339894bb6de243a450fae852c92a3" #   2022-01-06
LANG_COMMIT[my]="25d516d33a6c2f8881683c5530f468e2c25ab6eb" #   2022-01-06
LANG_COMMIT[nb-NO]="3f71d92304d60d098fd3c088aec4a1283ee4b46a" #   2022-01-11
LANG_COMMIT[ne-NP]="5676e8e0b93e18fb5eeb238953c512d4f407340c" #   2022-01-06
LANG_COMMIT[nl]="08bdb531ec4ed12aa3ab185fbc48290ad998e844" #   2022-01-13
LANG_COMMIT[nn-NO]="4c88e1fe57af2df9e711f0945e495a74ec09c1f6" #   2022-01-15
LANG_COMMIT[nr]="b812f24744280f56682cf2ada7f252c3d10b5230" #   2022-01-06
LANG_COMMIT[nso]="284888d07de6a01f08acf74c0005938261be25e1" #   2022-01-06
LANG_COMMIT[ny]="b6c1a809d12fb11656d255e3792b0af62557d527" #   2022-01-06
LANG_COMMIT[oc]="2e0d7a200fa91df65793d11362ed7e74ef92762b" #   2022-01-08
LANG_COMMIT[or]="dd4117a6306811f85bd427c15023597a8cdb802f" #   2022-01-06
LANG_COMMIT[pa-IN]="b28bb037d4687370eebb7a892982b31bddea32b0" #   2022-01-09
LANG_COMMIT[pai]="c83cfee2ebb4d0ba889d11bf3bf612652985fc0a" #   2022-01-06
LANG_COMMIT[pbb]="7f952a799823c4684a7d9222588ba2de6b3069d2" #   2022-01-06
LANG_COMMIT[pl]="a0e9474db5944f9d50d2f75abd5eae02e5ecfbd0" #   2022-01-06
#LANG_COMMIT[ppl]="26ee9bc20a9361b03653b82bdae58bfa87e1797b" #   2022-01-06
LANG_COMMIT[pt-BR]="82840ce8dc654bcf0451fc69d6d2d7e120934444" #   2022-01-10
LANG_COMMIT[pt-PT]="be9638e50a62d83196da9d9250915ddf412b99de" #   2022-01-06
LANG_COMMIT[quy]="9c3130f42c678b15ce1d536d565b740612596c95" #   2022-01-06
#LANG_COMMIT[qvi]="cf1900a2362788f000d14e27673f59cf0e4aa972" #   2022-01-06
LANG_COMMIT[rm]="78fa598403129b20f23174d30053dad6f8e2c620" #   2022-01-14
LANG_COMMIT[ro]="e1ab2df379105c635d9d00e9d3f4ab4b027b84cd" #   2022-01-06
LANG_COMMIT[ru]="78a5cd8aef1f021b7a6f83c7deaa135da0ac153b" #   2022-01-09
LANG_COMMIT[rw]="48cbd9cb539b75ab37a5808383fcbc0887a44a0a" #   2022-01-06
LANG_COMMIT[sah]="12fb102e7bc76dab1456ed0b88fc14c73f981ca9" #   2022-01-06
LANG_COMMIT[sat]="3ab6969e38e316491894b42527f2287dbbd7d626" #   2022-01-13
LANG_COMMIT[sc]="45e875cfc8b9445ce552eca53eaf04f21d3f1ab7" #   2022-01-06
LANG_COMMIT[scn]="cd5e2a8622189ff6b2b6f82ff9d749e3028afd20" #   2022-01-06
LANG_COMMIT[sco]="a76f0ea2163fa939916a77989ca1a19909479ec0" #   2022-01-06
LANG_COMMIT[si]="639820754f8563d1fccf89f48c4b155db6a3ae8d" #   2022-01-06
LANG_COMMIT[sk]="86de0ef3b3ee4d05bea24eaa4695d19ae5ed8def" #   2022-01-13
LANG_COMMIT[sl]="8bb43b492eeeeba907929b42389bf0fcb135fd5f" #   2022-01-09
LANG_COMMIT[son]="1541de0c90d66751ae72c24d4fa8105a585cf203" #   2022-01-06
LANG_COMMIT[sq]="dcff95e181451df2f85db17ecaccb25f16019a93" #   2022-01-06
LANG_COMMIT[sr]="b824496d9b712ab6ad8d2418fe8381349d9ffe8b" #   2022-01-13
LANG_COMMIT[ss]="82188bb8444fb9b1436f72664c5d4ca49d1ae316" #   2022-01-06
LANG_COMMIT[st]="ac23a90a715031a3d31caa8fd83c6cbe6f75a6fe" #   2022-01-06
LANG_COMMIT[sv-SE]="e085f66db194d6240158060c11926cb6ce2c7c62" #   2022-01-06
LANG_COMMIT[sw]="82318e61508faba1806a969e15810fe8c280bbdb" #   2022-01-06
LANG_COMMIT[szl]="000ee773591f17bcd9fc5ed5eb504000a016ce5b" #   2022-01-06
LANG_COMMIT[ta]="7430660f60953bad26ceb87f57a248199413bd5c" #   2022-01-06
LANG_COMMIT[ta-LK]="ed472d476e6823843f16cf7fb54a4e0272d16610" #   2022-01-06
LANG_COMMIT[te]="787c81baf062be1cb8cec8543f9b2ee7617d385e" #   2022-01-06
LANG_COMMIT[tg]="0e073b0322c3c150438c9a95f16c47e38b162066" #   2022-01-14
LANG_COMMIT[th]="225e516acb6564fe6c4d72ecc0902b6ee8836b2b" #   2022-01-06
LANG_COMMIT[tl]="45e6d11f344c47405396e2669587cb4ca0c42af7" #   2022-01-06
LANG_COMMIT[tn]="335e015d7dfc8ae5639660d1907b7fdb7b02e037" #   2022-01-06
LANG_COMMIT[tr]="fbc001aa48b39db9ac16209129154fb772eceb0d" #   2022-01-15
LANG_COMMIT[trs]="43debe20e58afdd09ddbcd2f7dd62039c1e8c5f8" #   2022-01-06
LANG_COMMIT[ts]="c399d15ac7c8b32ffee8bdac14539181ea7aab37" #   2022-01-06
LANG_COMMIT[tsz]="d47c303e79c080e90a0ec9337a75a843c729bd21" #   2022-01-06
LANG_COMMIT[uk]="9f677fc9dc5225b365106ee44f978f68a645c67f" #   2022-01-06
LANG_COMMIT[ur]="412cba0103c039a79a0fb0fca44435ab2d377ce3" #   2022-01-06
LANG_COMMIT[uz]="20fae386cbcdcdf79a032520ce2525c6d2e18a52" #   2022-01-06
LANG_COMMIT[ve]="d4f51eb857143131eb70733a15fd558e14ab727d" #   2022-01-06
LANG_COMMIT[vi]="d1ebcee72886c193372dfe35bc12cfa0cf0e1d7b" #   2022-01-07
LANG_COMMIT[wo]="625cc2e007db82c90ecddd39e34f1969c4088e09" #   2022-01-06
LANG_COMMIT[xcl]="6d6d615e1753f149a4c00788dac23f98acc0f5c7" #   2022-01-06
LANG_COMMIT[xh]="09a4bf9ceb7fe52e7fd54b2c8a15c16c6a4c56f2" #   2022-01-06
LANG_COMMIT[zam]="4840c22c1cdffa89f4ba2ed3341ed1a2572c9f93" #   2022-01-06
LANG_COMMIT[zh-CN]="57bd28a33531ffb344f0beb20893ce3e897b8eb5" #   2022-01-13
LANG_COMMIT[zh-TW]="393a503c10d7378fe0b02b150f64e846ce36f0dc" #   2022-01-06
LANG_COMMIT[zu]="3e8c9a04e8b1557bd451d8cd1ffaa50d65713179" #   2022-01-06

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
	unpack "icecat-compare-locales-${L10N_REV_COMP}.zip"
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
	mv "${WORKDIR}/compare-locales-${L10N_REV_COMP}" "${S}/output/compare-locales" || die
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
