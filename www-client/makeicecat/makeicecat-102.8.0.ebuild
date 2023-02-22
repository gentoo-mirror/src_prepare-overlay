# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="03d9e3db5affe21db077c410ec08c313d6aa280e"
COMPARE_LOCALES_PV="8.2.1"
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
LANG_COMMIT[ace]="279cd4d8aabbe80eaebdd1496d9cd2d25f3ed80d" #   2022-12-18
LANG_COMMIT[ach]="10cec1b311554f5fc51429bcaea26d8daab5ccf6" #   2023-02-03
LANG_COMMIT[af]="13fa05d9d476b936af46d6216d5656a3bed642ab" #   2022-12-18
LANG_COMMIT[ak]="b32c81cc32943d662fcd96f834f0d66f3a829ac8" #   2022-12-18
LANG_COMMIT[an]="44107209354e638ede2a27cb92fbadbae5b99e89" #   2023-01-16
LANG_COMMIT[ar]="8ce30fa150206102e4389f7a279d627c68e94b6d" #   2023-01-16
LANG_COMMIT[as]="056f4ccb0c795a527b3cb47fe6e0e4616bf3af18" #   2022-12-31
LANG_COMMIT[ast]="400f1a4548920cc08606c61ec26f78d65eadd020" #   2022-12-18
LANG_COMMIT[az]="4e95a1cd11f56817a2e5f1afcdaaa105ad023f3d" #   2022-12-18
LANG_COMMIT[be]="32a219b2c2edc8c8bcc579c47152d0b501c28557" #   2023-02-11
LANG_COMMIT[bg]="c371f676322264316fc880b8e0179d22f13017e9" #   2022-12-18
LANG_COMMIT[bn]="aa29348d335c3fc6566ea4ae27d91e58a1ac9434" #   2023-01-16
LANG_COMMIT[bn-BD]="fd53e4087a939d90f0f504886688f139987cf674" #   2022-12-18
LANG_COMMIT[bn-IN]="e01ae0d8708c488a4cbbcb1c50d76872e8e5d8da" #   2022-12-18
LANG_COMMIT[bo]="eb98ccdeb631d721a0671b5798fc0b2d652ad1ab" #   2022-12-18
LANG_COMMIT[br]="efe22ab12bb01347d5045c3f910e5ff332ef18ed" #   2023-01-24
LANG_COMMIT[brx]="87d6e40f6c19c85924a230b5cd845d64919452df" #   2023-01-16
LANG_COMMIT[bs]="27802087961ff1c750ad40342553d117b28c1dc3" #   2022-12-18
LANG_COMMIT[ca]="3493c433a98b50809a447cd28ff73a467a560f7d" #   2023-02-05
LANG_COMMIT[ca-valencia]="9cb7f3fa154372ec604468cdd589211952e837e5" #   2023-01-16
LANG_COMMIT[cak]="e63df266cbfbe5dad7e2866e3a0114560aa26531" #   2023-01-16
LANG_COMMIT[ckb]="393b2b51053a58e9984fc4b9d0be9c3f0604a2b9" #   2022-12-18
LANG_COMMIT[crh]="f0d70c307c620c0b785d0d75c053b0913bc93c5a" #   2022-12-18
LANG_COMMIT[cs]="84acedf83dbffe1e7c7c967ba28b567a006c7d58" #   2023-02-05
LANG_COMMIT[csb]="4d4b92207c4e5bb2b1d3c142b90d5deb32011c36" #   2022-12-18
LANG_COMMIT[cy]="5814407a2a2c6c647045d69c52cc9b662f0e4c81" #   2023-02-10
LANG_COMMIT[da]="e81ee6d51c3a6aa8b33aa8e1c2b856d3ea30f291" #   2023-02-04
LANG_COMMIT[de]="cfc198fe2f511cc4c0d2c4f00c8256ee05994671" #   2023-02-12
LANG_COMMIT[dsb]="fd5ede1a0c88b6769ba6d9d9726d9b6faae2c544" #   2023-01-16
LANG_COMMIT[el]="1905b8681c1d3e80fe6540c56a3f490626571292" #   2023-02-14
LANG_COMMIT[en-CA]="cc4734b4bb96a007e70e3803400dc172eaaf0b25" #   2023-02-10
LANG_COMMIT[en-GB]="47b4cddae317c018b149e12b81314c50a5fe6b94" #   2023-02-14
LANG_COMMIT[en-ZA]="7bb277d54160b0941c7be95602a052dae1839c0a" #   2022-12-18
LANG_COMMIT[eo]="9f9c747eb097bcdd361659a47657c3dfab432bc7" #   2023-01-08
LANG_COMMIT[es-AR]="47aba1a69764068190fe4f15ff3b466cea49c6b4" #   2023-02-13
LANG_COMMIT[es-CL]="b3332c3c903a20cf535f12d9a7aeeae22df7e8fb" #   2023-02-14
LANG_COMMIT[es-ES]="3ad3acf25458e756a812f66df4440e7d47188e7e" #   2023-02-05
LANG_COMMIT[es-MX]="a012d3d0cea941256370488202ab75fbbd4b853c" #   2023-02-14
LANG_COMMIT[et]="2b7fddbda2228fbe424d6964855c65d54670e858" #   2022-12-19
LANG_COMMIT[eu]="6bfd2166bf3c85c78d82db6497d1b8214f85fd6d" #   2023-02-12
LANG_COMMIT[fa]="6339913fae93f6a8bc2073b588c2d4bd170204a1" #   2023-01-16
LANG_COMMIT[ff]="c308068646507c7be870e53d95dbd22319ea3fe3" #   2022-12-18
LANG_COMMIT[fi]="a5f66bfb3bc37618c553786d7ac976845063d6a7" #   2023-01-11
LANG_COMMIT[fr]="fdc6a4ad46ccd83ccb44cf50fc554a8cda3aa3d3" #   2023-02-07
LANG_COMMIT[frp]="8f254f50f86014e566eb47318d4e9a566bfc2ee2" #   2022-12-18
LANG_COMMIT[fur]="fa51f9938c278a6d0bc3973c9ebb7f58a4c60b18" #   2023-02-15
LANG_COMMIT[fy-NL]="65e8e1475b51f96eefdbad0517f0ee397406522c" #   2023-02-10
LANG_COMMIT[ga-IE]="b0c7c47ac3621fdfb2a9cc13f8e3e1e28dc40d9d" #   2022-12-18
LANG_COMMIT[gd]="eb2923fb615bb34971792ce56fd600d2cb0808db" #   2023-01-16
LANG_COMMIT[gl]="6d70cf923213e11087133f71ed2aa9e7bbae78ca" #   2022-12-19
LANG_COMMIT[gn]="fd5bb03cffd756cb1c229a25eb8724c6a4fb30b0" #   2023-02-14
LANG_COMMIT[gu-IN]="c86fc4a1b5c52f4129147c96039cd6bbb5fa92ab" #   2022-12-18
LANG_COMMIT[gv]="cb82f55bf0ff941d74af343cfc44a22b9ab049d7" #   2022-12-18
LANG_COMMIT[he]="4c1de2da4f10a8c5b6e27a4a66446846c03f9732" #   2023-02-10
LANG_COMMIT[hi-IN]="76203b400c7afbfcc68261c9e6c6e0e2c41db8e4" #   2023-01-16
LANG_COMMIT[hr]="a034739934288745720bf715ce4637a3fd73e037" #   2023-01-16
LANG_COMMIT[hsb]="cd75ea5d79e56659bc183a480f8ff5d59d1a37f8" #   2023-02-08
LANG_COMMIT[hto]="ddccad5fa28b3db90a85c279d905ad9ed282510d" #   2022-12-18
LANG_COMMIT[hu]="e2c47c445ed5b92b3266876f8e9ed8ce579628e7" #   2023-02-13
LANG_COMMIT[hy-AM]="1aa505d46bb625b9bbc6a1a81d8587db21f9d9ac" #   2023-01-26
LANG_COMMIT[hye]="a2738b051de38336ce397c82cb55295f6dd06a04" #   2023-01-16
LANG_COMMIT[ia]="1e05c6a8e2867d720aa3a76e8d7d8b952be7e763" #   2023-02-10
LANG_COMMIT[id]="f7b23a1c0eb4ab2e32642c6213081f4d1890555a" #   2023-02-03
LANG_COMMIT[ilo]="751fd13acd40c6aac9f1b989892a3d3f163e0ba1" #   2022-12-18
LANG_COMMIT[is]="ad67bd04d06a9a114f30b2098ad3077230419dd3" #   2023-02-13
LANG_COMMIT[it]="723a8e4fbbb74c8ae2062f3543f7d50b5d97a34e" #   2023-02-14
LANG_COMMIT[ixl]="74242910d4ef59e22ff2dca3edeff15dfd540e84" #   2022-12-18
LANG_COMMIT[ja]="cd9444bfdb1f8685533f780b951fd80a7becc4af" #   2023-02-13
LANG_COMMIT[ja-JP-mac]="b19d5b65ead47c17a40f826e1364fefe3fc924d8" #   2023-02-13
LANG_COMMIT[ka]="cb7315932645b2f4bd17e23cce1211a57e6ea15b" #   2023-02-07
LANG_COMMIT[kab]="66708c3bdaf20483b1f2ad8c37287be0ce74d855" #   2023-01-27
LANG_COMMIT[kk]="863b170481810a5062e3cfec268ac0effc51dbf4" #   2023-02-14
LANG_COMMIT[km]="da4407dd0573c5e7e881881c352cbd5a76fc79be" #   2023-01-03
LANG_COMMIT[kn]="91f613cae3cb49a099697cb09b0e371b0ad740e0" #   2022-12-18
LANG_COMMIT[ko]="a748681390d09a7a830f0cb64d0351e7a753e6b0" #   2023-02-10
LANG_COMMIT[kok]="6f423912a7e9bdf7abae4b092f45eb5deb2e152c" #   2022-12-18
LANG_COMMIT[ks]="25a418a975040095a85b82597157aa2bd02b0370" #   2022-12-18
LANG_COMMIT[ku]="4a45a193ebcd2ef307b1c27b8e86e24742e35edb" #   2022-12-18
LANG_COMMIT[lb]="34a600e3153157d7a980ba01de8eccc1f43c06e3" #   2022-12-18
LANG_COMMIT[lg]="dd5aed1a3bfa2ede8117381876ba04dda8901a17" #   2022-12-18
LANG_COMMIT[lij]="eaa1b94e6fa3f864a3a79f6fa3fe16625e94d04c" #   2022-12-18
LANG_COMMIT[lo]="152ea64f4f5850979b23f63f496b2c81079c10ad" #   2023-02-15
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
LANG_COMMIT[nb-NO]="09d7a770a96c745ac512929771a747abd6146215" #   2023-02-05
LANG_COMMIT[ne-NP]="86187e1d8f21bbc66aa9931f8e0918df417fefe5" #   2022-12-18
LANG_COMMIT[nl]="80b1dfb1ae4d866b611f3eb15568a007b881007d" #   2023-02-10
LANG_COMMIT[nn-NO]="f73c684fef0dc14f20061a5abc6e82e235e027db" #   2023-02-07
LANG_COMMIT[nr]="0d6264799f9dbef96c4faac84f523544528aaec2" #   2022-12-18
LANG_COMMIT[nso]="f70e2f3b5df1933143f151c173f434c2b908c043" #   2022-12-18
LANG_COMMIT[ny]="16921adfc93303665cd72d7c352378eaf02c5d36" #   2022-12-18
LANG_COMMIT[oc]="de3f453cd070bf92d7a3f808e901eefd65d27b7c" #   2023-02-10
LANG_COMMIT[or]="ea7791829944d2544f6ca55b9d3115c141db5a73" #   2022-12-18
LANG_COMMIT[pa-IN]="913649c397fbe0f9b7ed0ca19a468666203a2284" #   2023-02-08
LANG_COMMIT[pai]="add9300a8f4d1363285dbc1ecf7a666a1dc10d43" #   2022-12-18
LANG_COMMIT[pbb]="f231d6ec10b46c498e5c70fc07ba798e64af8fca" #   2022-12-18
LANG_COMMIT[pl]="bcf6575ec44eb2a573f320e09ad71845d062d2ba" #   2023-02-09
LANG_COMMIT[pt-BR]="12f6114a60b57f7891caf45906e41a9bfcef59bb" #   2023-02-10
LANG_COMMIT[pt-PT]="aa04471fb259882d6ded36ab2724276885f960c4" #   2023-02-05
LANG_COMMIT[rm]="b8dbe0e7b4cac4527d6afeb4cf4f3b3f54e954c4" #   2023-02-06
LANG_COMMIT[ro]="da772002183ca4573a1fda27945080b193a4805d" #   2022-12-18
LANG_COMMIT[ru]="d085402058e07df54424b4659857b35871c32fbc" #   2023-02-11
LANG_COMMIT[rw]="22f4425e8bc53d54fb2644f73157b1710af61234" #   2022-12-18
LANG_COMMIT[sah]="5d19a1851dd7c7e6822eb9b59797127df0551777" #   2022-12-18
LANG_COMMIT[sat]="6395f4e362204dcd4e79cf887b4e2be52a1a2e31" #   2023-01-16
LANG_COMMIT[sc]="7439cfdbd6ed6b0877707e80b1b28be7fbdbbb14" #   2023-01-16
LANG_COMMIT[scn]="17cddcbcf8235d4d3a5f6ac7e7971c2a8be37549" #   2022-12-18
LANG_COMMIT[sco]="2058b07ac42637e8b04dffd175000771c58d4dc2" #   2022-12-19
LANG_COMMIT[si]="2431e86d3e39c8f8023cf852aa6157528f9d10cb" #   2023-02-12
LANG_COMMIT[sk]="5c552f6692d44b87ba07ec5fa6842f5c557e2cc1" #   2023-02-12
LANG_COMMIT[sl]="7f639920a5d41610b6425bbc7b586785780e631c" #   2023-02-12
LANG_COMMIT[son]="b1d192b17071b0f84bf6bf5f96a42789e32513ff" #   2022-12-18
LANG_COMMIT[sq]="5d84765f2bd06dccd0d179f9edb64936a2941581" #   2023-01-26
LANG_COMMIT[sr]="e97c5cf06b1508a23feb943d24f44e655a3358db" #   2023-02-10
LANG_COMMIT[ss]="b6cc956a0bcb3b13ab1e5e5fe66e7457a0e4748d" #   2022-12-18
LANG_COMMIT[st]="4b515f19216142b11b425466cd26f1535f1a1abe" #   2022-12-18
LANG_COMMIT[sv-SE]="e9946913267c06df1a546997264a8849554334d7" #   2023-02-11
LANG_COMMIT[sw]="def6980597bb7b363956308251a900b1f11eac99" #   2022-12-18
LANG_COMMIT[szl]="9a0fd747db2711b623fcfb3507a7b4e53d4bf53d" #   2023-02-05
LANG_COMMIT[ta]="d1e26e8b53ea0aa9c00562f8fbfc5e9c2a0ef2cd" #   2023-01-16
LANG_COMMIT[ta-LK]="c22f871721410fb4a0932785f5b2c281209e1d42" #   2022-12-18
LANG_COMMIT[te]="b158a41b61bea0acc5319aa3473ab6775d897500" #   2022-12-18
LANG_COMMIT[tg]="1fa06ff864f248e78b03245f747fc67821a450e6" #   2023-02-13
LANG_COMMIT[th]="83f353eb18700e5d50238e940aab21546d132ed3" #   2023-02-12
LANG_COMMIT[tl]="a1390d2c78a86f17da9ad6ccf007e02b47209e07" #   2023-02-11
LANG_COMMIT[tn]="68e898f8292ee6f7b7f5a02cc008301ead335004" #   2022-12-18
LANG_COMMIT[tr]="9026445c51c9dc6a2b27a353c24b754221c521a2" #   2023-02-12
LANG_COMMIT[trs]="ace4cb5d5f74aa2fd08196b1b3288269a49ad47b" #   2023-01-16
LANG_COMMIT[ts]="ded5bab4c38d0085861ce44b3c87f4034553c888" #   2022-12-18
LANG_COMMIT[tsz]="63e79676c6cf93175636364b7d551c8b7ac1fbc1" #   2022-12-18
LANG_COMMIT[uk]="74762c7fdc0b16bcc3b9dfa08ad75706659c1b62" #   2023-02-13
LANG_COMMIT[ur]="ffdf66bd4864981061efb1b9cf106300cc6b09ed" #   2023-01-16
LANG_COMMIT[uz]="801ba01ede2f83da9b54088fac481cfad6fca181" #   2022-12-18
LANG_COMMIT[ve]="2736e0ab1341290aa9939d9485222a4b1bb09fd2" #   2022-12-18
LANG_COMMIT[vi]="bc84f700f8c2867f9d63977dc0905fdd7af1e770" #   2023-02-14
LANG_COMMIT[wo]="8969249d15162feca2c3081003e9636871718473" #   2023-01-16
LANG_COMMIT[xcl]="baceb9cfb38dc7f436987154d8fe5b4f4f9acd9d" #   2022-12-18
LANG_COMMIT[xh]="53577c145f87694411f0595a60f728298c8482c6" #   2022-12-18
LANG_COMMIT[zam]="faed701453789fed7e1c5f405e0276bf2ee94498" #   2022-12-18
LANG_COMMIT[zh-CN]="86a9c6088e74370f6ae70581779864b070fb46d9" #   2023-02-12
LANG_COMMIT[zh-TW]="5b1bf6f19d20e19d9712f32c4db1ba5cd86a34bf" #   2023-02-14
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
