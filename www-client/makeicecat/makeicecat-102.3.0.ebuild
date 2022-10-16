# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="10bd9dafbd9ce466720ff9539d91a3f96f482b56"
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
LANG_COMMIT[ace]="9179c92c2a0cff7f14c4dc27ce1501fe6fe16b83" #
LANG_COMMIT[ach]="225ac2bbc6b99187e4ec3ad52c10a3525b5a0475" #
LANG_COMMIT[af]="b5e6dd1fdab8a1b65782739445cbec474b57d909" #
LANG_COMMIT[ak]="ac35e2935d656ef85502b73680bc576f3244dd7c" #
LANG_COMMIT[an]="8830ea953c8176c973c68e64d20a2a1405d0048d" #
LANG_COMMIT[ar]="23466ad5ef60b740f9ad4b56c6564ea8f14fb7a7" #
LANG_COMMIT[as]="44fbab2f7aa521cdc19df79429f6b1c164eb6e22" #
LANG_COMMIT[ast]="697205cea83f4a1a640a72c9a6836b4070803e29" #
LANG_COMMIT[az]="370c69796160ad2d0b06227ae808e5a8dbb0151b" #
LANG_COMMIT[be]="e7514f183d9753ff6b47a5eaf551f98010e782af" #   2022-10-03
LANG_COMMIT[bg]="0284e53747b639033273999703fe9f0a63bd8ddb" #
LANG_COMMIT[bn]="0a1df11304d278e486dbcf9ef0c2dbd8b5c83918" #
LANG_COMMIT[bn-BD]="13e0dc04d69186677bd205b4cb5409fea239a5f9" #
LANG_COMMIT[bn-IN]="10b2fbff7155d7e563979596770d7e8cb766964f" #
LANG_COMMIT[bo]="58c34e90987d350235a1c08ca13b27441219fedc" #
LANG_COMMIT[br]="52dd5a6adbb229d101de59b276e284d2ff660f10" #
LANG_COMMIT[brx]="cb3c7d87a0fcfa88abaae0953fc6dbeeb79a9321" #
LANG_COMMIT[bs]="6ba5c4d194e35e0d106161c9dfade712e3f7ae99" #
LANG_COMMIT[ca]="486ca45733b56dc649e341596e7f93c92b558536" #
LANG_COMMIT[ca-valencia]="e10925efb5c24a38f23ac3a1eb7a3d88f8c47c4f" #
LANG_COMMIT[cak]="614f3c370200421442d7778609b42e23f0a376f8" #
LANG_COMMIT[ckb]="2cba7c400d143517aff1f10b91f10c7fd5916c44" #
LANG_COMMIT[crh]="03b95cb9a1bb67e44063ffeb203ca9730495be52" #
LANG_COMMIT[cs]="76c2a5820af1256ebe7bfbaaa9ad9b56020a9f9b" #
LANG_COMMIT[csb]="5ec2b14e6d8d4181dce27375277c7340763b4794" #
LANG_COMMIT[cy]="2ef41915003eca883074777bde58063eda85d31f" #   2022-10-03
LANG_COMMIT[da]="fa8d96d0df208cafde12a3586d6241cb3acdedf2" #
LANG_COMMIT[de]="15cec542a2e4932cfe00cec561cc94056d79e363" #
LANG_COMMIT[dsb]="f82ceea0acb0a290b0fdcce76aa0efaaafe908b9" #
LANG_COMMIT[el]="9b3ffdae11c0d82267cab9adfea986d30892f456" #   2022-10-03
LANG_COMMIT[en-CA]="1bddb0228211732807bd4f4101c94b5d7d9b08ce" #
LANG_COMMIT[en-GB]="14b0bb4b5d871df3aeb2ab83c0fe623a38f72094" #
LANG_COMMIT[en-ZA]="b8633757ec62f85e55d57e6f531b5a42156fabd6" #
LANG_COMMIT[eo]="091ad47dffdfed7a69313f0ae5293cf3b10e81b2" #
LANG_COMMIT[es-AR]="69a87f02a96cd1db0f59e015b53e8a85145fe063" #   2022-10-03
LANG_COMMIT[es-CL]="6841e2fdf41c5be88a25d1e72710d484bb851f44" #
LANG_COMMIT[es-ES]="eba953d85d098e1ced203b1a6ee5d36f17bdf77b" #
LANG_COMMIT[es-MX]="0ac92234bee0ad12c7abeda75cfac20ba2159e31" #
LANG_COMMIT[et]="41d73de4d22cdbaf2ddc1ce0b125eb39dd3440c4" #
LANG_COMMIT[eu]="2a7ec59d75593b41e0b1fda09264ab4f2b0b6f5b" #   2022-10-03
LANG_COMMIT[fa]="3f209549b029f124cf07de68afab497fe2a92a50" #
LANG_COMMIT[ff]="77f829c939e6fbab1475c9087538caa3a689899b" #
LANG_COMMIT[fi]="8f836012531790b4935a5b93ff3dc6c53a24d1b9" #
LANG_COMMIT[fr]="101eb6077b0365da7373fd29517c88c68f31ab32" #   2022-10-03
LANG_COMMIT[frp]="4bdef97929402be7cbc66b096a05573d7d5bfebd" #
LANG_COMMIT[fur]="4e3596275e8677c274f6a7c6a257de6220a93aa0" #
LANG_COMMIT[fy-NL]="ccdecd542e4008d2b3a942011bf61655994c04f5" #   2022-10-03
LANG_COMMIT[ga-IE]="3393549e36eeb73f38102e65e04b5ebd7be8e02b" #
LANG_COMMIT[gd]="96d6498d9ed7bc9694ce9fa09f7dcd684c2dea9b" #
LANG_COMMIT[gl]="302332a586d31589df590ce4085e78e6b4b0c0c9" #
LANG_COMMIT[gn]="08ad641e9828345d0a510b036d1337dc6f2a1860" #
LANG_COMMIT[gu-IN]="3faa2a52c561690fbff1dc0616313cbbb9fc373a" #
LANG_COMMIT[gv]="a7921b96413aac95ce7ec4871dc8a384939efa01" #   2022-09-13
LANG_COMMIT[he]="4458c83bbc9874a9273594851e04d0ff0a555c7d" #   2022-10-03
LANG_COMMIT[hi-IN]="86130d81c8db60845e61e4a32e1545ada2eb38b1" #
LANG_COMMIT[hr]="602e76f807deba5a70a6dab0c969cb1d35483d08" #
LANG_COMMIT[hsb]="5dba0a0351b931ec56cc951adb1f519f5cd40e96" #
LANG_COMMIT[hto]="7d32680239f0ec778bc342cf40b4fd76735699d0" #
LANG_COMMIT[hu]="26b2084ba3ac49805484818cf18c606578e1e93a" #   2022-10-03
LANG_COMMIT[hy-AM]="d5f1739fa0f3135bcbacd4d97228534f3853ba5c" #
LANG_COMMIT[hye]="56db842838946c2e9a9254db3241f70295751962" #
LANG_COMMIT[ia]="d6f35b237db4e2613f0dbad5fd4364291169c661" #   2022-10-03
LANG_COMMIT[id]="4803e7f1f18ed2163b8db045c3322dcf4b9221bb" #
LANG_COMMIT[ilo]="c262bcf9aae3fddfa8f38a68bd79d85d5e6f979c" #
LANG_COMMIT[is]="c666f3b9b5609863e0c722951a8070a8936459e0" #   2022-10-03
LANG_COMMIT[it]="e452535e4cdcb0712dd0764305d3a71085d96e10" #   2022-10-03
LANG_COMMIT[ixl]="247cae4829e129c9acc5d176a2d0d077e93fde2e" #   2022-09-13
LANG_COMMIT[ja]="fbb23130a06c110e6259460e35be3f5bf2f3dc41" #
LANG_COMMIT[ja-JP-mac]="e051bdda29e3f38eb43496f6afe112e86d28dad5" #
LANG_COMMIT[ka]="477feadeb29afedef0afcb73546371dfdb80bfe9" #
LANG_COMMIT[kab]="6b019841274f8ed29510e6f3f1c2acaf985ae5f8" #
LANG_COMMIT[kk]="8b902fb5f0e03ea2b4dcff42966bdbc843ad0d75" #
LANG_COMMIT[km]="9479322b96ba0c908feef67d68fbbdd4e985661c" #
LANG_COMMIT[kn]="4ebc2b589d4fb0b273855a4a0761962f0c781fd7" #
LANG_COMMIT[ko]="82d7c552030b12fd867cc875c5f920551a6225da" #   2022-10-03
LANG_COMMIT[kok]="a02fdb7634e3e2960f0a687bc4a66e0b49bbfe19" #
LANG_COMMIT[ks]="0afbee81e06e0a09ec696b1ed7a503af56cee49c" #
LANG_COMMIT[ku]="608c4cc5f6564cc599cf167f589d915cc9e53a3b" #
LANG_COMMIT[lb]="7549aa795e1a34ef01874cad5fee645f524361f3" #
LANG_COMMIT[lg]="714ba02731c2823c4dd2f118646edb5fcbcabdea" #
LANG_COMMIT[lij]="0c08da26891b0010e72ccade8a709c280975694d" #
LANG_COMMIT[lo]="d45e7b72d40ab2c9faf049bd65b90852e5bf3b04" #   2022-10-03
LANG_COMMIT[lt]="70781fa9f645418c80f43fcb4422f9864044d279" #
LANG_COMMIT[ltg]="ba76ca1eeb4b357996ea8a2b871e90e4ddff499a" #
LANG_COMMIT[lv]="b26353b58517445b2e4d2109174d6c045780d9c5" #
LANG_COMMIT[mai]="9befe683647955edbbc9d00004eec9530d1e1236" #
LANG_COMMIT[meh]="03b65676b1a48890fb2d18f4e7280f0a224b190b" #
LANG_COMMIT[mix]="fd846f736181fb7243a9125a5fbcd7db5db4e53e" #
LANG_COMMIT[mk]="1f88901e08bcd5de5a0ca93d08f328fed4cd5c69" #
LANG_COMMIT[ml]="af2f88feebb6c50891ec14f05ebd6f5b3c15f762" #
LANG_COMMIT[mn]="746d053d6db93c503a36feb5b8693ee469627321" #
LANG_COMMIT[mr]="8f096a78f62957054c1dd1655cf59bda9296e1f2" #
LANG_COMMIT[ms]="8d140405d54982e601038cc00b1118adb17cd3e5" #
LANG_COMMIT[my]="e5ffe3e74d4b588f6b0c90113c35e2bd0d47701f" #
LANG_COMMIT[nb-NO]="e3d6ec650052cc3294b34698c28ca35554ac7cfc" #   2022-10-03
LANG_COMMIT[ne-NP]="0ba1dcaf2680fad0e14353800d983cf4f02c99e1" #
LANG_COMMIT[nl]="ec7a1df34a08b936247e0cf7c2f17097035e1468" #   2022-10-03
LANG_COMMIT[nn-NO]="690309f421ec4779dacbf06c1d9f7a0221b2486b" #   2022-10-03
LANG_COMMIT[nr]="d50ff25acbfe8e312fc3126c3ee499c9cb1bb24c" #
LANG_COMMIT[nso]="f3bb186824ef782af17feda573f9183f6b5a3cac" #
LANG_COMMIT[ny]="239b7a430b788eebb5f43d3f3536a9058e6c60e3" #   2022-09-13
LANG_COMMIT[oc]="0b6bd58c943eccdcf37dffd3e62e1d889f28f335" #
LANG_COMMIT[or]="9ee279bcde4e3444d13cd890a6077d321f9d1b25" #
LANG_COMMIT[pa-IN]="5fff52115eab95e28910f31d0ef4a0e242ce4221" #
LANG_COMMIT[pai]="7a31aabb3d3d8dc1e2db163ed7496e7fe95e1215" #   2022-09-13
LANG_COMMIT[pbb]="14b8e1f68d595e354f74646d76c6b7eb39709884" #   2022-09-13
LANG_COMMIT[pl]="7209dc5642247540c83a802e0c0aef6dfddb713c" #
#LANG_COMMIT[ppl]="fe43d8860b063c844292ec5c626244e08932e2c9" #   2022-09-13
LANG_COMMIT[pt-BR]="a70077a22e6d00bae99c92b9df4837dd91a4bbc7" #   2022-10-03
LANG_COMMIT[pt-PT]="bbd9fc62d995414377d3ba5ad86a0e0c0e0792c3" #
LANG_COMMIT[quy]="4568b64b3a63b45ec87891854f73c150d6a8fcc8" #   2022-09-13
#LANG_COMMIT[qvi]="82121600c44fe54e2d93fe9406f93c6167d11aeb" #   2022-09-13
LANG_COMMIT[rm]="6abe3d96dc7f04c93721d22662f6959ff278bfc1" #
LANG_COMMIT[ro]="6b37b214f46549858b0d814d3c750e59b2c8ca44" #
LANG_COMMIT[ru]="1de2c212e28a802c9e8e2de090744c91511cb6e7" #
LANG_COMMIT[rw]="73a5076061553a016485a7fafdfb9dd9cac8609c" #
LANG_COMMIT[sah]="4dd126fb954a5275dd85cf8c91cc952b1cb4966c" #
LANG_COMMIT[sat]="0e552c74eb7353a19be3e3921d2ba1b174e61b17" #
LANG_COMMIT[sc]="a59756ebff2ea602bf5baef780f11865f4ca5358" #
LANG_COMMIT[scn]="b0d33830a148ac109e9892b7db9ed24a33bc0362" #
LANG_COMMIT[sco]="92ef23074bdcec75a9a7e28acd895168de28611b" #
LANG_COMMIT[si]="8c211a08738d0e3a9671a7f0e0189d3e6fb7fc2b" #   2022-10-03
LANG_COMMIT[sk]="95f872cf9214e73dbd91dbe9b4bf0a2031326300" #
LANG_COMMIT[sl]="4ae5a4c65e5f658d19688436679b870259e35bd5" #   2022-10-03
LANG_COMMIT[son]="c33300d1f208ff43b209172501c435c35a27c3ca" #
LANG_COMMIT[sq]="f1b165d801d478773bd49056bc0eef5333e863fe" #
LANG_COMMIT[sr]="15148d6a9f786c2f369c68043f1f767e5db91bdd" #
LANG_COMMIT[ss]="ee962e9f461e25f122d70a1cdc2282425a53766f" #   2022-09-13
LANG_COMMIT[st]="c2dec73b48713ab338f27e1659ad57478a617cf1" #
LANG_COMMIT[sv-SE]="76c3ac43ecf159e98582ce3f8ef27cb5fd017d79" #   2022-10-03
LANG_COMMIT[sw]="feb137475a4fd24ffea2048723b019a12bf84302" #
LANG_COMMIT[szl]="b0f7e4b0d7026847ec48e7c3911e8d4fb6474027" #
LANG_COMMIT[ta]="239bea0c9248cf1fb73b07c2f7007adbb8041930" #
LANG_COMMIT[ta-LK]="c82d3bc23a3dc9c2c210c70348e2eff571ae1675" #
LANG_COMMIT[te]="86fce5dbf6ff17755e791511d83b71dfa68e89e4" #
LANG_COMMIT[tg]="33d97281661e9deddffbb69e81b9af900703abe9" #   2022-10-03
LANG_COMMIT[th]="17483fc379351c8a47a06cf15feb3e8b6e676aa2" #
LANG_COMMIT[tl]="6c57f7c930580d1aa4e11ad0f4040465afc911d2" #
LANG_COMMIT[tn]="59fa7875a9e3a2c625fffaeb413f73eed1e2adb5" #
LANG_COMMIT[tr]="aa908e267ad96ae5d343f8b8156a3d26dd5c2fbd" #
LANG_COMMIT[trs]="b8524cf07f3a5a54acb7eb88de8da6ca1ad73b70" #
LANG_COMMIT[ts]="2777169e4219f26f00334e6e139f31f6c901a916" #
LANG_COMMIT[tsz]="91a65f5ff6132751427cb5099a6a840a7d6b727a" #
LANG_COMMIT[uk]="7f8c9865d2350e8b7dba6aaa653ae9a9c03eb748" #
LANG_COMMIT[ur]="3799a0b133d6a9b247764c7a88e8ab8faa60fd3a" #
LANG_COMMIT[uz]="c0b3ab8ecc2d77e8a232fcac222a0714bc70a722" #
LANG_COMMIT[ve]="8189f0c6ae0a97b50389e788b2b2baabd7d57a1d" #
LANG_COMMIT[vi]="42c7864d7943f76501982de121237fd1751c9f2b" #
LANG_COMMIT[wo]="4445a78a7c4677a4b33da6c06696cbf3efdf3ab9" #
LANG_COMMIT[xcl]="2315bf2449869ecb9d0e8d5e0bfce79b5e77e803" #   2022-09-13
LANG_COMMIT[xh]="7d09b23653550b943c758d0e7b225aa77f9ab236" #
LANG_COMMIT[zam]="72ac0f7801e7903c210814ef3273b2c1a4660eba" #
LANG_COMMIT[zh-CN]="8727ba2055584ea02f1d8f2b339d93f71f19e9be" #   2022-10-03
LANG_COMMIT[zh-TW]="6e875d09b6278550024362a3745c35046b3c8069" #   2022-10-03
LANG_COMMIT[zu]="3921a4d11fbee8bddc8b00c2471939e80d1211fb" #

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
