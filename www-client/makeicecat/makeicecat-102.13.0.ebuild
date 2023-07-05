# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="8c8a8ecc9322b0954e3d51f661866dbde1e6b1c3"
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
LANG_COMMIT[ace]="0ecf2958c534656785a5d6eebe1817afb39afa19" #   2023-07-01
LANG_COMMIT[ach]="4e17e1e77c9523c58aeda386cb3d84c1b7d0593a" #   2023-07-01
LANG_COMMIT[af]="fa7b8c513c7231823681cb309c1ef35ce8daeabb" #   2023-07-01
LANG_COMMIT[ak]="8f6c59468fc0fc201da33bf6f2924236c343b99f" #   2023-06-20
LANG_COMMIT[an]="e75c2da8a8bf2c24240bb8467b7163575d8d545e" #   2023-07-01
LANG_COMMIT[ar]="04d89e8cf121d9e2a8d69e39a2380b8d6bfdba9f" #   2023-07-01
LANG_COMMIT[as]="cb4ace1ae411b193fb9f9035bebffa97af76167d" #   2023-07-01
LANG_COMMIT[ast]="405d6ec8003b5621104f5fb6f17a832e1b3b8dad" #   2023-07-01
LANG_COMMIT[az]="e85cd9623002567b591568e2565704336c1df391" #   2023-07-01
LANG_COMMIT[be]="18886dd71a17167df1c856cb0c2ff964d8ffe57b" #   2023-07-02
LANG_COMMIT[bg]="0a87f0078f89d711b75f2e8ed31cca27bc565654" #   2023-07-01
LANG_COMMIT[bn]="a4c9a9ba5a6fc5ce2c0cafdf59a71debee94c0ba" #   2023-07-01
LANG_COMMIT[bn-BD]="4ffb46bdba6680c561e36d497de193e7708884b8" #   2023-07-01
LANG_COMMIT[bn-IN]="ab669fa1755eb42c302ebbcc9da300d8b9c4723f" #   2023-07-01
LANG_COMMIT[bo]="c82b50531c934aba5ba1079a8ae79e98ac0fd9d2" #   2023-07-01
LANG_COMMIT[br]="d88cabd9389bd5e6d788beae211cf9967c01f193" #   2023-07-02
LANG_COMMIT[brx]="aaf9acbb14ebbf34b70a4ec1345c63fe7bcfd730" #   2023-07-01
LANG_COMMIT[bs]="181a12d687981f11cacc9df9234d500844c05db9" #   2023-07-01
LANG_COMMIT[ca]="5492cb68c2688ff5b2266aad1fb980b5d0d93351" #   2023-07-01
LANG_COMMIT[ca-valencia]="05ee21cb5ad580475188021d230f1d7dce85c565" #   2023-07-01
LANG_COMMIT[cak]="7e00047f3f3b67c9fae8ea6520bcca856d025aa5" #   2023-07-01
LANG_COMMIT[ckb]="a7d9025b030fbf2cf0e296f586921f3571339e44" #   2023-07-01
LANG_COMMIT[crh]="3b47a3cf050c305db3ae38740a4c45bef48568d6" #   2023-07-01
LANG_COMMIT[cs]="720922580769bc51dd4f73976c68dd77a20900ef" #   2023-07-04
LANG_COMMIT[csb]="3ec2c297a7d53ce783a3e96a77aa5dc14287d214" #   2023-06-20
LANG_COMMIT[cy]="1c03e7b9fd6b338c12081384997034dfbe809d49" #   2023-07-01
LANG_COMMIT[da]="33ed18fe633d04fbad458c914dc7f7d6070b215d" #   2023-07-01
LANG_COMMIT[de]="517992545c1c5813093eb4d394d0fa7004ffdecc" #   2023-07-03
LANG_COMMIT[dsb]="3ee74aeb149e13d8065ae664843acb911a68cfa5" #   2023-07-01
LANG_COMMIT[el]="8c189549a7a7d85c601ecf0df21149a6fb38df92" #   2023-07-03
LANG_COMMIT[en-CA]="1271a440940366c88fa88a628d38e67736297f51" #   2023-07-02
LANG_COMMIT[en-GB]="901f76a351c7919c3113bb942d399260e518f7b7" #   2023-07-02
LANG_COMMIT[en-ZA]="e362698704d8209dc2c95e1604adc62aa145342b" #   2023-07-01
LANG_COMMIT[eo]="1817479b8d0d657c996cd8790370fa5fb26c9962" #   2023-07-01
LANG_COMMIT[es-AR]="714fcb24fe55901f84f5f4876e67ad564a5e712c" #   2023-07-03
LANG_COMMIT[es-CL]="3152405bb11373b36b69ad83dafce3af51b9808e" #   2023-07-05
LANG_COMMIT[es-ES]="dcdb527125d31d44cce45dd388cc52270c46ac9f" #   2023-07-02
LANG_COMMIT[es-MX]="323c865ed33372ef6a588905427fc9e104dd26a7" #   2023-07-01
LANG_COMMIT[et]="2c15d578f5f304b20dc1f15a2f7bc19fee16667d" #   2023-07-01
LANG_COMMIT[eu]="4c78797c89de0e17c9f645b91b38a27bbfa96a3f" #   2023-07-01
LANG_COMMIT[fa]="38e68809390cd672b16d9bd678a8fe9cf3852914" #   2023-07-01
LANG_COMMIT[ff]="3939073496a6174c1224598dfdc51ccc68cee06a" #   2023-07-01
LANG_COMMIT[fi]="86add346d7c2b4db4806fab65fe152979f86692e" #   2023-07-04
LANG_COMMIT[fr]="4c1a3669ec42914ad1d28d68a1d7e7295fc89104" #   2023-07-03
LANG_COMMIT[frp]="6e1664e7304c134fa0a262faf3811c7838c9aecf" #   2023-06-02
LANG_COMMIT[fur]="a00aef29c4db1489a0d5332c1accf4fc9af7c45c" #   2023-07-01
LANG_COMMIT[fy-NL]="aec26423e260fbfc028638e96538604706f246f7" #   2023-07-01
LANG_COMMIT[ga-IE]="bbe1070c91f4c39a9a6df9133cdcda4ccdbbe443" #   2023-07-01
LANG_COMMIT[gd]="d734dcc1f9c0125e9772482a340a0166442fc494" #   2023-07-01
LANG_COMMIT[gl]="c5b5df50c3f59841f41f73ada784dbfcfcd488f1" #   2023-07-01
LANG_COMMIT[gn]="f2e20913b92db1978a1a0f54307b17c175b544b7" #   2023-07-01
LANG_COMMIT[gu-IN]="f8b0acf8d87e941b7b1dc6a05cc192f7c83d8336" #   2023-07-01
LANG_COMMIT[gv]="74b7a18b3de7038151f2f764ffb83ea3a92d2f62" #   2023-06-02
LANG_COMMIT[he]="e18790863ddfc255b38f81e664cf36cfcc391f49" #   2023-07-02
LANG_COMMIT[hi-IN]="360ef218685ad6df6e30e984ecd19359f4772be5" #   2023-07-01
LANG_COMMIT[hr]="3fb750d2d32b2fb82360b0e4ad9e3612a7c877aa" #   2023-07-01
LANG_COMMIT[hsb]="553e719c66531c3fff51872a92b510e1ed9c3728" #   2023-07-01
LANG_COMMIT[hto]="34fa520611153941e735843b2117dde48a6c5ecc" #   2023-07-01
LANG_COMMIT[hu]="05fb9131fefe05deccae0bbbdf5b58304d29c924" #   2023-07-03
LANG_COMMIT[hy-AM]="df27c5215b348c678475ec0350bb7fc877234e85" #   2023-07-01
LANG_COMMIT[hye]="2fc02378a102a8a06e0e14d5e5cc1929c89f307a" #   2023-07-01
LANG_COMMIT[ia]="946c897ba3a85d75b2cf8e6985d795c8d5359304" #   2023-07-01
LANG_COMMIT[id]="79b8216c6d5e23c1ba529aa9243df4fe8abfc09d" #   2023-07-01
LANG_COMMIT[ilo]="4a5ab2f0fa44b99d4874657c86e3477e6c88ce5b" #   2023-07-01
LANG_COMMIT[is]="3c7a6b9bdecb23088a1bbc9fa1a1bac0446714df" #   2023-07-03
LANG_COMMIT[it]="932c6ab44aed725bd8939608a6612e61896109f7" #   2023-07-05
LANG_COMMIT[ixl]="b8c422b5104dc29935fbb907ca51f683c5f8ee86" #   2023-07-01
LANG_COMMIT[ja]="fe15884508a307960fab0ac713053dfd110e7f2e" #   2023-07-05
LANG_COMMIT[ja-JP-mac]="e9dc8d179ab621429e08a2218c054790c9d321cf" #   2023-07-05
LANG_COMMIT[ka]="6cfe9c9631fd82d15ee45c5e7d5b007794b2c3e2" #   2023-07-01
LANG_COMMIT[kab]="dcef941a4482fa3e8d1064d161e7427aaf8e2c8d" #   2023-07-03
LANG_COMMIT[kk]="a0437385e06b20db03ea77a5eac6a560ab91a7f7" #   2023-07-04
LANG_COMMIT[km]="ba16b17886082fb810a78d7a65e38d7c02ee09d4" #   2023-07-01
LANG_COMMIT[kn]="0de4876300c0c7b6cd5b307472cdceddc9c8f9ce" #   2023-07-01
LANG_COMMIT[ko]="541f9ca5e9c4d732a154f0277b835c194d0d93c8" #   2023-07-01
LANG_COMMIT[kok]="ef6752b06a90e95600a36b290b4a59a0e7b058b6" #   2023-06-20
LANG_COMMIT[ks]="eb4fd03e9e77b750b667578f0c9789267d0a11ef" #   2023-07-01
LANG_COMMIT[ku]="e8f4a54b0e080ac7e177db167b94d196b6d434e7" #   2023-06-20
LANG_COMMIT[lb]="5d15b17f3e16752af4f548b206196126bdf79866" #   2023-07-01
LANG_COMMIT[lg]="0215fc288e9ddf9064fde868d1d4e0d82c46359a" #   2023-07-01
LANG_COMMIT[lij]="7fba0b8ec0b14dbc14a292179bb1f07ac23df54e" #   2023-07-01
LANG_COMMIT[lo]="9cc9641456d1eeed7e6d69d41edd85baa87e14a9" #   2023-07-04
LANG_COMMIT[lt]="f0110b677db2a58afccf2bb3247e28f0984799f5" #   2023-07-01
LANG_COMMIT[ltg]="d1e52ac0fb5c3e03a4dc2cd23e5c5d55494f5091" #   2023-07-01
LANG_COMMIT[lv]="d756c6ec7be226fe7c251189cdd19d24ccc3420b" #   2023-07-01
LANG_COMMIT[mai]="69c63a2f86fb17db314edcd7ec82f1332fc7eb27" #   2023-07-01
LANG_COMMIT[meh]="541118e22e796e6a568c81b36065359cefca7c3a" #   2023-07-01
LANG_COMMIT[mix]="4749e8b9437564b67dac46a8f4d5714680218758" #   2023-07-01
LANG_COMMIT[mk]="63d09b86235664125ee82190eba557c7dd77ea05" #   2023-07-01
LANG_COMMIT[ml]="8ccdaaaa7cba951d0737d05c3f98f354c1b984b0" #   2023-07-01
LANG_COMMIT[mn]="9a8454f29b3ccfa56f4c8f10d92a4c8e70c32bea" #   2023-06-20
LANG_COMMIT[mr]="d498536a6c47e27ad1f36709fe8830890c8a8479" #   2023-07-01
LANG_COMMIT[ms]="919c32354367833337290d232fba0fc89c093ccc" #   2023-07-01
LANG_COMMIT[my]="579eed31993eb0de38380d03f9f0e578560ef1c7" #   2023-07-01
LANG_COMMIT[nb-NO]="8c443342c4b51f36d30ab098e6fe755436091175" #   2023-07-01
LANG_COMMIT[ne-NP]="38039a18a65d8fec236aaf1f785144d2bd13ed86" #   2023-07-01
LANG_COMMIT[nl]="58c914c92a09d688be3526b355512258d546de57" #   2023-07-05
LANG_COMMIT[nn-NO]="f81a2d623353292b93f55027d17421135c23fc34" #   2023-07-01
LANG_COMMIT[nr]="e33e0a77961ec364fcd61f145e6894caa71bf4aa" #   2023-05-24
LANG_COMMIT[nso]="2366b63c75b28a6cb6f9a933adf3efcd7bb436bb" #   2023-06-20
LANG_COMMIT[ny]="13e38343b3343ac42b57dc610d42936fe0735125" #   2023-06-02
LANG_COMMIT[oc]="8250687ff36cd07dec6e86a9633c8df9fe074c69" #   2023-07-02
LANG_COMMIT[or]="6673b99bc67b8dd4a270e46c8a57ae0dc7814e23" #   2023-07-01
LANG_COMMIT[pa-IN]="fe2ed4a92e87c6ffe89dccd0e4bf6fbd838027a4" #   2023-07-01
LANG_COMMIT[pai]="ee8dfd4a03e491e08b86b8866dbe545134e83ce3" #   2023-05-12
LANG_COMMIT[pbb]="a5e7217f128c7331379797a91823ddebb9e03c32" #   2023-06-20
LANG_COMMIT[pl]="76ddcc1f886c95e475ac16f485de9974507939ed" #   2023-07-01
LANG_COMMIT[pt-BR]="c8132f3fc15663154a79c13aaea954e38d72557e" #   2023-07-03
LANG_COMMIT[pt-PT]="bbc658b20c65f86b10d63c54d2547fea15ba6093" #   2023-07-04
LANG_COMMIT[rm]="9152b04a6b18e1d51a6f44e1b5b58a5325ac012a" #   2023-07-01
LANG_COMMIT[ro]="3e8e0ca066fc2bae8b308c5e0bdff2c817f9adfb" #   2023-07-01
LANG_COMMIT[ru]="025e440f6edc08cc118f6fb542b593c910f633f0" #   2023-07-03
LANG_COMMIT[rw]="fe683a44163ff39ef3e27e646022cc52b91bb24e" #   2023-05-24
LANG_COMMIT[sah]="ac51376905e222e00cd2540941066f304b8bd063" #   2023-06-20
LANG_COMMIT[sat]="81303f98fc08c272b0eed7b8c2a57798fbd04c68" #   2023-07-04
LANG_COMMIT[sc]="37dc88179caea98cd6a045d7521b8a3e907ed4dc" #   2023-07-03
LANG_COMMIT[scn]="d9cf60e5e4896d0f2b413b7ef3f29571e480208e" #   2023-07-01
LANG_COMMIT[sco]="a659e6eb2a29ac1bb19e42483ea9fba5acbb549c" #   2023-07-01
LANG_COMMIT[si]="e000f085c27c51dedafb8f4e53ccc6bb976311a9" #   2023-07-01
LANG_COMMIT[sk]="7035ad29cfe885e900bb0f5a64f1b9fb7db84eee" #   2023-07-03
LANG_COMMIT[sl]="b32ac5d738202a151076ee49116df129b807c0a5" #   2023-07-01
LANG_COMMIT[son]="ca2a5b6711611d4248b9786defce7f350f66e718" #   2023-07-01
LANG_COMMIT[sq]="d99d715d39fb0513610693916f1750e260d851e9" #   2023-07-03
LANG_COMMIT[sr]="474c8b68e4492ee58f1b67bd31aea3ff86712b8b" #   2023-07-01
LANG_COMMIT[ss]="7cc03c62377db992580701b9fc7b1c44e677c842" #   2023-06-02
LANG_COMMIT[st]="d64229d1cbab6a1fdd2a6c2f9d4e66a344400ef0" #   2023-05-24
LANG_COMMIT[sv-SE]="d177aca1a917383848d935b6850c7bc00b60c260" #   2023-07-03
LANG_COMMIT[sw]="27da7bf45730ad0d8ce40732791a46cf393c7728" #   2023-07-01
LANG_COMMIT[szl]="8dc6d542949fed08564f38c55c3c80f8e82217de" #   2023-07-01
LANG_COMMIT[ta]="ec9657b099a09ab33734e04b92c1a9d8ad69ebc1" #   2023-07-01
LANG_COMMIT[ta-LK]="8799e6abb692941a330c1661089b07eb904cc1e3" #   2023-06-02
LANG_COMMIT[te]="a24d9608ee2430120ed62bbb78a91f067c3bf6ee" #   2023-07-01
LANG_COMMIT[tg]="9ddf15b7905f15752cb7d744790cd2c8014bf5db" #   2023-07-03
LANG_COMMIT[th]="44694e0a90f7a238b6924ba9ba2b124da779d087" #   2023-07-01
LANG_COMMIT[tl]="81c7378eef479f22c02f4f44d83f2c2588b30c6b" #   2023-07-01
LANG_COMMIT[tn]="7106e6ac8251158d71b805584cb73167373051ff" #   2023-06-20
LANG_COMMIT[tr]="653018437e77f1d59d67c797bd627aaa09c9aecc" #   2023-07-01
LANG_COMMIT[trs]="e9efb22317e9a7896c0ca4b4caccecba8422298c" #   2023-07-01
LANG_COMMIT[ts]="3bb939aa67a7b2c17c13e0bd02292fdbd06dceb5" #   2023-05-24
LANG_COMMIT[tsz]="7e4a22890cf3b8527800660e39eca1427109fdd9" #   2023-06-02
LANG_COMMIT[uk]="a5f30a0e53198949537e799a0491cdfd4103b27e" #   2023-07-03
LANG_COMMIT[ur]="bd02ea3c6b99d8a564d49e8a15e7116198c7968a" #   2023-07-01
LANG_COMMIT[uz]="6e375e43c4ef554d2326bbcae78d570368d9a1cf" #   2023-07-01
LANG_COMMIT[ve]="ae9c793afa0a5d4b5cc78e6bb971d4c2e4297aed" #   2023-05-24
LANG_COMMIT[vi]="d95303b80355fed8c3fc66962216b01c422926ce" #   2023-07-01
LANG_COMMIT[wo]="144187aabccd4390442529ab5322acde7f289db0" #   2023-07-01
LANG_COMMIT[xcl]="b487e1f6d282a0ddaaf36acc7f87b8f7550a60e3" #   2023-06-02
LANG_COMMIT[xh]="61c43139c4b46a7e703ebfff7fffb2c5fe845ef4" #   2023-07-01
LANG_COMMIT[zam]="73244c2c853bed99b788a787491e282aa7286712" #   2023-07-01
LANG_COMMIT[zh-CN]="2b8a709da82648151f89f39121534d174f0a9e69" #   2023-07-03
LANG_COMMIT[zh-TW]="4dbe1d77189db58d6ab004690244a4de9611f0ec" #   2023-07-01
LANG_COMMIT[zu]="c4b3b98bfb705dbe73e8e4c27376855c7dc7976e" #   2023-06-20

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
