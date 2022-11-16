# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="6925ebbbf970768ccf8d7c4d370651ffdff58051"
COMPARE_LOCALES_PV="8.2.1"
SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
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
	dev-perl/File-Rename
	dev-vcs/mercurial
	$(python_gen_any_dep '
		dev-python/jsonschema[${PYTHON_USEDEP}]
	')
"

S="${WORKDIR}/gnuzilla-${COMMIT}"

declare -A LANG_COMMIT
LANG_COMMIT[ace]="8e02a2093030d0b62f9718119fafc6eee458a2b6" #   2022-11-11
LANG_COMMIT[ach]="520f3d014070e8a9600b4359003b5a3823deb11c" #   2022-11-11
LANG_COMMIT[af]="b7e0860f16b7c7c78e94888ee671e835b0cf062d" #   2022-11-11
LANG_COMMIT[ak]="9ba83a476c6ea7e5f7c689384084daf24a5f4071" #   2022-11-11
LANG_COMMIT[an]="c98264868cfe0cdbd5e1b123d30408695f2897f6" #   2022-11-11
LANG_COMMIT[ar]="4fa92b1f85676ee7232a86708cb1b7af2022e5f8" #   2022-11-11
LANG_COMMIT[as]="ade8e17915aa9a30299cd9e1d4605ec1a4aabe4e" #   2022-11-11
LANG_COMMIT[ast]="fb6899978afa63d3d499646f0df70e6620b68418" #   2022-11-11
LANG_COMMIT[az]="888895696825ed931922593a014c48640cfbab1c" #   2022-11-11
LANG_COMMIT[be]="4e470f47b18f6ae326c89f885b45bed7c3f979ac" #   2022-11-15
LANG_COMMIT[bg]="e80b5397c2c4774ece616464dd6065a68dbea622" #   2022-11-11
LANG_COMMIT[bn]="2a916d7094d477209f38268ac74cbe32d1e7dd89" #   2022-11-11
LANG_COMMIT[bn-BD]="e1856006a838e467f1395bcc5aaf3ce450754da7" #   2022-11-11
LANG_COMMIT[bn-IN]="ef3fbad19a20710b32fc85d1eb9c708159e19873" #   2022-11-11
LANG_COMMIT[bo]="656ad97634c8e985221a1cf49178024fc6dd0f66" #   2022-11-11
LANG_COMMIT[br]="7765cf5ffca8228f5afe352e0ab1faf1bd4cbf06" #   2022-11-11
LANG_COMMIT[brx]="6516cf8fc7886bbf6c1cb6df2c5f55696ef5380f" #   2022-11-11
LANG_COMMIT[bs]="574dcaff8d90fde4b24bf74e6898dd655e943ffd" #   2022-11-11
LANG_COMMIT[ca]="25ed20d7536b650c679b59983b86dc076f78fe31" #   2022-11-11
LANG_COMMIT[ca-valencia]="1b96a7a20f1ebc8b2fd627923b2a640d8c6f3ccf" #   2022-11-11
LANG_COMMIT[cak]="d46037f17d22ccaee573384cc23a387ecaa23192" #   2022-11-11
LANG_COMMIT[ckb]="17b4f2d3bb907c9b50e95c2cf3680891a61ed3ef" #   2022-11-11
LANG_COMMIT[crh]="db51e856801021e10d9e6183a2defff72626c46c" #   2022-11-11
LANG_COMMIT[cs]="6d2e115b48396db361a95ec9aeb8c4bcabec4aa8" #   2022-11-11
LANG_COMMIT[csb]="49c1ab0fe4c8fe23dfae7a6e7ea878bf67ff2875" #   2022-11-11
LANG_COMMIT[cy]="8906466e4669b046cc98e86cdc8a32856218a2ec" #   2022-11-14
LANG_COMMIT[da]="518aaf9ab72d9c6c60817292bfd388f2a8b2747b" #   2022-11-15
LANG_COMMIT[de]="e9fb2ca2e043c25853364cb678004fb26680d3a5" #   2022-11-13
LANG_COMMIT[dsb]="d469e72d3c5d96959bfc17d694e3383a6db6d282" #   2022-11-11
LANG_COMMIT[el]="de567b549d1761a8e3fb25fd1cf94f1242b42781" #   2022-11-13
LANG_COMMIT[en-CA]="4cf6daa750ab2d1161bbfba4227d752af499fd93" #   2022-11-11
LANG_COMMIT[en-GB]="0ddb24d0a99a375826c39e25d54c018ef166c8b0" #   2022-11-11
LANG_COMMIT[en-ZA]="6ab3e2aa13f0853be7552e690f6c975eb90dab10" #   2022-11-11
LANG_COMMIT[eo]="859552a1f7460ee71287bef9656fa79f8b55b6cf" #   2022-11-11
LANG_COMMIT[es-AR]="da50113e713c7881acd57004d00d68e7a842f0e4" #   2022-11-11
LANG_COMMIT[es-CL]="ec90986df1a6e942895f685a4dfb2770e5976513" #   2022-11-14
LANG_COMMIT[es-ES]="6649dc814fcdbbf86aaeef31b96541ce9a70e8ff" #   2022-11-13
LANG_COMMIT[es-MX]="89cf9319417ce2fb2bc0ad7d8e60439adf0cd95c" #   2022-11-13
LANG_COMMIT[et]="c792ab3a90590c74e7d75423c463a27228a46fad" #   2022-11-11
LANG_COMMIT[eu]="356856dcd4e2c357854aedcc55257ca4b6c2e814" #   2022-11-14
LANG_COMMIT[fa]="782709931973dbe8f6c12b62dba9032822c6666b" #   2022-11-11
LANG_COMMIT[ff]="6dea80026b501a9db822871b25ccce9468aef588" #   2022-11-11
LANG_COMMIT[fi]="f7c89d63171aa6a20df64c7bf5210ecce85258ea" #   2022-11-15
LANG_COMMIT[fr]="02d5cc3e36ab59030edc2d3c06b8953836ba7993" #   2022-11-14
LANG_COMMIT[frp]="b403f74bba3559683e18428fadec23a29cdfb666" #   2022-10-09
LANG_COMMIT[fur]="9b68542a15407f99370c6d4cd6fdb8bbc70137fe" #   2022-11-11
LANG_COMMIT[fy-NL]="bd8f9b2a6c7e510f76e9522612cdc58d0cf2d4d2" #   2022-11-11
LANG_COMMIT[ga-IE]="48ae7eb10c316dd50b7e1210e44283b5ac212c22" #   2022-11-11
LANG_COMMIT[gd]="395fe4a023e3f161cf047e4ad9a266e9a7549772" #   2022-11-11
LANG_COMMIT[gl]="64e31d517fc2cbbaa9560ac8cea80bea3948f5ac" #   2022-11-11
LANG_COMMIT[gn]="d29869a0f58e48c947e9f672d2d33fcfc7aa4c34" #   2022-11-15
LANG_COMMIT[gu-IN]="3deba2fdaa1569deb0d06778dd61bec368ad22ea" #   2022-11-11
LANG_COMMIT[gv]="64ad0d0ec14cff5c6daff00fa0e84220e2ea93fd" #   2022-10-08
LANG_COMMIT[he]="2273145cea0b7279baf75ade17ec29a6253c06b3" #   2022-11-11
LANG_COMMIT[hi-IN]="f914dccd3d63dbb9df43c880d90554a140c632dc" #   2022-11-11
LANG_COMMIT[hr]="dc448971f341de412b7bb1b3da8d41d707ebd523" #   2022-11-11
LANG_COMMIT[hsb]="182a7e5c9858392e1dc95f0882d9755128da6993" #   2022-11-15
LANG_COMMIT[hto]="ba577ca0d0763cdb8d51f2234483d4b11bdcc3e0" #   2022-11-11
LANG_COMMIT[hu]="ab497d4f0b7b0685b7fdea0d163da83d78c47b90" #   2022-11-14
LANG_COMMIT[hy-AM]="6aa8610b9c46aab7ece886b9976cc195de141069" #   2022-11-11
LANG_COMMIT[hye]="3761b6e80adcb46e53f10364a7381646f82d6dc3" #   2022-11-11
LANG_COMMIT[ia]="ab053bfcd13810b34a1b0ee03ed5157dca1a872d" #   2022-11-13
LANG_COMMIT[id]="5a33a2c4caad220ab3a979de92ce0f00243444b1" #   2022-11-11
LANG_COMMIT[ilo]="3994ab36f212ae80e94654f94137aae63b517d81" #   2022-11-11
LANG_COMMIT[is]="fdd525d3a7d8630c219281842589990c5aaf84a7" #   2022-11-11
LANG_COMMIT[it]="0d09be56b521e37ea9a48bea452541b2b8855220" #   2022-11-15
LANG_COMMIT[ixl]="47530aa71e38cd1b25c63e1a1cdadaaffdf56d1c" #   2022-11-11
LANG_COMMIT[ja]="0ff14b3534b9d28f52022f1d5510fd8f79f64ee3" #   2022-11-11
LANG_COMMIT[ja-JP-mac]="6386d694ce973581a9a1b60cabfcb77138a1d9f1" #   2022-11-11
LANG_COMMIT[ka]="93589af34296c63b6c42cc53676ce9b75239c63d" #   2022-11-14
LANG_COMMIT[kab]="6f8e5f5766d59d83a1bca7e145e9303cffb6d447" #   2022-11-11
LANG_COMMIT[kk]="92df8e4f4476d7c0744f51e3f6ab55e999d295fa" #   2022-11-15
LANG_COMMIT[km]="cc6bfb576ffa76e8d59e7a5acc6218bdf8cc15de" #   2022-11-11
LANG_COMMIT[kn]="ddceced2323ca7682d7df877d75fcdd54c27a5e6" #   2022-11-11
LANG_COMMIT[ko]="9822c0d04bb38cdb81ca6aabf7b95f6242666ec3" #   2022-11-14
LANG_COMMIT[kok]="5113f9c67ccbf7399c038754ef526bd9529fe608" #   2022-11-11
LANG_COMMIT[ks]="f4c3931aa04f7a93cbb31e18460e1b00a8da7a6f" #   2022-11-11
LANG_COMMIT[ku]="fa64108c1f08f9dc80f66a4af7f6affe201da5a3" #   2022-11-11
LANG_COMMIT[lb]="d91784d875bd9623cd0b64a920dd634024988ca9" #   2022-10-09
LANG_COMMIT[lg]="8c5b5e4c8c3dd27c0d93902dd2faca746af81d4f" #   2022-11-11
LANG_COMMIT[lij]="d2efaa6e0aceaa330a4921078fb7313a19becd57" #   2022-11-11
LANG_COMMIT[lo]="23d8adc00cead30153717bcbb7d274847bec34f5" #   2022-11-15
LANG_COMMIT[lt]="472c16da267ffc25d5b0e78f88b3e613b77ba1b0" #   2022-11-11
LANG_COMMIT[ltg]="26220321fd73ac5073a6bd3c789a04ff3af7b811" #   2022-11-11
LANG_COMMIT[lv]="91a46d12b807e805e0dc50fc6a1236d0c8469c23" #   2022-11-11
LANG_COMMIT[mai]="cde7c948d9f2877f55998e308cac0c6689029980" #   2022-11-11
LANG_COMMIT[meh]="e9a772c683706748c6cdbddff60a111082f88fbf" #   2022-11-11
LANG_COMMIT[mix]="7775235e722d143f76127828571114b006e760ba" #   2022-11-11
LANG_COMMIT[mk]="ad2b9b8de311d3e77aee1030d303371dc92aa430" #   2022-11-11
LANG_COMMIT[ml]="acd8d3dd92706d26bd08c5ba60dd02b8c37e8397" #   2022-11-11
LANG_COMMIT[mn]="57f769f57437c226b66a6769894434844bb08517" #   2022-11-11
LANG_COMMIT[mr]="f12186e1adb5767329acc951ea06532608c7c15d" #   2022-11-11
LANG_COMMIT[ms]="f7e252eeec3e71e2c7073dff771e322b815d107f" #   2022-11-11
LANG_COMMIT[my]="07b7db6adfc6c2733454bf1afb05bd77141d16e4" #   2022-11-11
LANG_COMMIT[nb-NO]="db7245d00e1da3defb54de2d61d1538e3b2e3244" #   2022-11-15
LANG_COMMIT[ne-NP]="8c2eccb12fd509326bd228b2d2d7e09acdc1ac40" #   2022-11-11
LANG_COMMIT[nl]="73579e56dbf8add781ff4d2e4e570fd067d196ca" #   2022-11-11
LANG_COMMIT[nn-NO]="e9487bcdb5282342218b4a2105a09b9862593964" #   2022-11-14
LANG_COMMIT[nr]="81375b6380671ca069707ce467ea418bee661ae8" #   2022-11-11
LANG_COMMIT[nso]="4c560b34b155d16934d8695cd019aa5b43c626d9" #   2022-11-11
LANG_COMMIT[ny]="71c243dbc087137e5c8ce9cd0f60a6bd5f08d38b" #   2022-11-11
LANG_COMMIT[oc]="da75f0f3902fa845e14da7069df8a0cac44f81e8" #   2022-11-15
LANG_COMMIT[or]="3abd90c4faa61636f11afc16658ce32ce2f3845a" #   2022-11-11
LANG_COMMIT[pa-IN]="187e54a1985e6262d5b7f62c5d5f4b7ee860e197" #   2022-11-14
LANG_COMMIT[pai]="2ce30764c0f94b1978c6d14e1744d490f4ab2840" #   2022-10-09
LANG_COMMIT[pbb]="07634a52bdd92750481b0f6799a3e806928b3ae5" #   2022-11-11
LANG_COMMIT[pl]="ef231623591e36a7a6b1da3bb82097027c7c489e" #   2022-11-11
#LANG_COMMIT[ppl]="68fb732ded4a332e5dfc008537a32b28ce7c17ba" #   2022-10-08
LANG_COMMIT[pt-BR]="af87d1cecbf68ef8f69c95688b7c703e2e0a287d" #   2022-11-11
LANG_COMMIT[pt-PT]="c570bea2b629b5f7971e712a8c69dbd5491b1002" #   2022-11-15
#LANG_COMMIT[quy]="5e15dfb8e7e786db1ab2df790ad11621b308930c" #   2022-10-09
#LANG_COMMIT[qvi]="d5da1a637ca132358d4b74370d346e0e98668c26" #   2022-10-09
LANG_COMMIT[rm]="a45444204332069d0f87c8025c11b7df868486ef" #   2022-11-11
LANG_COMMIT[ro]="9ffbc2ceb6181fb4bbdd1120aab4d214fa0e4d1e" #   2022-11-11
LANG_COMMIT[ru]="5a1f1bc030a90ca7744a493939fca64d1c2c7881" #   2022-11-13
LANG_COMMIT[rw]="44acb048a62ea9f06db7c478e82308ce6ec9352a" #   2022-11-11
LANG_COMMIT[sah]="3cffb1a2e75e8b3f5cfa41da736bfe042b9e985c" #   2022-11-11
LANG_COMMIT[sat]="82acb8f4a6af85a5bb1af3c7830eb6ab7cc63174" #   2022-11-12
LANG_COMMIT[sc]="79167694a1c44120cb2723e033c01b3cae687dfc" #   2022-11-14
LANG_COMMIT[scn]="92402878c982b800e4ae6306a782db7c4739acda" #   2022-11-11
LANG_COMMIT[sco]="23d508718e2eec29ca022904846521667f27e7f7" #   2022-11-11
LANG_COMMIT[si]="eb10989dbc2a562d470213dfb85744eacd0957a4" #   2022-11-11
LANG_COMMIT[sk]="13644000827f16007181ac018d9177162d1111b0" #   2022-11-13
LANG_COMMIT[sl]="9674961e6addbc96f8101a69dfd4d6118286faae" #   2022-11-12
LANG_COMMIT[son]="18e4d2bf56103d1392933fd4ef5a4a6ac4fbae0e" #   2022-11-11
LANG_COMMIT[sq]="3984b0ab22ef1f90de04c790d5f8d19f3d6c8166" #   2022-11-14
LANG_COMMIT[sr]="b23554764a98f98110ee7f28160a3ba37c264870" #   2022-11-13
LANG_COMMIT[ss]="aa7db164c5db21da3c2d52f565db5c3ee196def8" #   2022-11-11
LANG_COMMIT[st]="9f562cbfd77716cc66885a7cf15e11d4685b3c9c" #   2022-11-11
LANG_COMMIT[sv-SE]="9221f2de1dfdd9aed34e1e170ce6d940ee75b122" #   2022-11-12
LANG_COMMIT[sw]="815cad4ad5a7b1dddb17ac3e1d4725dde0fecf51" #   2022-11-11
LANG_COMMIT[szl]="a9531db9ab5bbb46292c64979282ccac3b1a0b56" #   2022-11-11
LANG_COMMIT[ta]="a00973956b73f7248d768f4be88bdc0610f18ff8" #   2022-11-11
LANG_COMMIT[ta-LK]="89b196ad4a3a096559b412144a8395c11a10e262" #   2022-10-14
LANG_COMMIT[te]="f9a331922d7b737e4f0c71254cbc300560fa578e" #   2022-11-12
LANG_COMMIT[tg]="b0f606d88f3882aa14e01bcc12f53530e961951e" #   2022-11-15
LANG_COMMIT[th]="b1909205bc3461da2b73208fad5b1a54dc22fd96" #   2022-11-12
LANG_COMMIT[tl]="1ff57d72c34403b2477b10aafe3d1aba2b5f6c59" #   2022-11-11
LANG_COMMIT[tn]="d12ad214e94ed970e861497076c18ecf8df8e3cc" #   2022-11-11
LANG_COMMIT[tr]="1219d70309867697be1b2d4f52602088ff3c1150" #   2022-11-12
LANG_COMMIT[trs]="38f72295b089a6eff1ccf5a44abde9ad9f058f59" #   2022-11-11
LANG_COMMIT[ts]="8906eac8751c64c9ca96a36ab9a087924548ed27" #   2022-11-11
LANG_COMMIT[tsz]="57e1bf1c99dd6e9d75a595a78c291ed0b05654e0" #   2022-11-11
LANG_COMMIT[uk]="6e47f12ba7dc53dcf31256d1d44b470f4b7ad550" #   2022-11-11
LANG_COMMIT[ur]="4a7f40ce682b741453ff49f8d68ce6c147f73240" #   2022-11-11
LANG_COMMIT[uz]="0cb8716e5048891dd6c7127cec3015081be23a7c" #   2022-11-11
LANG_COMMIT[ve]="8ec015f643bb78446b4877ab9e0a0112b905630f" #   2022-11-11
LANG_COMMIT[vi]="8683cb82053316dc2e91c49158cb1b6c59cc7d3b" #   2022-11-12
LANG_COMMIT[wo]="9fed112206ec06d6c0300c2a161757c8dd2a37df" #   2022-11-11
LANG_COMMIT[xcl]="ff9f97f48b03c012207d458bf4adb7529c1eac89" #   2022-10-08
LANG_COMMIT[xh]="03a37c88fc96d14a5a180e96eb126619239a00a0" #   2022-11-11
LANG_COMMIT[zam]="43d0e5675f28814d5e43ffd59ce7f0566adba1aa" #   2022-11-11
LANG_COMMIT[zh-CN]="c86f38a48e6452fa65dbd7dfaa51a278206e886c" #   2022-11-11
LANG_COMMIT[zh-TW]="fc717ad14f7c94e8c004e37a85a6de155d1514b9" #   2022-11-11
LANG_COMMIT[zu]="2f0b61d5133b81d5b4e44462d84331880380be43" #   2022-11-11

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
