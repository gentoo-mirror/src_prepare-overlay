# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="76e23c5f1bcebc22f7936baa29f75c6c9415935e"
COMPARE_LOCALES_PV="8.2.1"
SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz -> firefox-${PV}esr.source.tar.xz
	https://github.com/mozilla/compare-locales/archive/refs/tags/RELEASE_${COMPARE_LOCALES_PV//./_}.tar.gz -> compare-locales-${COMPARE_LOCALES_PV}.tar.gz
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
LANG_COMMIT[ach]="ca0b326717cd19dbbfb2fe7e06835b02cfcd413c" #   2022-03-01
LANG_COMMIT[af]="162654a20c86192e124df9766ec5ecd54143d085" #   2022-01-06
LANG_COMMIT[ak]="016d55423f1da4b5de32ee8cbcf7898118d12473" #   2022-01-06
LANG_COMMIT[an]="d10834e1c7ba839ba9c372205f4371c4d3c19791" #   2022-01-06
LANG_COMMIT[ar]="11550f5f34f7c4bb641cd62369bc9c198248618c" #   2022-01-26
LANG_COMMIT[as]="b44ae7a12113d545a666f18033c91858d368273b" #   2022-01-06
LANG_COMMIT[ast]="41dcea23a9d890ee00cb4cc3797559fe461244bc" #   2022-01-17
LANG_COMMIT[az]="0366cdbc61ed5620510c848b85cd593d376c75f3" #   2022-01-17
LANG_COMMIT[be]="897cb09ca19681ef501d1189c76c5ea615bc20ee" #   2022-03-10
LANG_COMMIT[bg]="63f8a2ceb6b4fb9181f2a2c0787a57ac761798a0" #   2022-03-09
LANG_COMMIT[bn]="010d5f74034cb2c18fd1100e0d0888a245d52a60" #   2022-01-17
LANG_COMMIT[bn-BD]="3d534d7d3797931d9d886e28dbd6657b4ff7a1cb" #   2022-01-17
LANG_COMMIT[bn-IN]="fe46ec9c6a1fab36c0715dc2a5df86f957a531ed" #   2022-01-06
LANG_COMMIT[bo]="97059fd9d1a83e254bf84da12f1612062e82d271" #   2022-01-06
LANG_COMMIT[br]="858100c5ec0740e1894d1272de9a1b4e2d72b33e" #   2022-02-04
LANG_COMMIT[brx]="573ec21d6a1aebf6a342533bb06b77c79b6e994b" #   2022-01-06
LANG_COMMIT[bs]="9ebb98165b36860f938bfb97c1956090e8daf920" #   2022-01-17
LANG_COMMIT[ca]="b35533a04d39e8e730606457779dd062dd48e2ab" #   2022-02-28
LANG_COMMIT[ca-valencia]="d8f8751d595bf879afe5bfa8e3854ee5b6d1b977" #   2022-01-17
LANG_COMMIT[cak]="c5a21feab0ea049d75d3e561ee820fd358808143" #   2022-02-22
LANG_COMMIT[ckb]="bd043d903599db44feb371bf29d4a3d510a48a0a" #   2022-01-06
LANG_COMMIT[crh]="ee017344c9935dbaac5e737fdb7b396944ce92d0" #   2022-01-17
LANG_COMMIT[cs]="0db27529f03a826cefbe85a1bc69407eba1a7a5f" #   2022-03-10
LANG_COMMIT[csb]="cfca971fd3676f22b831325bdcaf89d2dae8da6d" #   2022-01-06
LANG_COMMIT[cy]="5ffdbce76d19a933f249d743b4b86718d4d886d3" #   2022-03-04
LANG_COMMIT[da]="fd84b250aaaac3bd04689c470e77d18a5f45d2a9" #   2022-03-10
LANG_COMMIT[de]="56ff351cf482ad38528182234edac44f0087f9c1" #   2022-03-07
LANG_COMMIT[dsb]="38cc93fb03ad0e5de63bd7fe64c92ebabe3fcd8f" #   2022-03-04
LANG_COMMIT[el]="58cba6811bcb1a2e12ae29f0779e795260a24e78" #   2022-03-11
LANG_COMMIT[en-CA]="4952938ad641b86d96b0192368a205155de7e236" #   2022-03-10
LANG_COMMIT[en-GB]="85760d047ff2bb3f20073209c86aafae484a6c84" #   2022-03-10
LANG_COMMIT[en-ZA]="8b696d61e2f653738e1e9d38086f0464bc4c5f9e" #   2022-01-06
LANG_COMMIT[eo]="879b99194c7b241e4a68b6ea73f295c41539db01" #   2022-02-13
LANG_COMMIT[es-AR]="f5cc658c6b839b162de5797001ad668d29893675" #   2022-03-07
LANG_COMMIT[es-CL]="69f094a3764c584b9e7874b159b8589186cc68f4" #   2022-03-10
LANG_COMMIT[es-ES]="319c0498b8ce5efc2b28a8db15e352b59e018e72" #   2022-03-06
LANG_COMMIT[es-MX]="6bbb04feb45ad4bfa0120fb7c7671707715f0802" #   2022-03-04
LANG_COMMIT[et]="1aba2882c8f586b6e1e9e8b9f9ff478d8cbe757c" #   2022-03-07
LANG_COMMIT[eu]="ed8fb7ed0677c4b36a5b50cfb07a1e968bb9a6d6" #   2022-02-15
LANG_COMMIT[fa]="fb843f2121544da95b60b20d7147be7069091be2" #   2022-02-15
LANG_COMMIT[ff]="ec175d67f9056e5fd2cb6568ee546336efb77d5c" #   2022-01-17
LANG_COMMIT[fi]="d6b1e0e2960aa927f6bcc592090d1604a19bd2b3" #   2022-03-11
LANG_COMMIT[fr]="9963097e0253b1764a16878312b2e6e520e24f12" #   2022-03-11
LANG_COMMIT[frp]="1f7e8a74a38847bb61bdaa59b9c4087232409beb" #   2022-01-06
LANG_COMMIT[fur]="f7443e146b5c0bcef3c4afa8df76af7e24967854" #   2022-01-17
LANG_COMMIT[fy-NL]="525b48e470451349ab47d71ad36770cba52199f2" #   2022-03-04
LANG_COMMIT[ga-IE]="2d955174d7ab6068656b2f02e4d8c689bb2399bf" #   2022-01-10
LANG_COMMIT[gd]="00dad207fa7a90fb3f30d81fc309767eed8b9b8b" #   2022-01-20
LANG_COMMIT[gl]="12d14b505e0fc7ab9ca38b3d3e4530acb008fff8" #   2022-01-20
LANG_COMMIT[gn]="732d85374962d672a2d327768c8bb3330fc1852a" #   2022-03-07
LANG_COMMIT[gu-IN]="d2c670d798b925090af6321cb3270fa6f806108d" #   2022-01-17
LANG_COMMIT[gv]="f2fc53ab3d11da177cc94ad7ed6e136ab27bf269" #   2022-01-06
LANG_COMMIT[he]="07e79613f2ffc7838533f4ae6c6debff28243276" #   2022-03-05
LANG_COMMIT[hi-IN]="274838883f7f1f14d5f14d5116e7df11cc404911" #   2022-01-17
LANG_COMMIT[hr]="871e4180f68eee9ac04971ff6b554e4dbc2711a2" #   2022-02-17
LANG_COMMIT[hsb]="7bf0d7626b741924c31993e2de2cc8bf6f290be5" #   2022-03-04
LANG_COMMIT[hto]="dc63a5c6a9c9cc98602262b039b6b11c76d628e5" #   2022-01-06
LANG_COMMIT[hu]="84c0be34c19b120e759c16bc563d402bd06435d7" #   2022-03-08
LANG_COMMIT[hy-AM]="76e644e70ae151b603d04a2a30cabe994f1e8f99" #   2022-03-03
LANG_COMMIT[hye]="ec61290a1e8ccf117bdc8dada4df52f6c3a5eafc" #   2022-03-11
LANG_COMMIT[ia]="5b24c38a30bc283b206317538d855971d187ad89" #   2022-03-08
LANG_COMMIT[id]="bf6607f76e4bf783224434d34273ff8052d6dc1c" #   2022-03-08
LANG_COMMIT[ilo]="a0b9dc5857dbdecc57f876f053014002cf2305cd" #   2022-01-06
LANG_COMMIT[is]="ad2f0be42bcacac30793521562823428fbae17dc" #   2022-03-07
LANG_COMMIT[it]="54af3c3b3c86df54f3790e90ad57e4d6969590dc" #   2022-03-11
LANG_COMMIT[ixl]="f76c5867094658a58456e202779f5216235fabac" #   2022-01-17
LANG_COMMIT[ja]="6127a7d5900012673428cb1a7bc210fcf37a6892" #   2022-02-24
LANG_COMMIT[ja-JP-mac]="f863997fc8afeaf63fd4bf34c2e32b3fc2ff83f3" #   2022-02-24
LANG_COMMIT[ka]="57696226c9d7e0da3f801f10f412601e6fa6e773" #   2022-02-28
LANG_COMMIT[kab]="34cdd7ae3a2706650cb51cc379fb0c2b25516169" #   2022-02-06
LANG_COMMIT[kk]="5e3e0fa81b7f9c082c04e6b57aa94f970eaf8405" #   2022-03-11
LANG_COMMIT[km]="c04f31c98e50315177467bd4e079200d3b38b835" #   2022-01-06
LANG_COMMIT[kn]="0bc693a82c819a27e71f41828c040e7be4b92785" #   2022-01-06
LANG_COMMIT[ko]="3c8eea1a24357a0a8fbd4753116cd2f57d567ded" #   2022-03-05
LANG_COMMIT[kok]="018ac9d9490b9fe77e3ce9106dea30b0267446d4" #   2022-01-06
LANG_COMMIT[ks]="f4054f6adbb2bd896ad8d41011cf699d23e088ec" #   2022-01-06
LANG_COMMIT[ku]="188de086338d1a719909bf4266035d17c4ff329e" #   2022-01-06
LANG_COMMIT[lb]="669793c5dcd5f3f83ad212448042938a6b9b7040" #   2022-01-06
LANG_COMMIT[lg]="a7feffb631646312c88e2d1c03047e805841f911" #   2022-01-06
LANG_COMMIT[lij]="e46553ebd09bbabad095ccc4c8b7d147f895a475" #   2022-01-17
LANG_COMMIT[lo]="942d94da48979eb60bcd62d825f7f9337314999f" #   2022-01-06
LANG_COMMIT[lt]="8899012a5deae631071e7c6c97d6f30db8e8b739" #   2022-01-26
LANG_COMMIT[ltg]="06e42a8ee9e5211fa8812542a6bd3c22e3c540ba" #   2022-01-17
LANG_COMMIT[lv]="0059bd3f14ced8ec1ef0f2765b655fe4ee537e91" #   2022-01-17
LANG_COMMIT[mai]="c7d1b95f94a004d63cec7215aeac4fcc60d98929" #   2022-01-06
LANG_COMMIT[meh]="ab5e76a788d771d5d000a535491177c61843cc76" #   2022-02-08
LANG_COMMIT[mix]="71f9cc54878550e63a59129386a1c16c8d46730a" #   2022-01-06
LANG_COMMIT[mk]="c473f0b380bd14c98754cb38cdc287c5b0df99a0" #   2022-01-06
LANG_COMMIT[ml]="94e82a9b8446e0d56c3344b20c90af26082a65f6" #   2022-01-06
LANG_COMMIT[mn]="1e68058a8a8462eb225781cfffa9b08517218275" #   2022-01-06
LANG_COMMIT[mr]="b3382076ee961b51f0e2a7369c08aaf03fb8574d" #   2022-01-17
LANG_COMMIT[ms]="ec4c315ae032575bed799d8faa57dd4441e5bd9e" #   2022-01-17
LANG_COMMIT[my]="25d516d33a6c2f8881683c5530f468e2c25ab6eb" #   2022-01-06
LANG_COMMIT[nb-NO]="33dfa5a0d42d000ebac52ce7db1f6481b052a338" #   2022-03-07
LANG_COMMIT[ne-NP]="5676e8e0b93e18fb5eeb238953c512d4f407340c" #   2022-01-06
LANG_COMMIT[nl]="7681577ccd67db0f9ca4aea28ccec45ece291bd6" #   2022-03-10
LANG_COMMIT[nn-NO]="2f3b8387e940cbe3b4ab14ff63004c86120b26e5" #   2022-03-07
LANG_COMMIT[nr]="b812f24744280f56682cf2ada7f252c3d10b5230" #   2022-01-06
LANG_COMMIT[nso]="284888d07de6a01f08acf74c0005938261be25e1" #   2022-01-06
LANG_COMMIT[ny]="b6c1a809d12fb11656d255e3792b0af62557d527" #   2022-01-06
LANG_COMMIT[oc]="c765e20c1c3eef04af44317ea8ebba476eedb1f0" #   2022-02-21
LANG_COMMIT[or]="dd4117a6306811f85bd427c15023597a8cdb802f" #   2022-01-06
LANG_COMMIT[pa-IN]="bbfc43db3f0349eff76131142d6621b1d45e21ab" #   2022-02-12
LANG_COMMIT[pai]="c83cfee2ebb4d0ba889d11bf3bf612652985fc0a" #   2022-01-06
LANG_COMMIT[pbb]="7f952a799823c4684a7d9222588ba2de6b3069d2" #   2022-01-06
LANG_COMMIT[pl]="b5bede664c2c72bc84224e5a06d68ec50dc834b0" #   2022-03-03
#LANG_COMMIT[ppl]="26ee9bc20a9361b03653b82bdae58bfa87e1797b" #   2022-01-06
LANG_COMMIT[pt-BR]="fab690d92adc8c139e28febfa885ddf2e77ccaba" #   2022-03-11
LANG_COMMIT[pt-PT]="0b617311049e134ecae4c878bd044900a6efb29a" #   2022-03-05
LANG_COMMIT[quy]="9c3130f42c678b15ce1d536d565b740612596c95" #   2022-01-06
#LANG_COMMIT[qvi]="cf1900a2362788f000d14e27673f59cf0e4aa972" #   2022-01-06
LANG_COMMIT[rm]="18d7e4d45c4ad3fbc21a100b6636a4b59bd0fa54" #   2022-03-11
LANG_COMMIT[ro]="ba7fe96d6c98e01a48f442d520c39d119c7e0727" #   2022-01-17
LANG_COMMIT[ru]="b9ab2d2eef8d47fa318fa9426b219578be525109" #   2022-03-10
LANG_COMMIT[rw]="48cbd9cb539b75ab37a5808383fcbc0887a44a0a" #   2022-01-06
LANG_COMMIT[sah]="12fb102e7bc76dab1456ed0b88fc14c73f981ca9" #   2022-01-06
LANG_COMMIT[sat]="0de095cca53ff565cf6389f985484650ac040029" #   2022-03-05
LANG_COMMIT[sc]="14a1b41f804a89dd00d978056ebfc966a638cbb8" #   2022-01-17
LANG_COMMIT[scn]="6729c4bfb82228012e51e2077cf8f2ce254e8fe6" #   2022-01-17
LANG_COMMIT[sco]="8aed4c4ac1dd708f213d350a46617cd3faca0a09" #   2022-01-17
LANG_COMMIT[si]="639820754f8563d1fccf89f48c4b155db6a3ae8d" #   2022-01-06
LANG_COMMIT[sk]="edfaf263c80b0960417b8a6be690fe50e9885eba" #   2022-03-11
LANG_COMMIT[sl]="6053d3cb4b127b4183ce98db96a6751ff72367c2" #   2022-03-11
LANG_COMMIT[son]="1541de0c90d66751ae72c24d4fa8105a585cf203" #   2022-01-06
LANG_COMMIT[sq]="59c3b12c92b684e02fb1afeb55d6ded8dc482ea4" #   2022-02-25
LANG_COMMIT[sr]="fc2038de2801930ce585dd1817c3de3367523630" #   2022-02-14
LANG_COMMIT[ss]="82188bb8444fb9b1436f72664c5d4ca49d1ae316" #   2022-01-06
LANG_COMMIT[st]="ac23a90a715031a3d31caa8fd83c6cbe6f75a6fe" #   2022-01-06
LANG_COMMIT[sv-SE]="00a61ed637c2488de5f984fe456a0e0b83a8ceb2" #   2022-03-05
LANG_COMMIT[sw]="82318e61508faba1806a969e15810fe8c280bbdb" #   2022-01-06
LANG_COMMIT[szl]="000ee773591f17bcd9fc5ed5eb504000a016ce5b" #   2022-01-06
LANG_COMMIT[ta]="2545635e99da1c3bdfc3536ba8c6a68a7498d014" #   2022-01-17
LANG_COMMIT[ta-LK]="ed472d476e6823843f16cf7fb54a4e0272d16610" #   2022-01-06
LANG_COMMIT[te]="0c5e4eb71c5ffe04c651f377355ead0f976960cd" #   2022-01-17
LANG_COMMIT[tg]="1283ef9a2a61e3575193b4e5377b0060e0af49b7" #   2022-03-08
LANG_COMMIT[th]="9851b1b2c1594f01f864b31022000a028e94676b" #   2022-03-08
LANG_COMMIT[tl]="383d5cda5177e3939e57f8e063529704fb16586d" #   2022-03-11
LANG_COMMIT[tn]="335e015d7dfc8ae5639660d1907b7fdb7b02e037" #   2022-01-06
LANG_COMMIT[tr]="2a2b9977d4fc880d77fe36fe12e32da230f2cbd6" #   2022-03-10
LANG_COMMIT[trs]="43debe20e58afdd09ddbcd2f7dd62039c1e8c5f8" #   2022-01-06
LANG_COMMIT[ts]="c399d15ac7c8b32ffee8bdac14539181ea7aab37" #   2022-01-06
LANG_COMMIT[tsz]="d47c303e79c080e90a0ec9337a75a843c729bd21" #   2022-01-06
LANG_COMMIT[uk]="df036958b06b84677db002f84930357cc037013c" #   2022-03-10
LANG_COMMIT[ur]="82344f16acf39a52197f34072719c4b6ff4fda98" #   2022-03-09
LANG_COMMIT[uz]="9bf0718f3dc3c70e34fdf556c3006adde39a1635" #   2022-02-09
LANG_COMMIT[ve]="d4f51eb857143131eb70733a15fd558e14ab727d" #   2022-01-06
LANG_COMMIT[vi]="2d977dd67e626dc4d4d0664f81c8579e4409548e" #   2022-03-07
LANG_COMMIT[wo]="625cc2e007db82c90ecddd39e34f1969c4088e09" #   2022-01-06
LANG_COMMIT[xcl]="6d6d615e1753f149a4c00788dac23f98acc0f5c7" #   2022-01-06
LANG_COMMIT[xh]="09a4bf9ceb7fe52e7fd54b2c8a15c16c6a4c56f2" #   2022-01-06
LANG_COMMIT[zam]="4840c22c1cdffa89f4ba2ed3341ed1a2572c9f93" #   2022-01-06
LANG_COMMIT[zh-CN]="2d1b8ba1628e2df9a19c491d61cc32eb0d9f86e9" #   2022-03-09
LANG_COMMIT[zh-TW]="351ae4819a294e000d4def3134653ceacea2257f" #   2022-03-04
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
