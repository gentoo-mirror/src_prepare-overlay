# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="15c6c2229a053cdcc064eda89cee07f18efac35d"
COMPARE_LOCALES_PV="9.0.0"
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
LANG_COMMIT[ace]="66d668a720ec58c12081253e5be9783bb8e8b07e" #   2023-04-12
LANG_COMMIT[ach]="70651ee2c1cd0285da0f4b1e94e94975f1f6e162" #   2023-04-12
LANG_COMMIT[af]="6e185b3064c1cb378d0187c6442ab05418e8e2d0" #   2023-04-12
LANG_COMMIT[ak]="3ba2daa76378dba7de35d4cff2e77b4c64ed2cda" #   2023-04-04
LANG_COMMIT[an]="fe52b566fc6a971372cf1b97b99e045ce500e3f5" #   2023-04-12
LANG_COMMIT[ar]="7eda53415635ec11906e925f772ff3af4749ac0e" #   2023-04-12
LANG_COMMIT[as]="956cc7a53c2b847fdc64afa4f68fd8d9c26e50da" #   2023-04-12
LANG_COMMIT[ast]="f2836a6aa90569badc13af57429a426d8b15aa57" #   2023-04-12
LANG_COMMIT[az]="05589b01909a7e1b038a311cb059034e5d187f9d" #   2023-04-12
LANG_COMMIT[be]="9e2feb06957653a1a0795392a90f2fe39450c67e" #   2023-04-12
LANG_COMMIT[bg]="39d760c45706d8696ec2cbe9c624909dae7fca13" #   2023-04-12
LANG_COMMIT[bn]="7cf8046675aaaf2aebb17af0a57ef0e7f300ca98" #   2023-04-12
LANG_COMMIT[bn-BD]="4cddbe6239d3d0b3f19cb6e4427990b875fd691b" #   2023-04-11
LANG_COMMIT[bn-IN]="7451cd9ae34ef8d72b796d2cde340da527d25aaa" #   2023-04-11
LANG_COMMIT[bo]="0cc3a0e9389a222ce24574388eda7beea8cd99fa" #   2023-04-12
LANG_COMMIT[br]="00e08bdb921aecc37b11eb0d1b0b984164a99f10" #   2023-04-12
LANG_COMMIT[brx]="0e23cebc5e245249babb40230d0703a3860377dc" #   2023-04-12
LANG_COMMIT[bs]="163cde28af103df62a3c4d61036f4ce60fa9d468" #   2023-04-12
LANG_COMMIT[ca]="803561de5b801f990b2ba28be09429d196ecc70d" #   2023-04-12
LANG_COMMIT[ca-valencia]="13de60ecf36077bbaf83b5cabe94db7cae71b5d3" #   2023-04-12
LANG_COMMIT[cak]="8de3e5122f8942f740aa4b1aee93ecee2d31cceb" #   2023-04-12
LANG_COMMIT[ckb]="b3fc57bc691e58acc82a7ec797467b1ce3e80d6e" #   2023-04-12
LANG_COMMIT[crh]="b98c3377822428d2656158bba6e90cea16d26f3b" #   2023-04-12
LANG_COMMIT[cs]="1deccc0a8945cb47c27faf9f8ef3f04a33cefcfb" #   2023-04-12
LANG_COMMIT[csb]="467190657db886bccf43cd5d27b32ca2d748c876" #   2023-04-04
LANG_COMMIT[cy]="7d429d5a77c0bb57ae1e0771781acb2da362f207" #   2023-04-12
LANG_COMMIT[da]="fc93128fadf05762340c402300fcba8ee7f14294" #   2023-04-12
LANG_COMMIT[de]="e3db4c00b8500c713d1652a6b8a797ee15385f54" #   2023-04-12
LANG_COMMIT[dsb]="448e30426a7d78c7089eee805a60c8bf7e1a7b18" #   2023-04-12
LANG_COMMIT[el]="1e042f754bbfe854d7782f42040fbd7c7f88e1e8" #   2023-04-12
LANG_COMMIT[en-CA]="78055cc39d90f265f7840042eeb17c059b73eaac" #   2023-04-12
LANG_COMMIT[en-GB]="deb2a55089873a0f9bd25acc26057baf99dc8c6e" #   2023-04-12
LANG_COMMIT[en-ZA]="b73ec36db2c210b7684946b9ce28819049c89e31" #   2023-04-11
LANG_COMMIT[eo]="73db54575e6461ccf1f286d51a55dc1ebebec3eb" #   2023-04-12
LANG_COMMIT[es-AR]="bea6717a2018e097125ff0f2ed0ec62dfc76adc6" #   2023-04-12
LANG_COMMIT[es-CL]="8a1c114d62a183372aa4e699ce5e1801c091b2d5" #   2023-04-12
LANG_COMMIT[es-ES]="80da8a4d4c2eee09b0b63d3202f0f21c0ced2e8f" #   2023-04-12
LANG_COMMIT[es-MX]="988475fe8526646f12bb3e4b7f6fb0e296409544" #   2023-04-12
LANG_COMMIT[et]="f74a6257bed781752a54211631e45fa3e140e4f5" #   2023-04-12
LANG_COMMIT[eu]="6af2ac63085efa4fd3ba7a02542f183c4a890719" #   2023-04-12
LANG_COMMIT[fa]="eb0031df1558997e7a511eb2e3ca71300cc7039d" #   2023-04-12
LANG_COMMIT[ff]="cc43a798035ab72b69ec773bb08bbb9d71fa533c" #   2023-04-12
LANG_COMMIT[fi]="46d9d37a9b0871103f00c85d756c869d50e306b7" #   2023-04-12
LANG_COMMIT[fr]="2aeb60baabb991fc8413cc74a8df77529e2b33bf" #   2023-04-12
LANG_COMMIT[frp]="6ff21bb886310f5598d05258297994108536173f" #   2023-04-12
LANG_COMMIT[fur]="0f7e174cddd57323acc89eea3ed44edaaf1f690d" #   2023-04-12
LANG_COMMIT[fy-NL]="89d9a3833b254fcbed131c3f2a629e6485582c12" #   2023-04-12
LANG_COMMIT[ga-IE]="46cd03f43cd9e24efd5f82ce729ac2e1c1c02c83" #   2023-04-12
LANG_COMMIT[gd]="db59d2eb04edde45a64f4e425024ef17b144d51f" #   2023-04-12
LANG_COMMIT[gl]="594634118319f94d3a54c83d54cc93481af8fcf1" #   2023-04-12
LANG_COMMIT[gn]="5e17013779f4ba93f68a3990d61bb0aa09a1e5b8" #   2023-04-12
LANG_COMMIT[gu-IN]="766e678b12db4bad1fd782c9a6649786df18d2b9" #   2023-04-12
LANG_COMMIT[gv]="553cbfbe4f7c2a5101a75b2c6e518c6cd557bba2" #   2023-04-12
LANG_COMMIT[he]="c7d804b3f386db1947580fe567eb7e9da28157a6" #   2023-04-12
LANG_COMMIT[hi-IN]="c208680b77cb29ddb96b57af863c8f93d40e0069" #   2023-04-12
LANG_COMMIT[hr]="3d9c92d0994cf855b21609ed608fdf470043507b" #   2023-04-12
LANG_COMMIT[hsb]="262ba7b4bd27a8833e8df627d60f9da51f8f84dc" #   2023-04-12
LANG_COMMIT[hto]="87c85ae8ff12cf04d2e2a1cd272d7d3ac25b340d" #   2023-04-04
LANG_COMMIT[hu]="32fd10f52f6897254b78f2611acab975f957406a" #   2023-04-12
LANG_COMMIT[hy-AM]="c780230347d1df584672ba7dbeb2ce4a2e40acbb" #   2023-04-12
LANG_COMMIT[hye]="c3eb7838402868aeade63912748c966ee17fd0cc" #   2023-04-12
LANG_COMMIT[ia]="d3db054045a8b141d1c8354ce07f32449f36a225" #   2023-04-12
LANG_COMMIT[id]="34ef9394cba01057a514ef289ecb9c92446b7cee" #   2023-04-12
LANG_COMMIT[ilo]="e75c94ac14d06db441afa1145d4d7524ab85e5e2" #   2023-04-12
LANG_COMMIT[is]="8a9eddc6a0c0650151a7aedeb02e5339c3945fce" #   2023-04-12
LANG_COMMIT[it]="af7551e11d8c3e3a9ee164f9ec64aa80bc0f7ec7" #   2023-04-12
LANG_COMMIT[ixl]="6d788950ed115b29c3ebe35cc8b5bf340e074cd4" #   2023-04-12
LANG_COMMIT[ja]="588099512f946b4fb775f05fe3318407566fc488" #   2023-04-12
LANG_COMMIT[ja-JP-mac]="bb78385932a97c6ca27eb57c5bcbc84eae14ed00" #   2023-04-12
LANG_COMMIT[ka]="f60467b7980ec0569d0074c62c1573acb12f3323" #   2023-04-12
LANG_COMMIT[kab]="62d8e538a66ee1bc9e70b4c391abc7e820b24227" #   2023-04-12
LANG_COMMIT[kk]="76ce3f60610ce21893f1cec9f9199d8ed6b48c7e" #   2023-04-12
LANG_COMMIT[km]="c5f58ec181672e49febc814f7b385ae6751863c7" #   2023-04-12
LANG_COMMIT[kn]="cc814695ca43ccc2f8c23cbdc9e196a5b4114f7a" #   2023-04-12
LANG_COMMIT[ko]="e26bf99acab77a2ac8bd6f1667b2761af45d4f74" #   2023-04-12
LANG_COMMIT[kok]="23c2c82b9525de1abba71c09831b51e428079d2c" #   2023-04-04
LANG_COMMIT[ks]="edc187b5cb368758a5d370fa5c7ed3fe028c9f6d" #   2023-04-12
LANG_COMMIT[ku]="2de27d6bc56980c7a583bc3e21d860386ceab512" #   2023-04-11
LANG_COMMIT[lb]="afc82d4f12de0b5483a1095b8b52230d939ab932" #   2023-04-12
LANG_COMMIT[lg]="33d0272d4571b986d3952a680cefb19b19e2cc45" #   2023-04-12
LANG_COMMIT[lij]="56a88a57d48a7f42f90673e687e0449f10f05893" #   2023-04-12
LANG_COMMIT[lo]="5b89e21c8aaa5652a8a49e94556590164c39e205" #   2023-04-12
LANG_COMMIT[lt]="8bf6fd1f6dd88bcfddca1e519ea8cbee5d422464" #   2023-04-12
LANG_COMMIT[ltg]="9adbb0a499de710e37d810e0afecad278757e5dd" #   2023-04-12
LANG_COMMIT[lv]="0e7e84f7b2631ed80157ef98d77174d608933f7a" #   2023-04-12
LANG_COMMIT[mai]="1c2444dc6b423d8a20e50b337d59ecd4356af514" #   2023-04-12
LANG_COMMIT[meh]="c57aaba720b4efbdf71ed6728bd25edb51d02ed9" #   2023-04-12
LANG_COMMIT[mix]="6aae5f68ef653a73b7196c4ef2d0c6df4bd36397" #   2023-04-12
LANG_COMMIT[mk]="d68113036811b1d404338ff8b0ff732444f2a18e" #   2023-04-12
LANG_COMMIT[ml]="b458b8451b242b6a226d4e0e140033386b2e9cc4" #   2023-04-12
LANG_COMMIT[mn]="502c88a83a7526a8d92847e8cf613f016be6a1ec" #   2023-04-11
LANG_COMMIT[mr]="c7f53c0d3acdaa60ad03a446be7c96f9281a07af" #   2023-04-12
LANG_COMMIT[ms]="7b14f5de5990404b9c957ed8b84fbdef47a22723" #   2023-04-12
LANG_COMMIT[my]="625994f3199a3eadcd6ef5ac55f40474833c2110" #   2023-04-12
LANG_COMMIT[nb-NO]="8ca6fc0916f11de28174301754cb3ad5f6230b36" #   2023-04-12
LANG_COMMIT[ne-NP]="303bdcb996e50c046e2510a300a9beb86395d565" #   2023-04-12
LANG_COMMIT[nl]="152323b5b19060d70b0f7443c14c37af3876dd0c" #   2023-04-12
LANG_COMMIT[nn-NO]="d258f8eb7adff0adbfdc7217e9d8e0582c642a09" #   2023-04-12
LANG_COMMIT[nr]="f18d00af50d3f8ee68cdc297c6e3946e97fe8b2c" #   2023-04-11
LANG_COMMIT[nso]="117f0689f5f6598b88afd55772297d055dfe6108" #   2023-04-11
LANG_COMMIT[ny]="a299fbaaa3590664dbd9413f87e9bd9da1badb31" #   2023-04-04
LANG_COMMIT[oc]="770c0ae5b6c7812079eb52de19032aec97c56aff" #   2023-04-12
LANG_COMMIT[or]="6ec4e6ed7373f61b570ed04347d3dcbd1ffed799" #   2023-04-12
LANG_COMMIT[pa-IN]="e26d264958594781f57549fba912d213a60de711" #   2023-04-12
LANG_COMMIT[pai]="5055bd05ab7b6939d581978da82a8d6d7c2f73fb" #   2023-04-12
LANG_COMMIT[pbb]="2bb1ec28e06be56a5b71e1b90df7450031c81958" #   2023-03-16
LANG_COMMIT[pl]="a7fdbef724b1871c63cab2ab5c18f6cc47bb3b2f" #   2023-04-12
LANG_COMMIT[pt-BR]="5646e31f359940fd64272116fac938510bedf8ca" #   2023-04-12
LANG_COMMIT[pt-PT]="dbcd229e2a9b13e4f45c5e4e3f0175207d9afc0f" #   2023-04-12
LANG_COMMIT[rm]="a4d919e66226ecf6e7601f3fe2e5a1f49028c58c" #   2023-04-12
LANG_COMMIT[ro]="eddb5c2a2a67c153a8f040ed33a67deeca44bfc7" #   2023-04-12
LANG_COMMIT[ru]="afce3c58df6e9b8b0e9db5791c0f19378af600db" #   2023-04-12
LANG_COMMIT[rw]="d64158b2ee03a857e132a925a13f7481c0bb96cb" #   2023-03-16
LANG_COMMIT[sah]="7e7d831f7ff57d99c4526e421fa4bc8716e17ac2" #   2023-04-04
LANG_COMMIT[sat]="7c178e2753c7f44b339e4bb473b3cc3d1a63bcc3" #   2023-04-12
LANG_COMMIT[sc]="be437c04f80e638a6c987f8e1f020a770c0f9120" #   2023-04-12
LANG_COMMIT[scn]="0989755188dc19b07c3d0a7bdf4046f0285b76a1" #   2023-04-12
LANG_COMMIT[sco]="6f3c6a61e4f976da4af27fe0b49cebdfc4b62fbf" #   2023-04-12
LANG_COMMIT[si]="d9b5eabd07e43a21de8d40616e9a655739968cfe" #   2023-04-12
LANG_COMMIT[sk]="da352b8c68dce773e2ed476670eb92d895a34e67" #   2023-04-12
LANG_COMMIT[sl]="e62283b11742963ea52f7cec9d6f4a403e5be351" #   2023-04-12
LANG_COMMIT[son]="a2d4c3dd69fb730b7535dafb194e3984290a31d0" #   2023-04-12
LANG_COMMIT[sq]="91fff84cd7922436d3bddec8789ca14cbe62af1a" #   2023-04-12
LANG_COMMIT[sr]="fac15a944eac1161f981469e416169c5dd4ba08d" #   2023-04-12
LANG_COMMIT[ss]="3f1ce294f51133fd217cb35d9e9243e7e3ad7010" #   2023-04-11
LANG_COMMIT[st]="4555ea8f2512292fe4adfb8d2d9b948686d56966" #   2023-04-11
LANG_COMMIT[sv-SE]="91c7931206440d6392f3f7ebc4e1c5fe70679aea" #   2023-04-12
LANG_COMMIT[sw]="afa833e98d55bb1cda0725622833454431626ca3" #   2023-04-12
LANG_COMMIT[szl]="81934820fc5d84c4ad6f20fbd760bb35e4021460" #   2023-04-12
LANG_COMMIT[ta]="deacaec326686ec1383d13744f2f54de5c61a80d" #   2023-04-12
LANG_COMMIT[ta-LK]="5ae989b6840d1786fb13c528668b1f6990ac4d3f" #   2023-04-11
LANG_COMMIT[te]="7bff2e31e2e393642eb13279dd3eff22c11fb99c" #   2023-04-12
LANG_COMMIT[tg]="e96d1dd82a47630d2bb2a41a727b913fa970928a" #   2023-04-12
LANG_COMMIT[th]="f6ad736aa5c4459ac2fcbdc53070561ad6e7c0d1" #   2023-04-12
LANG_COMMIT[tl]="cb699323a89a35daebfc2f3314abd486c92a43f1" #   2023-04-12
LANG_COMMIT[tn]="b512a4d0fce1e5c44ec85e2466f21775dd3c968c" #   2023-04-11
LANG_COMMIT[tr]="5d5aa5454615d4dba7b5e53425ba521069da14d7" #   2023-04-12
LANG_COMMIT[trs]="01625593543de19d2bebea6691b9055cdfdece07" #   2023-04-12
LANG_COMMIT[ts]="db4e4fd6b96f2ca7a6f75331ea3f37fc0a739c43" #   2023-04-11
LANG_COMMIT[tsz]="3193079319e34a54b0f28b81defcf34fae8e660e" #   2023-04-12
LANG_COMMIT[uk]="020bd28bf3cb9ad35591b16e31424c0ca3a15b5b" #   2023-04-12
LANG_COMMIT[ur]="99b5e2743c608c8bf84f1a60a707a814112c90d4" #   2023-04-12
LANG_COMMIT[uz]="8f5db1e3e87cfd4ed3bf6be2fae573b876dbe5b3" #   2023-04-12
LANG_COMMIT[ve]="b8e92dc6b06339136b87d4ba33fcb41d79509253" #   2023-04-11
LANG_COMMIT[vi]="68b767788f49496f55b66a997723072c07e1b3e0" #   2023-04-12
LANG_COMMIT[wo]="296a6beba081e2990208752e9601b342195a5f98" #   2023-04-12
LANG_COMMIT[xcl]="c95e08e817aa118645a781ca1e5bd107be96c9e7" #   2023-04-12
LANG_COMMIT[xh]="424b38c7a3031fd51e93354b3533c087fd3e60d2" #   2023-04-12
LANG_COMMIT[zam]="fbcd06ec8e8a5af8bce945a361a09b899d83490c" #   2023-04-12
LANG_COMMIT[zh-CN]="bfffc0878bee051bc884e9fe3136991485f9fc90" #   2023-04-12
LANG_COMMIT[zh-TW]="1ffcbd21098b433ed9898aaa63cec0ef677fb9e5" #   2023-04-12
LANG_COMMIT[zu]="d49f1058d769c90905266e1bb8ee55b25fa8a145" #   2023-04-11

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
