# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="b6260130b9808f550bdb35061af2d7962109a181"
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
LANG_COMMIT[ach]="8d3ebd2c3d4510b1f6856cc57188d8a9537149d7" #   2022-12-08
LANG_COMMIT[af]="c7ef4ef38d94d82a9ecb75a957cd03905896100e" #   2022-12-06
LANG_COMMIT[ak]="39f31b1337cc053a33b78ec1955211d1b5c61589" #   2022-12-06
LANG_COMMIT[an]="12520ab637c5deb3986b0fc05072eaf5faaeee31" #   2022-12-08
LANG_COMMIT[ar]="268eb35c9e907bc8f421b4f9ba28f241229b0f82" #   2022-12-08
LANG_COMMIT[as]="c44bae97a6b187936941eda60ef500fb4411aa92" #   2022-12-08
LANG_COMMIT[ast]="fbdefcaf6ff44cb5eb6d6e4522972d03f99e813b" #   2022-12-08
LANG_COMMIT[az]="a2839c49e43e56ffda5979770d2552856170d798" #   2022-12-08
LANG_COMMIT[be]="3db1f33ae53f9c07dc57e27712e60482aed778d7" #   2022-12-11
LANG_COMMIT[bg]="b477c52a2dda8f8436a92f3aff2a761d2bd87382" #   2022-12-08
LANG_COMMIT[bn]="6a6e832d9bbd470f406af7c83107b9ff7733f2a5" #   2022-12-08
LANG_COMMIT[bn-BD]="6a998105df8f081c7cf0ec83823009e719385c7a" #   2022-12-06
LANG_COMMIT[bn-IN]="cdb16747965fd60c70e5e997a4ff78b6b7f98e07" #   2022-12-06
LANG_COMMIT[bo]="a7e0855098ca72382228996b84a2a3acaf48170e" #   2022-12-06
LANG_COMMIT[br]="835006ee2bc305fe42f8c14c22d640f7375d89d6" #   2022-12-08
LANG_COMMIT[brx]="61abe97619e2f85c69fdce966cfbb6b69276d67b" #   2022-12-06
LANG_COMMIT[bs]="bd7b38d95105497c36b5a90ef2effa5d91dbdb3a" #   2022-12-08
LANG_COMMIT[ca]="1790626dbe2d0f634bf157fca147b2b1cb1444f6" #   2022-12-08
LANG_COMMIT[ca-valencia]="ec45edd0986a3f7da62d3f90897d0c8e740dde3d" #   2022-12-08
LANG_COMMIT[cak]="267413d0f044a470a17ce841eee1df5cc46a37e2" #   2022-12-08
LANG_COMMIT[ckb]="15d3f5c160ab429c1a93d6b729201f997e62e80b" #   2022-12-06
LANG_COMMIT[crh]="f1e4766c15431e6d09cb249ec95ecd9339cd97df" #   2022-12-08
LANG_COMMIT[cs]="dc095d606977df62edf539ccf4ae9e0cead4fb3c" #   2022-12-08
LANG_COMMIT[csb]="3d354fc67a857faedfc2a4fc3adb88ce75dffac9" #   2022-12-06
LANG_COMMIT[cy]="120eb086d6753673b6def9483fdf11bdbc988e3b" #   2022-12-12
LANG_COMMIT[da]="d1649e6e97659b3822e72882d511aebb097e3f58" #   2022-12-08
LANG_COMMIT[de]="0e851eaddc16a076b822a702b70eab5261896a5a" #   2022-12-10
LANG_COMMIT[dsb]="4e01f98586c10afe6a5a4828aec2c371a258892f" #   2022-12-08
LANG_COMMIT[el]="9b21b21d8268163579fc65ee9e7811c4e69e7f6b" #   2022-12-09
LANG_COMMIT[en-CA]="2902fafc49cc302ac18f5738778b303d68586938" #   2022-12-08
LANG_COMMIT[en-GB]="2e96d4bba90956054690094977f8f5b962300baa" #   2022-12-10
LANG_COMMIT[en-ZA]="08554496b4bd0616c6e8fc610df2cdeadde2c311" #   2022-12-06
LANG_COMMIT[eo]="807727f30e1b2b8cd0c97c0c1a05e27b3dbf7422" #   2022-12-08
LANG_COMMIT[es-AR]="2819486cb36189474fc92a6be13e4723331acfbb" #   2022-12-12
LANG_COMMIT[es-CL]="3f10bba0a5ab3018b1019cafc58dea59682509e6" #   2022-12-12
LANG_COMMIT[es-ES]="a514ab8dac6b259f20126cbebf6cc05629e3f21c" #   2022-12-09
LANG_COMMIT[es-MX]="2d98a1da61ed32dfe298b295d98e3e4ec6b1e964" #   2022-12-10
LANG_COMMIT[et]="b8b25a07e0562def2ca3068b9d6e9dc47eefdfa4" #   2022-12-08
LANG_COMMIT[eu]="e2d2ef92c6c3e4db79768b867154a7fd33a0da6b" #   2022-12-08
LANG_COMMIT[fa]="06425e279bf6fcbdfe4c16e1ba443ee7fd0ccd6e" #   2022-12-08
LANG_COMMIT[ff]="eac907de123b8d17d5aa16058a3def582baa4cce" #   2022-12-08
LANG_COMMIT[fi]="8bc0ce8c2291823c88becb66fdfb300346367c64" #   2022-12-08
LANG_COMMIT[fr]="e0b9abe1a2d8a1dd8e36b33f1e7df1e32426edf4" #   2022-12-12
LANG_COMMIT[frp]="cdfaed741ea8774c11648f312e92b78574df0f9c" #   2022-12-06
LANG_COMMIT[fur]="c2f441b051256452cba8752fb489dfa82299b614" #   2022-12-08
LANG_COMMIT[fy-NL]="f495ef7cf3bd2063c183877c27bf198823dd3bba" #   2022-12-12
LANG_COMMIT[ga-IE]="7ea558190d40f37151077317baa5f4a09e060200" #   2022-12-08
LANG_COMMIT[gd]="1f9f38d1086d66126f12d350723b0abfaab61af4" #   2022-12-08
LANG_COMMIT[gl]="b8b2c54f27367322f9da4a48d4d2b95aa75a7c04" #   2022-12-08
LANG_COMMIT[gn]="9de4d252073fef61af9c06b33a82022ffad68c60" #   2022-12-12
LANG_COMMIT[gu-IN]="815349c12192368bbfbfff871f2c9e0fe6940ad3" #   2022-12-08
LANG_COMMIT[gv]="64ad0d0ec14cff5c6daff00fa0e84220e2ea93fd" #   2022-10-08
LANG_COMMIT[he]="587bcde2bc3ad027c8f06bd7c0ccfa072d6d0a11" #   2022-12-10
LANG_COMMIT[hi-IN]="7a7a48af6d10e5d21e72ca1c1117effdab4db4c6" #   2022-12-08
LANG_COMMIT[hr]="53172b90871cf14c4b8a446da159b694abe7d813" #   2022-12-08
LANG_COMMIT[hsb]="7b0a71a990a133dc05dae260c18fa20d6aaf43ab" #   2022-12-08
LANG_COMMIT[hto]="ac067766910d7acaf4cadd490fe4f11420189c7d" #   2022-12-06
LANG_COMMIT[hu]="36b742f2633eb9a6eb855aade44f231b73d07374" #   2022-12-12
LANG_COMMIT[hy-AM]="58929ef006bbc3743175751df91c2b8a7ffd4191" #   2022-12-08
LANG_COMMIT[hye]="17019943d9701ecd22ddf7784357d406b06a1ba7" #   2022-12-08
LANG_COMMIT[ia]="d335272c54e50c98a614171219935de1476ab46f" #   2022-12-11
LANG_COMMIT[id]="8c612b4d5012a095a1ef4d0d92b0d0ca67df0493" #   2022-12-08
LANG_COMMIT[ilo]="674ffd0c2d49a71d7f85406f469839f0d9927028" #   2022-12-06
LANG_COMMIT[is]="10e3d8f3449393ff845a78aadb4ca703f8b19d10" #   2022-12-11
LANG_COMMIT[it]="95f994fa77bbca762ea8f3a416a7fa4faff594f1" #   2022-12-10
LANG_COMMIT[ixl]="45b609a976d9235fceab20c1d21ea18cbaf1c3b0" #   2022-12-06
LANG_COMMIT[ja]="101dccefe077350d44d3b13322e2ccb1fbb4ecdd" #   2022-12-08
LANG_COMMIT[ja-JP-mac]="385e9715aef81f593cd0abe2b065ba7e709b937b" #   2022-12-08
LANG_COMMIT[ka]="691ecdacb13fe7c3fe3f393d686d860d0a617dc7" #   2022-12-10
LANG_COMMIT[kab]="edd32f521539c668d7fdde27d8890dcaf552e914" #   2022-12-11
LANG_COMMIT[kk]="38390a5160a6b34616b772f0761876bc3422013e" #   2022-12-10
LANG_COMMIT[km]="8d9362063e8b91c9c97e577e360f7b86401549a7" #   2022-12-08
LANG_COMMIT[kn]="390d5e732ad8b3b07ea02e9f7416f760c254b6c8" #   2022-12-08
LANG_COMMIT[ko]="dbfabb40b888ca027dc35296784572200168c9d6" #   2022-12-09
LANG_COMMIT[kok]="fc3591d7819c44a333961189cccb19604be7ddef" #   2022-12-06
LANG_COMMIT[ks]="52539fb50e0a7dbf2ed2d1e05b60d83c7e40959e" #   2022-12-06
LANG_COMMIT[ku]="8822fa74466ffc0a11f486967f5a1582da966fd4" #   2022-12-06
LANG_COMMIT[lb]="5d87ac9994c0a4832d48573d8690c2c64370db9e" #   2022-12-06
LANG_COMMIT[lg]="eb637eb3c204c070cf3fc919d2d810e4b2bc17b0" #   2022-12-06
LANG_COMMIT[lij]="42a6b178cb2f8012dff8858336d4dbf89c5d6b80" #   2022-12-08
LANG_COMMIT[lo]="f48ecece4bb2642c67bcd31aabce5ee6480fad3a" #   2022-12-12
LANG_COMMIT[lt]="665459b9db807fa6826e733c7a9655ff61825c61" #   2022-12-08
LANG_COMMIT[ltg]="9023da67a2f7ecca490fe182af2569dde53bc48a" #   2022-12-08
LANG_COMMIT[lv]="8bbed05338fb631908730fac02283827cf1c2c01" #   2022-12-08
LANG_COMMIT[mai]="feba00fb12686a09f0f3e7c4be20817f67a275fb" #   2022-12-06
LANG_COMMIT[meh]="f32ec5e69c4b482254c68b7cb19896a91bb76cb3" #   2022-11-23
LANG_COMMIT[mix]="49e59f31ad307f63133bbbcd77c8b1eddbc0e812" #   2022-12-06
LANG_COMMIT[mk]="b2f4721f0ff70e663c226fcf1426596899dacb76" #   2022-12-06
LANG_COMMIT[ml]="7e926516fa851d0eb803618c3bce6e56a83e25e2" #   2022-12-08
LANG_COMMIT[mn]="f8a512d8dc9e9e2326e0e6cc1520e4245fdf1129" #   2022-12-06
LANG_COMMIT[mr]="4c60bf3f4fbf7a9a2949d8fe376118f2f9843666" #   2022-12-08
LANG_COMMIT[ms]="d20189e6ff4d6b6c6e168583bd54ccbca91c21a0" #   2022-12-08
LANG_COMMIT[my]="0dfef291efd18a66f6e026a302c3c5a6a03b8c5b" #   2022-12-08
LANG_COMMIT[nb-NO]="5b90e5e29af60af132951fb7d16cc8831a8309ad" #   2022-12-10
LANG_COMMIT[ne-NP]="02a2c9886bf282a966b481f1c2590998f9703c10" #   2022-12-08
LANG_COMMIT[nl]="4b449cfb957fbb15bd13d96ec2c8719b850bffa5" #   2022-12-12
LANG_COMMIT[nn-NO]="09766fc8afc1332924f729cead8159966a8974fe" #   2022-12-08
LANG_COMMIT[nr]="83faa1f3c54319d332d5cb10c008c2e89469acf3" #   2022-12-06
LANG_COMMIT[nso]="4148b93ded64173d0e4251b3faa6dc42d12aaddb" #   2022-12-06
LANG_COMMIT[ny]="2a80ad975a97bac62214625f0116a281a8a6417f" #   2022-11-23
LANG_COMMIT[oc]="5e85d47ab18eb01c2f5c39e1ee18f8c14075dd16" #   2022-12-10
LANG_COMMIT[or]="c4255677a01e69d34bff881b20fa37080e6ef45b" #   2022-12-06
LANG_COMMIT[pa-IN]="31a8950ef7f8a743bad356bb8cdb27acdec0706b" #   2022-12-08
LANG_COMMIT[pai]="06be2b29db2e9ddbbd83279649691cec5cd442fd" #   2022-11-23
LANG_COMMIT[pbb]="3b4756cf2d503924dbab03f2072e54bb7b7d027d" #   2022-12-06
LANG_COMMIT[pl]="7e745d5615de6783cc0a3342290a0bcdb09d090d" #   2022-12-08
#LANG_COMMIT[ppl]="68fb732ded4a332e5dfc008537a32b28ce7c17ba" #   2022-10-08
LANG_COMMIT[pt-BR]="27fa4c6349fe8475b0347a398d45c57a5fc84fd2" #   2022-12-11
LANG_COMMIT[pt-PT]="f905b397bdd8f554897df0313fe08c670944baa9" #   2022-12-08
#LANG_COMMIT[quy]="5e15dfb8e7e786db1ab2df790ad11621b308930c" #   2022-10-09
#LANG_COMMIT[qvi]="d5da1a637ca132358d4b74370d346e0e98668c26" #   2022-10-09
LANG_COMMIT[rm]="886ef40b1695fb5aed6feb6da30289659c5f66dc" #   2022-12-08
LANG_COMMIT[ro]="bef47bdd78d745cb64a909bf7a7da1b1ad91318d" #   2022-12-08
LANG_COMMIT[ru]="d07bbb1936f8309caf1074d3f1246e58e1db668d" #   2022-12-11
LANG_COMMIT[rw]="da13152ef1446168c2b34a21bf8a5c7d7e82c78f" #   2022-12-06
LANG_COMMIT[sah]="41cab61a69748da1e777e10cf54ca6be9f7f4f7d" #   2022-12-06
LANG_COMMIT[sat]="245c5364843b50b9ff5e36630b39c4fd0bda6250" #   2022-12-08
LANG_COMMIT[sc]="c1ef9867770f8d7cd584b53f48b0fc18a059021f" #   2022-12-13
LANG_COMMIT[scn]="283982fa0bf0d263ebe5e794d591606d925a85f0" #   2022-11-23
LANG_COMMIT[sco]="e3795914f9a137908cc988ea9ed70e9ed2b26ab1" #   2022-12-08
LANG_COMMIT[si]="c9447ba3ad3aef08fce46f8286c89a52f7176d28" #   2022-12-08
LANG_COMMIT[sk]="cc776a43a9fda3f28b71bae84ffc726f80145ccf" #   2022-12-11
LANG_COMMIT[sl]="1cbaae4753ca9f064cf22899826a97255198a147" #   2022-12-09
LANG_COMMIT[son]="f652b76420babb324e5204e555caa7795c8d0779" #   2022-12-08
LANG_COMMIT[sq]="7851f34c0272176d285b9707804a78b8af1d83d3" #   2022-12-08
LANG_COMMIT[sr]="767a358d4d8424b688e395f60525caa9a36d9a57" #   2022-12-10
LANG_COMMIT[ss]="27735c9cfe9d6c80bdc8bedee149e217c7775bc9" #   2022-12-06
LANG_COMMIT[st]="d90559b1501f4327e3f8b56b8e4b5918b0e36ce2" #   2022-12-06
LANG_COMMIT[sv-SE]="04a468356dc10dbfc85d44cf42380de7aee75d30" #   2022-12-09
LANG_COMMIT[sw]="68c9632090efb6e1568510ad6ef197c64f3910a1" #   2022-12-06
LANG_COMMIT[szl]="d5e7a1936a70536073b26225d314485d6b717f85" #   2022-12-08
LANG_COMMIT[ta]="fa112f64c7df6c462229b8a9582d88cd7f86088f" #   2022-12-12
LANG_COMMIT[ta-LK]="cc8618dce68f582760c3f0d8eb60bdf1ba73cfc6" #   2022-12-06
LANG_COMMIT[te]="d5f19dbecf1df87fa71e053a9edbf3de19389b65" #   2022-12-08
LANG_COMMIT[tg]="1e6532fcf1aeda5bf35b01f7402052b67230a6c2" #   2022-12-11
LANG_COMMIT[th]="819538b281e75ca22cb1ca977c49cb22f14a0e62" #   2022-12-11
LANG_COMMIT[tl]="9ee734a3d2b1d784f3b03ca12f353054c7642272" #   2022-12-08
LANG_COMMIT[tn]="cbb2c6db93ae572a30219da13a0b9e8d664e4ebf" #   2022-12-06
LANG_COMMIT[tr]="3f10241449310365e9317b8166765cd34ebab6bc" #   2022-12-12
LANG_COMMIT[trs]="cd56d5613544a01f00eb34da66baa57e3ef0ac68" #   2022-12-08
LANG_COMMIT[ts]="1b6a6cc07b1143aa6e73defcd875ff83fb9d75f4" #   2022-12-06
LANG_COMMIT[tsz]="206f335ae3761af8790ab3d81f3a2828f3f82d93" #   2022-12-06
LANG_COMMIT[uk]="a4f963096a7bb4f62b04c786a857085dfbe1525f" #   2022-12-11
LANG_COMMIT[ur]="429f56ac6793a23ef4d082ba6be72d5a2f63a767" #   2022-12-08
LANG_COMMIT[uz]="346e80caa273c443a8b85fa0a406e73793e1b3a1" #   2022-12-08
LANG_COMMIT[ve]="55a7364a9531de49755998a363037697ef2f9424" #   2022-12-06
LANG_COMMIT[vi]="a467eb48bf5dd5bee28875257d35f22af51464e1" #   2022-12-09
LANG_COMMIT[wo]="1cca38f3cf74de10dc72108c5fe03b7ae4dd693e" #   2022-12-06
LANG_COMMIT[xcl]="ff9f97f48b03c012207d458bf4adb7529c1eac89" #   2022-10-08
LANG_COMMIT[xh]="df55117e95026b20c4efd77d453b28367b2358a8" #   2022-12-06
LANG_COMMIT[zam]="d97d9897e08bc93cfa7534cb817bbcb36deb15b4" #   2022-12-06
LANG_COMMIT[zh-CN]="28af32964cd38cf246cd8320f95b9ac11a1bc3e7" #   2022-12-12
LANG_COMMIT[zh-TW]="d64c538c343c8f200464543dc5b3517b038b11a1" #   2022-12-12
LANG_COMMIT[zu]="90f1408e882ce0e280f24e01af71787eff7be165" #   2022-12-06

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
