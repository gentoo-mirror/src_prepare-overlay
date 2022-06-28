# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="65a61287a5142a9403ec00d973cb5e5d658a3c71"
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
LANG_COMMIT[ace]="d0686f81cce877fccf5915263e48d8d14fa9703e" #   2022-05-20
LANG_COMMIT[ach]="67077e72adbb0f032c27841262df1f0d43a5fb54" #   2022-05-17
LANG_COMMIT[af]="965d59dfc8d5cf6e7c98b259ffd4b0b2b45cf0bc" #   2022-05-17
LANG_COMMIT[ak]="a370d1a2ce0aaa792f4c0278fbade4f4a7de162a" #   2022-05-17
LANG_COMMIT[an]="d9604d2d3db8b9a16fd43d1d884702c0365d3b72" #   2022-05-17
LANG_COMMIT[ar]="358230ceed1649f60cfa89d09d8ce53715c5e1d1" #   2022-05-17
LANG_COMMIT[as]="a728ac78f5dee8cbcce6328661fa133950c5fa7b" #   2022-05-17
LANG_COMMIT[ast]="571b61a0a87a7b1de1fc072749797552eb4af71d" #   2022-05-17
LANG_COMMIT[az]="67331530fbf0b32435cc9011efa811d524d63f84" #   2022-05-17
LANG_COMMIT[be]="dac6909dbbfca552077518e96926143621f57fe2" #   2022-06-22
LANG_COMMIT[bg]="0cc51e8b5d5f71e385b76167f91a286098199825" #   2022-06-02
LANG_COMMIT[bn]="a78888d7274a3ac02329104e5cac5b7a48d26454" #   2022-06-17
LANG_COMMIT[bn-BD]="bcabdb469b89317049755f3234eb4d11912f67e1" #   2022-05-17
LANG_COMMIT[bn-IN]="8feeca5e3e036e41843fc073f7c56e1c10b70e5d" #   2022-05-17
LANG_COMMIT[bo]="812b7b04324660ad294e01e58b26c2a92848529e" #   2022-05-17
LANG_COMMIT[br]="4cb5ab289cc37542167744eafc9d10c0ee6025b3" #   2022-06-03
LANG_COMMIT[brx]="143dd39a46b6eb0a8869638cabf7f927f94df63a" #   2022-05-17
LANG_COMMIT[bs]="85d99a5a6324588b24ff5cd0ff7454df446fc61c" #   2022-05-17
LANG_COMMIT[ca]="80c806ff7a50f5f7cfd596fae0da28a399a0793b" #   2022-05-22
LANG_COMMIT[ca-valencia]="2889c3d8cca1919f4784e3f32381095ee5e8e692" #   2022-05-17
LANG_COMMIT[cak]="025c5063e4069f06be4e2e2cdff175e35bb30b58" #   2022-05-17
LANG_COMMIT[ckb]="a3d0123c737de7b1250bc324991cc125939f184f" #   2022-06-24
LANG_COMMIT[crh]="dfe192466f39991dcbc21f8b248b220b10d62c76" #   2022-05-17
LANG_COMMIT[cs]="ce3ff63e04a973771a6c9e8dc989c41b3b23c3de" #   2022-06-24
LANG_COMMIT[csb]="bd592a70fcbbb99f6be35835cb609eb540c5a4cb" #   2022-05-17
LANG_COMMIT[cy]="fae89d16725eb29494a3de05e6dd65948befa290" #   2022-06-21
LANG_COMMIT[da]="985d4ae0d6544d241159df8adbb7c92a4b30552f" #   2022-06-23
LANG_COMMIT[de]="03be0003844d474fc7bfeb9b6f0fde8750bae2ae" #   2022-06-23
LANG_COMMIT[dsb]="a0d368168f08a39ae5e25c664b367410eda3f8c3" #   2022-06-26
LANG_COMMIT[el]="45af778c094e1ae1187d93914fa303b6cd2a3b18" #   2022-06-27
LANG_COMMIT[en-CA]="2b4588216f0c36f752694298a03ba303857264fc" #   2022-06-01
LANG_COMMIT[en-GB]="151dd8af72679474e433419d2ae66286b833e2d7" #   2022-06-27
LANG_COMMIT[en-ZA]="54cf33d0642db11923dea2168ccf9a280a3a5aa3" #   2022-05-17
LANG_COMMIT[eo]="bb27864950c776e16b70e23c5dba62e22d52be52" #   2022-06-19
LANG_COMMIT[es-AR]="2cd6c2d2452754864db249e8c66d5640f5ce7930" #   2022-06-24
LANG_COMMIT[es-CL]="12a815e1a9434cceeeb8806ac73a095a9111c56f" #   2022-06-21
LANG_COMMIT[es-ES]="3d02f53eeebe23147dfc1879d3ec21593ca73ffb" #   2022-06-26
LANG_COMMIT[es-MX]="b07e93620221ab6352c141521c42f42948935e96" #   2022-06-27
LANG_COMMIT[et]="6967d71580f48257701c02e5bd029a5d1a1da7f7" #   2022-06-21
LANG_COMMIT[eu]="d00adb3ddacdc98fa95cd2e70c5ed7f0f996f721" #   2022-06-21
LANG_COMMIT[fa]="4450ed5cf9a2f6cb59efaca74249e46fd8a3ca15" #   2022-05-17
LANG_COMMIT[ff]="16c6df720cc039f91e0f0e4221bf713ea7ed2e62" #   2022-06-21
LANG_COMMIT[fi]="c78403643c186593efd570a3aba5d06a9c8073a9" #   2022-06-22
LANG_COMMIT[fr]="0afe5e3c3fb87ffe7d5931fd7de61e24a93a5e29" #   2022-06-27
LANG_COMMIT[frp]="a781542b7b01f1826608d4de932534e7435e60e1" #   2022-05-17
LANG_COMMIT[fur]="1130a893ba4264f9433cfbb328e01ecc0fb83ecb" #   2022-06-14
LANG_COMMIT[fy-NL]="c21d2069bb869de156fceef56063d924697f2278" #   2022-06-27
LANG_COMMIT[ga-IE]="34c4d96bfa6302358a71597f4dd8407d0276517e" #   2022-05-17
LANG_COMMIT[gd]="aa15289b6855ba2386a92ad276bffa539a999b3c" #   2022-06-01
LANG_COMMIT[gl]="74482758407d771b17cded6ad4ecd0c086438c72" #   2022-05-17
LANG_COMMIT[gn]="9c290e5350aa6fd755d3cf0d4d71acf3adc0772c" #   2022-06-24
LANG_COMMIT[gu-IN]="ff79dfcddf2a11e05a777a94144a897693a59238" #   2022-05-17
LANG_COMMIT[gv]="eb107a763fd4a4882acc145eb947b3d9da769db2" #   2022-05-17
LANG_COMMIT[he]="79bbf86a4b4d7caf8b390011de77ae90c0e5fed6" #   2022-06-27
LANG_COMMIT[hi-IN]="e1f24b9d22ea008cf22feaa6b7257537409154fa" #   2022-05-17
LANG_COMMIT[hr]="bd90e7e8ec75dfcc6f9bafcd7d8abc66d8954f29" #   2022-05-17
LANG_COMMIT[hsb]="94bd20388392e31f4e2b410f94f04cb508811904" #   2022-06-27
LANG_COMMIT[hto]="59b96b5d6a38441c361b899b27f702434833fab1" #   2022-05-17
LANG_COMMIT[hu]="f4f71be3ada73ffa7175376ddee267caea61d6c1" #   2022-06-27
LANG_COMMIT[hy-AM]="2c8509502a6e8f49e89f0d25e93b126138dd40e0" #   2022-06-24
LANG_COMMIT[hye]="8819d7eb94dc953668d8f8d69ced25b22d8ac279" #   2022-06-13
LANG_COMMIT[ia]="233a08d3c873528c0a34888bb92423bfb44a9cfd" #   2022-06-22
LANG_COMMIT[id]="b77fcd8c45baec1dc4fad55dd5cab829e58ec537" #   2022-06-23
LANG_COMMIT[ilo]="1809abfb44649e7b0c471bfdb0e81acf148871cb" #   2022-05-17
LANG_COMMIT[is]="dddbf08757afed7a0a0c54171ec1f0fc527275a4" #   2022-06-27
LANG_COMMIT[it]="609fb02bc49f74a1d501f02ea77456b91d7f234c" #   2022-06-28
LANG_COMMIT[ixl]="ee5c64f48f3fad15d1ed24a21d6c13b84079edc7" #   2022-05-17
LANG_COMMIT[ja]="a393cc63e494f30a4c212c729e178a4ab7356a0e" #   2022-06-19
LANG_COMMIT[ja-JP-mac]="16f40bb8f3d731746b39157a30a4b40c73ce1227" #   2022-06-19
LANG_COMMIT[ka]="2cea74990aa1b26e53b620818f7a0ff20afb0f50" #   2022-06-19
LANG_COMMIT[kab]="b24bd924551c60e9e0c72c41ebe4e563f2d7f8b2" #   2022-06-22
LANG_COMMIT[kk]="d8858f1bc7528b0daa7ecc63164c899c669b5c31" #   2022-06-19
LANG_COMMIT[km]="6de8999e084759d649d04f5e13d5785e4d755f78" #   2022-05-17
LANG_COMMIT[kn]="3bb8578dea3ffca44ec54854ce1ee2c2434c797a" #   2022-05-17
LANG_COMMIT[ko]="7b02647cab611b1bedb01082120f8b9fbcff82e9" #   2022-06-27
LANG_COMMIT[kok]="80fb1784f8c2f854bd0b1210b763391828f4a9a5" #   2022-05-17
LANG_COMMIT[ks]="6cced9a1730ca62c4ddc01404104a1f1afaeed54" #   2022-05-17
LANG_COMMIT[ku]="17334b1a9f7f1594895b96e89ebdda48f77e1a6e" #   2022-05-17
LANG_COMMIT[lb]="a1ce6699c39d0b1d0d8e431f8e4d4050825e9624" #   2022-05-17
LANG_COMMIT[lg]="2458785cf2dd785aab6b0165c79b50d57e4eb3ea" #   2022-05-17
LANG_COMMIT[lij]="39052998dd6f4d4871ea3d5819ec6a0640558fe8" #   2022-05-17
LANG_COMMIT[lo]="66b2b5d67ce2d32dd3cfade94080addc5a094e7c" #   2022-05-17
LANG_COMMIT[lt]="37fc8582da0875d1a3a48af72567a2301620d5cd" #   2022-06-26
LANG_COMMIT[ltg]="9931c72c977340fa66eafea32938c891fb51aeee" #   2022-05-17
LANG_COMMIT[lv]="17457b836cbce7b0ab670dfd9252ef487454a70d" #   2022-05-17
LANG_COMMIT[mai]="f6cbe4cfe05f5074748a9493baec31d4d372975d" #   2022-05-17
LANG_COMMIT[meh]="f7bf11e05855cb532c5c7037cccbcac2e891ae27" #   2022-05-17
LANG_COMMIT[mix]="75caf62d207a6142e0c37dda5fc59a7cde25a8a8" #   2022-05-17
LANG_COMMIT[mk]="25052d044aa5e67ef1b9a1966e931aefcf77040d" #   2022-06-21
LANG_COMMIT[ml]="24cdf868ba0409a8af749dc1c69c53eafc3b033a" #   2022-05-17
LANG_COMMIT[mn]="7488d06459f253c569962c2248a899d429eaf4ad" #   2022-05-17
LANG_COMMIT[mr]="f9ebad7ded4cf994d52d8ee399d76490c8f023e7" #   2022-05-17
LANG_COMMIT[ms]="ffde17468a12124400b67e78aa4d21537f924c54" #   2022-05-17
LANG_COMMIT[my]="b656b72a6762b20e5cfad8bf5a4da633a9fbbf3b" #   2022-05-17
LANG_COMMIT[nb-NO]="eff7ae16e82ad787dc5105e06df507d939bfd4e0" #   2022-06-23
LANG_COMMIT[ne-NP]="e88add0191913802baf7c412fcb782b0e527ece1" #   2022-05-17
LANG_COMMIT[nl]="f8987b609d18b512e6cd3940d03bb3c4c46d2b12" #   2022-06-27
LANG_COMMIT[nn-NO]="579746f96a673cadab8c10aa6ed9a50d6c76d5f2" #   2022-06-27
LANG_COMMIT[nr]="1501cad7211442d869c9512af50705a4981432c4" #   2022-05-17
LANG_COMMIT[nso]="c997c23ed218d05e3958bd0e5bcd0449ddb7ae04" #   2022-05-17
LANG_COMMIT[ny]="8ad79fc759351b74a64d402949d0b841714f9ae8" #   2022-05-17
LANG_COMMIT[oc]="8c99008bb680a7cb111fbea9131b0c8c89e42199" #   2022-06-22
LANG_COMMIT[or]="e1147f0c4ec4a405fd3ecc38d93e31702a85a318" #   2022-05-17
LANG_COMMIT[pa-IN]="798afc28472d0aa623b7d6ee1d35dccb42f4d1b1" #   2022-06-19
LANG_COMMIT[pai]="80b5b8ff35c2bdec61a0cea95f82a60e74d1e4fc" #   2022-05-17
LANG_COMMIT[pbb]="0dc29cbaed101ca89e363fdfdc1c64d7a123ab47" #   2022-05-17
LANG_COMMIT[pl]="ee21305f4f4c4cb0eef45e7bfd8467bbc9357e4a" #   2022-06-26
#LANG_COMMIT[ppl]="9a3798a19745bc38ea9e73752acffb4831511fc5" #   2022-05-17
LANG_COMMIT[pt-BR]="98e5c88f1161c60b9b54fa9780489bc94619bfa7" #   2022-06-27
LANG_COMMIT[pt-PT]="8a9ed07c837af59509e4e80b27a1599318e921d7" #   2022-06-27
LANG_COMMIT[quy]="7515195839ab60d4072a3d57e93b0410a86be304" #   2022-05-17
#LANG_COMMIT[qvi]="d1936ca5c6d281e854497632143bd32d5803252c" #   2022-05-17
LANG_COMMIT[rm]="2e1bb08cc69504ce7d3ee8418cde01c070c278b1" #   2022-06-24
LANG_COMMIT[ro]="de1113d8613b112c14d8e75a3e1e0ce7b1a6236e" #   2022-06-25
LANG_COMMIT[ru]="22416553f0282f7055d5a11cd12e5ce39e66c88d" #   2022-06-28
LANG_COMMIT[rw]="c96b40a319aa1e8f65971d44e2849affa3477ff6" #   2022-05-17
LANG_COMMIT[sah]="988099fd3db43890b47b68e05a20729ead2f8b08" #   2022-05-17
LANG_COMMIT[sat]="0448105f88a4e5d4c327cd0fcca8ab8d424e7fb3" #   2022-05-24
LANG_COMMIT[sc]="816d3ff5ddd92ef48ca5f346708f108c91be7cb5" #   2022-06-10
LANG_COMMIT[scn]="0f3e10bb4c6e129efb1a216aa69a332255975c68" #   2022-05-17
LANG_COMMIT[sco]="f950c4f3697b79f3007f5e2258f08549d6b89868" #   2022-05-17
LANG_COMMIT[si]="c7cc2c593899b65931f7a1b234a1487eb8f23769" #   2022-05-17
LANG_COMMIT[sk]="fae9a6775af61fe36c8df7f81cdb68e2a195a5d9" #   2022-06-27
LANG_COMMIT[sl]="d19eef659d387117a1b3dd4b9ea4f8e363b91381" #   2022-06-27
LANG_COMMIT[son]="5d49bcb0255fa5f44c2416c11d97d38117e9c760" #   2022-05-17
LANG_COMMIT[sq]="77fab9e442fd46c939d0cc4eb5b68f257e7b018e" #   2022-05-17
LANG_COMMIT[sr]="90973fd9f124f8f1b2e7320f5ce626e92c479df0" #   2022-05-17
LANG_COMMIT[ss]="e44d0fc60b28f8236484e967a46c3550d1b21258" #   2022-05-17
LANG_COMMIT[st]="f5a163f6033d428340b73a34cee0cc5377b52e6e" #   2022-05-17
LANG_COMMIT[sv-SE]="a81d25fcbdb14eb04a5c7c25b75d781a2102dd0c" #   2022-06-26
LANG_COMMIT[sw]="c9d5fc36da2e6f6b5c6a6117e6f303d6c3748974" #   2022-05-17
LANG_COMMIT[szl]="cef7e070dac3c109bf4d3d4a927dfff5cc2c30ea" #   2022-06-05
LANG_COMMIT[ta]="fc958d33d35d7928f72771a8000b12f4e003f7b1" #   2022-05-17
LANG_COMMIT[ta-LK]="7b5c55c8c19113876ea5617d31fa827bb8925668" #   2022-05-17
LANG_COMMIT[te]="2b70768c6bb88a7a81abbfeb6cd32042c1d53a7c" #   2022-05-17
LANG_COMMIT[tg]="6db775921d2d2d4649b7de4241d548ebfb2a4771" #   2022-06-28
LANG_COMMIT[th]="4d19b047cf19ac1af16d9cf2c53e9c5976c5c039" #   2022-06-18
LANG_COMMIT[tl]="11c52d8c62012ea90c35eb65b26899463e71d750" #   2022-06-08
LANG_COMMIT[tn]="6a9bb7771513145af059954a596ecb75f2f2ee28" #   2022-05-17
LANG_COMMIT[tr]="c70e2b076b0c9a222361317e9cc765dbd22a9942" #   2022-06-23
LANG_COMMIT[trs]="05c82f620c2d1dc3c6218c1a503bd0ab705bc870" #   2022-05-17
LANG_COMMIT[ts]="d6231f61aec0006d9751090a94dcb601b009319c" #   2022-05-17
LANG_COMMIT[tsz]="5a52f612272ec37523ac208911dee591085f2aac" #   2022-05-17
LANG_COMMIT[uk]="897df368e489662e283ba30cccd9b01872d67135" #   2022-06-27
LANG_COMMIT[ur]="b2d0d9f13adb353589fd87a0240726c8d3debe27" #   2022-05-22
LANG_COMMIT[uz]="a8a73897ada62b8799c435998aab4e283558bcc3" #   2022-05-17
LANG_COMMIT[ve]="12be37eafc6e546f5621f92756184ab9dcbf5a21" #   2022-05-17
LANG_COMMIT[vi]="21911fb81d6636b15ab9387e3c6b13bd06e38765" #   2022-06-23
LANG_COMMIT[wo]="958daaf04369af06e862d3d11ab6a52f03151832" #   2022-05-17
LANG_COMMIT[xcl]="496d56c7f4460cca1d7931e832ef888b92787a77" #   2022-05-17
LANG_COMMIT[xh]="8e3b5561c5f38bacc61d43a7bc33ba2f2e91a3f9" #   2022-05-17
LANG_COMMIT[zam]="80b7b26fa04e4a2b7646a6b3b488631d7dcbda4f" #   2022-05-17
LANG_COMMIT[zh-CN]="d9bd02fd9a56cbc76cb8439170a589c192ba93c0" #   2022-06-28
LANG_COMMIT[zh-TW]="c49e508cb63108171aab8682ce3feb21f40857e8" #   2022-06-27
LANG_COMMIT[zu]="0e1ccd037db3cdb2d63441a79af6c733eaf2596c" #   2022-05-17

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
