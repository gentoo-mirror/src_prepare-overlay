# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="7f76da3cfd5d04fa38d894f6ea6ac5f2fd0ea837"
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
LANG_COMMIT[ace]="279cd4d8aabbe80eaebdd1496d9cd2d25f3ed80d" #   2022-12-18
LANG_COMMIT[ach]="03f6a9c05e2508270766168c90be98bcfb534a57" #   2022-12-18
LANG_COMMIT[af]="13fa05d9d476b936af46d6216d5656a3bed642ab" #   2022-12-18
LANG_COMMIT[ak]="b32c81cc32943d662fcd96f834f0d66f3a829ac8" #   2022-12-18
LANG_COMMIT[an]="44107209354e638ede2a27cb92fbadbae5b99e89" #   2023-01-16
LANG_COMMIT[ar]="8ce30fa150206102e4389f7a279d627c68e94b6d" #   2023-01-16
LANG_COMMIT[as]="056f4ccb0c795a527b3cb47fe6e0e4616bf3af18" #   2022-12-31
LANG_COMMIT[ast]="400f1a4548920cc08606c61ec26f78d65eadd020" #   2022-12-18
LANG_COMMIT[az]="4e95a1cd11f56817a2e5f1afcdaaa105ad023f3d" #   2022-12-18
LANG_COMMIT[be]="2818a09e2223be4d2f44c608c10be9a26fb1c14a" #   2023-01-10
LANG_COMMIT[bg]="c371f676322264316fc880b8e0179d22f13017e9" #   2022-12-18
LANG_COMMIT[bn]="aa29348d335c3fc6566ea4ae27d91e58a1ac9434" #   2023-01-16
LANG_COMMIT[bn-BD]="fd53e4087a939d90f0f504886688f139987cf674" #   2022-12-18
LANG_COMMIT[bn-IN]="e01ae0d8708c488a4cbbcb1c50d76872e8e5d8da" #   2022-12-18
LANG_COMMIT[bo]="eb98ccdeb631d721a0671b5798fc0b2d652ad1ab" #   2022-12-18
LANG_COMMIT[br]="24194199552cfb5f4d4b4a43490daff55fb9e1aa" #   2022-12-18
LANG_COMMIT[brx]="87d6e40f6c19c85924a230b5cd845d64919452df" #   2023-01-16
LANG_COMMIT[bs]="27802087961ff1c750ad40342553d117b28c1dc3" #   2022-12-18
LANG_COMMIT[ca]="64a22d5d324967776b4a64836efb899ac12a8093" #   2023-01-16
LANG_COMMIT[ca-valencia]="9cb7f3fa154372ec604468cdd589211952e837e5" #   2023-01-16
LANG_COMMIT[cak]="e63df266cbfbe5dad7e2866e3a0114560aa26531" #   2023-01-16
LANG_COMMIT[ckb]="393b2b51053a58e9984fc4b9d0be9c3f0604a2b9" #   2022-12-18
LANG_COMMIT[crh]="f0d70c307c620c0b785d0d75c053b0913bc93c5a" #   2022-12-18
LANG_COMMIT[cs]="ec8c4a7c0caa4ce223d500980a520fa217dbad8b" #   2023-01-16
LANG_COMMIT[csb]="4d4b92207c4e5bb2b1d3c142b90d5deb32011c36" #   2022-12-18
LANG_COMMIT[cy]="f2d9a62ae91697cdc81a89a3467da706576d8b61" #   2023-01-16
LANG_COMMIT[da]="98cb9f8739d68fe3d9e9dc321d564d57e4fbdc0f" #   2023-01-16
LANG_COMMIT[de]="ff343446fe97e9e3639e9763cbcba7119a3cad13" #   2023-01-16
LANG_COMMIT[dsb]="09b7e9bb3a9c87a87875ded3b6785feae1f90c72" #   2023-01-16
LANG_COMMIT[el]="3974080260314478e8feb14ab161c54a6a52c348" #   2023-01-16
LANG_COMMIT[en-CA]="0aab6ab12202cfa10dd782d7bb758ccb49643a54" #   2023-01-06
LANG_COMMIT[en-GB]="2ab37b9a68a51fdfc205b3189dcbc20cd77cfb13" #   2023-01-16
LANG_COMMIT[en-ZA]="7bb277d54160b0941c7be95602a052dae1839c0a" #   2022-12-18
LANG_COMMIT[eo]="9f9c747eb097bcdd361659a47657c3dfab432bc7" #   2023-01-08
LANG_COMMIT[es-AR]="fac5084679f212bdbf404db1079da53239ba514b" #   2023-01-16
LANG_COMMIT[es-CL]="144304dd82eb1d04e83742635a2c17040c220cd9" #   2023-01-03
LANG_COMMIT[es-ES]="d19d5a2e6ecf6e893ed62e5ede8c5efebe3efa34" #   2023-01-16
LANG_COMMIT[es-MX]="fad4d0adf55e0d539e8d5638a9229dccf329b637" #   2023-01-04
LANG_COMMIT[et]="2b7fddbda2228fbe424d6964855c65d54670e858" #   2022-12-19
LANG_COMMIT[eu]="69d16c0049c7802030f6e47cdb1bf5c5313489ce" #   2023-01-15
LANG_COMMIT[fa]="6339913fae93f6a8bc2073b588c2d4bd170204a1" #   2023-01-16
LANG_COMMIT[ff]="c308068646507c7be870e53d95dbd22319ea3fe3" #   2022-12-18
LANG_COMMIT[fi]="a5f66bfb3bc37618c553786d7ac976845063d6a7" #   2023-01-11
LANG_COMMIT[fr]="fc70773a76882fd499a3937a9ebd3ddbae8af79b" #   2023-01-12
LANG_COMMIT[frp]="8f254f50f86014e566eb47318d4e9a566bfc2ee2" #   2022-12-18
LANG_COMMIT[fur]="42b6efe8e595d21ede64303e5c265f615989eb70" #   2023-01-09
LANG_COMMIT[fy-NL]="b9d27f9f23bf92f50b20233f9d14ed18eff6c137" #   2023-01-16
LANG_COMMIT[ga-IE]="b0c7c47ac3621fdfb2a9cc13f8e3e1e28dc40d9d" #   2022-12-18
LANG_COMMIT[gd]="eb2923fb615bb34971792ce56fd600d2cb0808db" #   2023-01-16
LANG_COMMIT[gl]="6d70cf923213e11087133f71ed2aa9e7bbae78ca" #   2022-12-19
LANG_COMMIT[gn]="7004ac3997ef2ed3f0aa5b499fccb9bd1dc2beba" #   2023-01-16
LANG_COMMIT[gu-IN]="c86fc4a1b5c52f4129147c96039cd6bbb5fa92ab" #   2022-12-18
LANG_COMMIT[gv]="cb82f55bf0ff941d74af343cfc44a22b9ab049d7" #   2022-12-18
LANG_COMMIT[he]="f3ddeb36667018f4de5921e2a9bd41d37c22fb3d" #   2023-01-10
LANG_COMMIT[hi-IN]="76203b400c7afbfcc68261c9e6c6e0e2c41db8e4" #   2023-01-16
LANG_COMMIT[hr]="a034739934288745720bf715ce4637a3fd73e037" #   2023-01-16
LANG_COMMIT[hsb]="162e5aab113c11b5f6acf36f1cabf7a7f5492376" #   2023-01-16
LANG_COMMIT[hto]="ddccad5fa28b3db90a85c279d905ad9ed282510d" #   2022-12-18
LANG_COMMIT[hu]="4766dd2b6c9a7c82f28a8e67021f28a34a8017c6" #   2023-01-10
LANG_COMMIT[hy-AM]="02fc12a2cf8f97ad810b79a4d6136351ff8900ee" #   2023-01-16
LANG_COMMIT[hye]="a2738b051de38336ce397c82cb55295f6dd06a04" #   2023-01-16
LANG_COMMIT[ia]="5c40544eb223d8f771c7c23243bf3793bb00f991" #   2023-01-16
LANG_COMMIT[id]="aea118cb666dbe46a51d7024e18f626cb6e33a6f" #   2023-01-16
LANG_COMMIT[ilo]="751fd13acd40c6aac9f1b989892a3d3f163e0ba1" #   2022-12-18
LANG_COMMIT[is]="0e3bfb73ae1e35e981cd9feb52a88292b74da0bb" #   2023-01-16
LANG_COMMIT[it]="2f45ceae40ab4be7a740229407257332f3d173a5" #   2023-01-14
LANG_COMMIT[ixl]="74242910d4ef59e22ff2dca3edeff15dfd540e84" #   2022-12-18
LANG_COMMIT[ja]="87394ed70ab741c6195f1007cf13fbd94386bb44" #   2023-01-05
LANG_COMMIT[ja-JP-mac]="b7b569da88e4135a278e51410f6f8d116e5d2fab" #   2023-01-05
LANG_COMMIT[ka]="a69b6d9e3010a52a02bde329bff97a16e84823d8" #   2023-01-07
LANG_COMMIT[kab]="ff85308818fc1df30264cec98ab970721fda5584" #   2023-01-16
LANG_COMMIT[kk]="8fc0e23e2b0d97dba2793cb256938d255546a78f" #   2023-01-10
LANG_COMMIT[km]="da4407dd0573c5e7e881881c352cbd5a76fc79be" #   2023-01-03
LANG_COMMIT[kn]="91f613cae3cb49a099697cb09b0e371b0ad740e0" #   2022-12-18
LANG_COMMIT[ko]="da076974bf9d1e53fbc0984c94e42295b925cebb" #   2023-01-16
LANG_COMMIT[kok]="6f423912a7e9bdf7abae4b092f45eb5deb2e152c" #   2022-12-18
LANG_COMMIT[ks]="25a418a975040095a85b82597157aa2bd02b0370" #   2022-12-18
LANG_COMMIT[ku]="4a45a193ebcd2ef307b1c27b8e86e24742e35edb" #   2022-12-18
LANG_COMMIT[lb]="34a600e3153157d7a980ba01de8eccc1f43c06e3" #   2022-12-18
LANG_COMMIT[lg]="dd5aed1a3bfa2ede8117381876ba04dda8901a17" #   2022-12-18
LANG_COMMIT[lij]="eaa1b94e6fa3f864a3a79f6fa3fe16625e94d04c" #   2022-12-18
LANG_COMMIT[lo]="b6d8e41fa111000e56c8bc9944675612d02252f3" #   2023-01-15
LANG_COMMIT[lt]="abf94de780d0eb0bd8c195751cfffb8e476dc14f" #   2022-12-19
LANG_COMMIT[ltg]="e0aa1902c195996482fcf6351c63e81ed4922499" #   2022-12-18
LANG_COMMIT[lv]="301d79ca8fdf2e383d1100d0910a7be7e8580f88" #   2023-01-06
LANG_COMMIT[mai]="c826a2a34f5b6c3d209d153b9dc2152aafe9864c" #   2022-12-18
LANG_COMMIT[meh]="a44415b51035c46eae1077804f59829e76f2172a" #   2022-12-18
LANG_COMMIT[mix]="cb01d9e0d66c9c0519eedef6260d2f0f4d1bea14" #   2022-12-18
LANG_COMMIT[mk]="7c409ad61b2b8b73067b8aae2ce10e140e841248" #   2022-12-18
LANG_COMMIT[ml]="deb254552166f08dc49c117346c7fa6d0dadafe8" #   2022-12-18
LANG_COMMIT[mn]="c7317af50b769bf1e5b2c485b93fdb9dde60a9ee" #   2022-12-18
LANG_COMMIT[mr]="0791ba4c9dd2a9f3d30b298dd7a077ceb8bf47c7" #   2022-12-18
LANG_COMMIT[ms]="1fe7f19e1de02eb1a4948238401d202b293fcb59" #   2022-12-18
LANG_COMMIT[my]="5f78bfd5b441e8dbeb9b82535bf41d53871bc621" #   2022-12-18
LANG_COMMIT[nb-NO]="caccf50cce196067f705a9fb67fb4b1a73df5c8a" #   2023-01-16
LANG_COMMIT[ne-NP]="86187e1d8f21bbc66aa9931f8e0918df417fefe5" #   2022-12-18
LANG_COMMIT[nl]="754d9ca73a65f4759f5fe019aa292aef6a92fc03" #   2023-01-16
LANG_COMMIT[nn-NO]="27a438ddb37d07b929c919ce3881fc6ff9a71ba2" #   2023-01-13
LANG_COMMIT[nr]="0d6264799f9dbef96c4faac84f523544528aaec2" #   2022-12-18
LANG_COMMIT[nso]="f70e2f3b5df1933143f151c173f434c2b908c043" #   2022-12-18
LANG_COMMIT[ny]="16921adfc93303665cd72d7c352378eaf02c5d36" #   2022-12-18
LANG_COMMIT[oc]="e40f95e34c6e3c627e1e367e98fa8d6bf2df50c7" #   2023-01-16
LANG_COMMIT[or]="ea7791829944d2544f6ca55b9d3115c141db5a73" #   2022-12-18
LANG_COMMIT[pa-IN]="52f6728bf896f774ee86e686294fae6a4733329c" #   2023-01-16
LANG_COMMIT[pai]="add9300a8f4d1363285dbc1ecf7a666a1dc10d43" #   2022-12-18
LANG_COMMIT[pbb]="f231d6ec10b46c498e5c70fc07ba798e64af8fca" #   2022-12-18
LANG_COMMIT[pl]="3e21d2332ae3ea3eb6d4e8bb36249c26a0daa239" #   2023-01-08
LANG_COMMIT[pt-BR]="c2cf81af480353be0b1dac3c07c2234868f1040d" #   2023-01-16
LANG_COMMIT[pt-PT]="f002edae2644412d59b3df29cfe9b17c8b85761e" #   2023-01-10
LANG_COMMIT[rm]="ff19c312520a63f758b25e7cf69b56247e0ac7cb" #   2022-12-19
LANG_COMMIT[ro]="da772002183ca4573a1fda27945080b193a4805d" #   2022-12-18
LANG_COMMIT[ru]="cf7ca6ce8ff90d67a754f65f94233ba9b70cc716" #   2023-01-16
LANG_COMMIT[rw]="22f4425e8bc53d54fb2644f73157b1710af61234" #   2022-12-18
LANG_COMMIT[sah]="5d19a1851dd7c7e6822eb9b59797127df0551777" #   2022-12-18
LANG_COMMIT[sat]="6395f4e362204dcd4e79cf887b4e2be52a1a2e31" #   2023-01-16
LANG_COMMIT[sc]="7439cfdbd6ed6b0877707e80b1b28be7fbdbbb14" #   2023-01-16
LANG_COMMIT[scn]="17cddcbcf8235d4d3a5f6ac7e7971c2a8be37549" #   2022-12-18
LANG_COMMIT[sco]="2058b07ac42637e8b04dffd175000771c58d4dc2" #   2022-12-19
LANG_COMMIT[si]="dd5eca15b899b6ce33930c8684db94820c5fdc86" #   2023-01-16
LANG_COMMIT[sk]="c71080e2aaf0ec2a9a6dea2792a2b4e30ddbe207" #   2023-01-13
LANG_COMMIT[sl]="52c5f68236c78f43a36d15aa99a1a0995ec0b073" #   2023-01-10
LANG_COMMIT[son]="b1d192b17071b0f84bf6bf5f96a42789e32513ff" #   2022-12-18
LANG_COMMIT[sq]="8ff48dc74ace7b78f75821141a3442e618abadb6" #   2023-01-16
LANG_COMMIT[sr]="7d540d02ae33a61739fb866f10a9af652e1d14bc" #   2023-01-11
LANG_COMMIT[ss]="b6cc956a0bcb3b13ab1e5e5fe66e7457a0e4748d" #   2022-12-18
LANG_COMMIT[st]="4b515f19216142b11b425466cd26f1535f1a1abe" #   2022-12-18
LANG_COMMIT[sv-SE]="8e9d3101b2865d2e8426931754d181361ce859ff" #   2023-01-16
LANG_COMMIT[sw]="def6980597bb7b363956308251a900b1f11eac99" #   2022-12-18
LANG_COMMIT[szl]="f8f5b9c7b3b5ba5227bc41bf30c0a8971f65683b" #   2023-01-14
LANG_COMMIT[ta]="d1e26e8b53ea0aa9c00562f8fbfc5e9c2a0ef2cd" #   2023-01-16
LANG_COMMIT[ta-LK]="c22f871721410fb4a0932785f5b2c281209e1d42" #   2022-12-18
LANG_COMMIT[te]="b158a41b61bea0acc5319aa3473ab6775d897500" #   2022-12-18
LANG_COMMIT[tg]="a60e8b6c627bde22a7bab49fb3f1edf302159df4" #   2023-01-16
LANG_COMMIT[th]="9b2d6b9a700ef56302a79938eab8a73006a6b0c7" #   2023-01-10
LANG_COMMIT[tl]="8c158b7f2a97e066c8fb63bcf3bfab0f9a10c7f9" #   2022-12-18
LANG_COMMIT[tn]="68e898f8292ee6f7b7f5a02cc008301ead335004" #   2022-12-18
LANG_COMMIT[tr]="1419d95734ff402f1605d7535edde3bf1391923c" #   2023-01-16
LANG_COMMIT[trs]="ace4cb5d5f74aa2fd08196b1b3288269a49ad47b" #   2023-01-16
LANG_COMMIT[ts]="ded5bab4c38d0085861ce44b3c87f4034553c888" #   2022-12-18
LANG_COMMIT[tsz]="63e79676c6cf93175636364b7d551c8b7ac1fbc1" #   2022-12-18
LANG_COMMIT[uk]="03e5386aa6397b52488b83c3a4a32a619671f449" #   2023-01-16
LANG_COMMIT[ur]="ffdf66bd4864981061efb1b9cf106300cc6b09ed" #   2023-01-16
LANG_COMMIT[uz]="801ba01ede2f83da9b54088fac481cfad6fca181" #   2022-12-18
LANG_COMMIT[ve]="2736e0ab1341290aa9939d9485222a4b1bb09fd2" #   2022-12-18
LANG_COMMIT[vi]="00b892f6af73d17c0df4a37b98ce4746eee9f488" #   2023-01-16
LANG_COMMIT[wo]="8969249d15162feca2c3081003e9636871718473" #   2023-01-16
LANG_COMMIT[xcl]="baceb9cfb38dc7f436987154d8fe5b4f4f9acd9d" #   2022-12-18
LANG_COMMIT[xh]="53577c145f87694411f0595a60f728298c8482c6" #   2022-12-18
LANG_COMMIT[zam]="faed701453789fed7e1c5f405e0276bf2ee94498" #   2022-12-18
LANG_COMMIT[zh-CN]="7bc17118dd83dd3bf7fda82bfdca43b1da89d064" #   2023-01-16
LANG_COMMIT[zh-TW]="79f16fbb43472444f73cca8b473f41076c9411ac" #   2023-01-16
LANG_COMMIT[zu]="ee02448ad49211a43ea37854317c07053cae23e1" #   2022-12-18

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
