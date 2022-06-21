# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="4c39c619daf344f36962d958d809f6d42d3fce4e"
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
LANG_COMMIT[be]="ab457d20536cdad54f18c6f6e6cebfee7f5b4a6a" #   2022-06-15
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
LANG_COMMIT[ckb]="987dfbc214848430b6e9b1d08a8ff8577494f7d8" #   2022-06-03
LANG_COMMIT[crh]="dfe192466f39991dcbc21f8b248b220b10d62c76" #   2022-05-17
LANG_COMMIT[cs]="e53e5925268c9c195ffdad7a5083b02a29083c02" #   2022-06-12
LANG_COMMIT[csb]="bd592a70fcbbb99f6be35835cb609eb540c5a4cb" #   2022-05-17
LANG_COMMIT[cy]="e6ad0bb34909df609371096dbbc0fb7fd9fc81b1" #   2022-06-14
LANG_COMMIT[da]="077998cb89157299bf696cffdd1703eeb975f676" #   2022-06-20
LANG_COMMIT[de]="5254c6983528355bee70d3f2a770aaa22b0a44b3" #   2022-06-19
LANG_COMMIT[dsb]="892f4d188a22c6e8698790cbb151a9b43db60e6f" #   2022-06-11
LANG_COMMIT[el]="c82f4aeaaebf6d0e189b511f5843a3afd8c85591" #   2022-06-18
LANG_COMMIT[en-CA]="2b4588216f0c36f752694298a03ba303857264fc" #   2022-06-01
LANG_COMMIT[en-GB]="be0f991d50e3b17fd17dcde70cd9f00dc9c5bb82" #   2022-06-11
LANG_COMMIT[en-ZA]="54cf33d0642db11923dea2168ccf9a280a3a5aa3" #   2022-05-17
LANG_COMMIT[eo]="bb27864950c776e16b70e23c5dba62e22d52be52" #   2022-06-19
LANG_COMMIT[es-AR]="40b5590086e9b32742f2fa3db7c80437139e6eb0" #   2022-06-15
LANG_COMMIT[es-CL]="5a45bd7004118b473e9dc6710d805ec60134c9f3" #   2022-06-13
LANG_COMMIT[es-ES]="f7b43f5d5b7e8cd8ff7fc647ab840ee44798e6e5" #   2022-06-19
LANG_COMMIT[es-MX]="d474cafda35e3918b23d74ee7cef1a554f54afde" #   2022-06-17
LANG_COMMIT[et]="8e51ec28e4d7cf2f80bdb6f8f8bf94877c003357" #   2022-06-20
LANG_COMMIT[eu]="b4af6f1dc45bbeef0163296b935f62d61335e818" #   2022-06-14
LANG_COMMIT[fa]="4450ed5cf9a2f6cb59efaca74249e46fd8a3ca15" #   2022-05-17
LANG_COMMIT[ff]="d1b11b6833761b14027e32d0385022f75670b21f" #   2022-05-17
LANG_COMMIT[fi]="bdbcebf758fe2e486c6076180e61fafc8cb55a21" #   2022-06-20
LANG_COMMIT[fr]="739d235548164ab87d4cce8c971b7b674f08fc84" #   2022-06-19
LANG_COMMIT[frp]="a781542b7b01f1826608d4de932534e7435e60e1" #   2022-05-17
LANG_COMMIT[fur]="1130a893ba4264f9433cfbb328e01ecc0fb83ecb" #   2022-06-14
LANG_COMMIT[fy-NL]="e3b53c4c7a7d49418d6b12d40128aae0b513410a" #   2022-06-15
LANG_COMMIT[ga-IE]="34c4d96bfa6302358a71597f4dd8407d0276517e" #   2022-05-17
LANG_COMMIT[gd]="aa15289b6855ba2386a92ad276bffa539a999b3c" #   2022-06-01
LANG_COMMIT[gl]="74482758407d771b17cded6ad4ecd0c086438c72" #   2022-05-17
LANG_COMMIT[gn]="a90ef5689e5c5ef3fe77c17c29ec1d646e07f581" #   2022-06-13
LANG_COMMIT[gu-IN]="ff79dfcddf2a11e05a777a94144a897693a59238" #   2022-05-17
LANG_COMMIT[gv]="eb107a763fd4a4882acc145eb947b3d9da769db2" #   2022-05-17
LANG_COMMIT[he]="4fe5d09b25e2239d01f5b6979c17313036b298b0" #   2022-06-11
LANG_COMMIT[hi-IN]="e1f24b9d22ea008cf22feaa6b7257537409154fa" #   2022-05-17
LANG_COMMIT[hr]="bd90e7e8ec75dfcc6f9bafcd7d8abc66d8954f29" #   2022-05-17
LANG_COMMIT[hsb]="d8353becf5b9e0c4fad151ff44ca60f3ae2075c6" #   2022-06-11
LANG_COMMIT[hto]="59b96b5d6a38441c361b899b27f702434833fab1" #   2022-05-17
LANG_COMMIT[hu]="9746ad65058a59aceeab97559b66ba3e52e89690" #   2022-06-13
LANG_COMMIT[hy-AM]="f89c977f264bf4129a8c08e26281f131d6d947eb" #   2022-05-17
LANG_COMMIT[hye]="8819d7eb94dc953668d8f8d69ced25b22d8ac279" #   2022-06-13
LANG_COMMIT[ia]="f19edf7731abe7b16178e3c9fceef7d4fe5892ed" #   2022-06-13
LANG_COMMIT[id]="5e037a8b0a59ebc213d34b361f3571f9d4b7f7e9" #   2022-06-12
LANG_COMMIT[ilo]="1809abfb44649e7b0c471bfdb0e81acf148871cb" #   2022-05-17
LANG_COMMIT[is]="af7a2e89ef8f98d33b9212aa59dc3acc53f9728c" #   2022-06-19
LANG_COMMIT[it]="f24c6544b272b4131cdaaab6caefdf3921020136" #
LANG_COMMIT[ixl]="ee5c64f48f3fad15d1ed24a21d6c13b84079edc7" #   2022-05-17
LANG_COMMIT[ja]="a393cc63e494f30a4c212c729e178a4ab7356a0e" #   2022-06-19
LANG_COMMIT[ja-JP-mac]="16f40bb8f3d731746b39157a30a4b40c73ce1227" #   2022-06-19
LANG_COMMIT[ka]="2cea74990aa1b26e53b620818f7a0ff20afb0f50" #   2022-06-19
LANG_COMMIT[kab]="eac5ce957a57921565446237cfb6db7989b05caa" #   2022-06-16
LANG_COMMIT[kk]="d8858f1bc7528b0daa7ecc63164c899c669b5c31" #   2022-06-19
LANG_COMMIT[km]="6de8999e084759d649d04f5e13d5785e4d755f78" #   2022-05-17
LANG_COMMIT[kn]="3bb8578dea3ffca44ec54854ce1ee2c2434c797a" #   2022-05-17
LANG_COMMIT[ko]="7a6fdaa3812fb7fd1b7865eb5443c53dde177d77" #   2022-06-10
LANG_COMMIT[kok]="80fb1784f8c2f854bd0b1210b763391828f4a9a5" #   2022-05-17
LANG_COMMIT[ks]="6cced9a1730ca62c4ddc01404104a1f1afaeed54" #   2022-05-17
LANG_COMMIT[ku]="17334b1a9f7f1594895b96e89ebdda48f77e1a6e" #   2022-05-17
LANG_COMMIT[lb]="a1ce6699c39d0b1d0d8e431f8e4d4050825e9624" #   2022-05-17
LANG_COMMIT[lg]="2458785cf2dd785aab6b0165c79b50d57e4eb3ea" #   2022-05-17
LANG_COMMIT[lij]="39052998dd6f4d4871ea3d5819ec6a0640558fe8" #   2022-05-17
LANG_COMMIT[lo]="66b2b5d67ce2d32dd3cfade94080addc5a094e7c" #   2022-05-17
LANG_COMMIT[lt]="05c204bbc49fb955c0d3792b797f2ecad9d327ae" #   2022-06-05
LANG_COMMIT[ltg]="9931c72c977340fa66eafea32938c891fb51aeee" #   2022-05-17
LANG_COMMIT[lv]="17457b836cbce7b0ab670dfd9252ef487454a70d" #   2022-05-17
LANG_COMMIT[mai]="f6cbe4cfe05f5074748a9493baec31d4d372975d" #   2022-05-17
LANG_COMMIT[meh]="f7bf11e05855cb532c5c7037cccbcac2e891ae27" #   2022-05-17
LANG_COMMIT[mix]="75caf62d207a6142e0c37dda5fc59a7cde25a8a8" #   2022-05-17
LANG_COMMIT[mk]="cebf57040c92193a3c0a9823726d30db61382c49" #   2022-06-18
LANG_COMMIT[ml]="24cdf868ba0409a8af749dc1c69c53eafc3b033a" #   2022-05-17
LANG_COMMIT[mn]="7488d06459f253c569962c2248a899d429eaf4ad" #   2022-05-17
LANG_COMMIT[mr]="f9ebad7ded4cf994d52d8ee399d76490c8f023e7" #   2022-05-17
LANG_COMMIT[ms]="ffde17468a12124400b67e78aa4d21537f924c54" #   2022-05-17
LANG_COMMIT[my]="b656b72a6762b20e5cfad8bf5a4da633a9fbbf3b" #   2022-05-17
LANG_COMMIT[nb-NO]="1797998306064e2afe88fe5b21a6b7c83a489793" #   2022-06-16
LANG_COMMIT[ne-NP]="e88add0191913802baf7c412fcb782b0e527ece1" #   2022-05-17
LANG_COMMIT[nl]="3b192f4edb5213e325d004453a6f28eabc16c576" #   2022-06-16
LANG_COMMIT[nn-NO]="28bdd662868540209fdad943df879806528b1693" #   2022-06-15
LANG_COMMIT[nr]="1501cad7211442d869c9512af50705a4981432c4" #   2022-05-17
LANG_COMMIT[nso]="c997c23ed218d05e3958bd0e5bcd0449ddb7ae04" #   2022-05-17
LANG_COMMIT[ny]="8ad79fc759351b74a64d402949d0b841714f9ae8" #   2022-05-17
LANG_COMMIT[oc]="47acac2a71893cfff31374b94922e2456c02d512" #   2022-06-19
LANG_COMMIT[or]="e1147f0c4ec4a405fd3ecc38d93e31702a85a318" #   2022-05-17
LANG_COMMIT[pa-IN]="798afc28472d0aa623b7d6ee1d35dccb42f4d1b1" #   2022-06-19
LANG_COMMIT[pai]="80b5b8ff35c2bdec61a0cea95f82a60e74d1e4fc" #   2022-05-17
LANG_COMMIT[pbb]="0dc29cbaed101ca89e363fdfdc1c64d7a123ab47" #   2022-05-17
LANG_COMMIT[pl]="36007fca7dee43f4930c7d4bcc67af3edbd4d377" #   2022-06-18
#LANG_COMMIT[ppl]="9a3798a19745bc38ea9e73752acffb4831511fc5" #   2022-05-17
LANG_COMMIT[pt-BR]="0d4ca05301c9013e32d7f299b84fbe2dd33d4836" #   2022-06-18
LANG_COMMIT[pt-PT]="6c0a2f5dda9f7c139650c268d8ea3a7c58287484" #   2022-06-17
LANG_COMMIT[quy]="7515195839ab60d4072a3d57e93b0410a86be304" #   2022-05-17
#LANG_COMMIT[qvi]="d1936ca5c6d281e854497632143bd32d5803252c" #   2022-05-17
LANG_COMMIT[rm]="871678d8dd89944dad489c6f46e720d523692743" #   2022-06-20
LANG_COMMIT[ro]="010264acd46f11cbc14c51f66bb590d7e4bf657c" #   2022-05-17
LANG_COMMIT[ru]="98740fe9495dc7c7dcdf77f1cbfcd9ee02c07fe9" #   2022-06-14
LANG_COMMIT[rw]="c96b40a319aa1e8f65971d44e2849affa3477ff6" #   2022-05-17
LANG_COMMIT[sah]="988099fd3db43890b47b68e05a20729ead2f8b08" #   2022-05-17
LANG_COMMIT[sat]="0448105f88a4e5d4c327cd0fcca8ab8d424e7fb3" #   2022-05-24
LANG_COMMIT[sc]="816d3ff5ddd92ef48ca5f346708f108c91be7cb5" #   2022-06-10
LANG_COMMIT[scn]="0f3e10bb4c6e129efb1a216aa69a332255975c68" #   2022-05-17
LANG_COMMIT[sco]="f950c4f3697b79f3007f5e2258f08549d6b89868" #   2022-05-17
LANG_COMMIT[si]="c7cc2c593899b65931f7a1b234a1487eb8f23769" #   2022-05-17
LANG_COMMIT[sk]="36881c5d0700ae64795efd0530fc971db9735806" #   2022-06-17
LANG_COMMIT[sl]="a60ba38789291bb9206601efa756510322025549" #   2022-06-19
LANG_COMMIT[son]="5d49bcb0255fa5f44c2416c11d97d38117e9c760" #   2022-05-17
LANG_COMMIT[sq]="77fab9e442fd46c939d0cc4eb5b68f257e7b018e" #   2022-05-17
LANG_COMMIT[sr]="90973fd9f124f8f1b2e7320f5ce626e92c479df0" #   2022-05-17
LANG_COMMIT[ss]="e44d0fc60b28f8236484e967a46c3550d1b21258" #   2022-05-17
LANG_COMMIT[st]="f5a163f6033d428340b73a34cee0cc5377b52e6e" #   2022-05-17
LANG_COMMIT[sv-SE]="5b80c2ae0a7acbc6fc93228979e582624e4ec78a" #   2022-06-12
LANG_COMMIT[sw]="c9d5fc36da2e6f6b5c6a6117e6f303d6c3748974" #   2022-05-17
LANG_COMMIT[szl]="cef7e070dac3c109bf4d3d4a927dfff5cc2c30ea" #   2022-06-05
LANG_COMMIT[ta]="fc958d33d35d7928f72771a8000b12f4e003f7b1" #   2022-05-17
LANG_COMMIT[ta-LK]="7b5c55c8c19113876ea5617d31fa827bb8925668" #   2022-05-17
LANG_COMMIT[te]="2b70768c6bb88a7a81abbfeb6cd32042c1d53a7c" #   2022-05-17
LANG_COMMIT[tg]="6d8604fbcf4a134b2f4931b8c1a6509d24c4b8a9" #   2022-06-19
LANG_COMMIT[th]="4d19b047cf19ac1af16d9cf2c53e9c5976c5c039" #   2022-06-18
LANG_COMMIT[tl]="11c52d8c62012ea90c35eb65b26899463e71d750" #   2022-06-08
LANG_COMMIT[tn]="6a9bb7771513145af059954a596ecb75f2f2ee28" #   2022-05-17
LANG_COMMIT[tr]="acfcc1ead9c1a6e216a7208fa6052c0573a1b334" #   2022-06-15
LANG_COMMIT[trs]="05c82f620c2d1dc3c6218c1a503bd0ab705bc870" #   2022-05-17
LANG_COMMIT[ts]="d6231f61aec0006d9751090a94dcb601b009319c" #   2022-05-17
LANG_COMMIT[tsz]="5a52f612272ec37523ac208911dee591085f2aac" #   2022-05-17
LANG_COMMIT[uk]="523eef823549df8bc48d969e0ede7682c64ead48" #   2022-06-19
LANG_COMMIT[ur]="b2d0d9f13adb353589fd87a0240726c8d3debe27" #   2022-05-22
LANG_COMMIT[uz]="a8a73897ada62b8799c435998aab4e283558bcc3" #   2022-05-17
LANG_COMMIT[ve]="12be37eafc6e546f5621f92756184ab9dcbf5a21" #   2022-05-17
LANG_COMMIT[vi]="c6494671b2949aff6c1b8161343d3c72019f9cdd" #   2022-06-17
LANG_COMMIT[wo]="958daaf04369af06e862d3d11ab6a52f03151832" #   2022-05-17
LANG_COMMIT[xcl]="496d56c7f4460cca1d7931e832ef888b92787a77" #   2022-05-17
LANG_COMMIT[xh]="8e3b5561c5f38bacc61d43a7bc33ba2f2e91a3f9" #   2022-05-17
LANG_COMMIT[zam]="80b7b26fa04e4a2b7646a6b3b488631d7dcbda4f" #   2022-05-17
LANG_COMMIT[zh-CN]="ccdf7081c85960340e57b23c5bf31bc057f64cf3" #   2022-06-15
LANG_COMMIT[zh-TW]="abfd9ef125c20b4ca955da9f6433ce1d0b1c202c" #   2022-06-10
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
