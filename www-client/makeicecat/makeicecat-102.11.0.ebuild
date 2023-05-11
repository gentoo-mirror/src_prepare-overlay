# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="5a1894fc966840dc242110ec0459471c637a4675"
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
LANG_COMMIT[ace]="be7788b05cdf333ae4858e80da2e141d69bab89a" #   2023-05-04
LANG_COMMIT[ach]="6c76d3a257059e5ad63d865e69a54c16392f4816" #   2023-05-04
LANG_COMMIT[af]="0a46cc3e228ba2ff622bf9b268067620bc0730d7" #   2023-05-04
LANG_COMMIT[ak]="7559c7055b4a0270ecee2d16057d4af9128ab41c" #   2023-05-04
LANG_COMMIT[an]="2bd2961cf983e88de082d82e32e433494d8dc234" #   2023-05-04
LANG_COMMIT[ar]="e8b6eb5229132384680804bf410a79ada25d3d22" #   2023-05-04
LANG_COMMIT[as]="1467325c22f62b87467c85e1bc8a5d9eda62c21b" #   2023-05-04
LANG_COMMIT[ast]="03b49c85b8371c8cff4aeb2648ee54b2fa4485b1" #   2023-05-04
LANG_COMMIT[az]="8297276b7eb22a922f6cc451ac6c5eb6cf4c764e" #   2023-05-04
LANG_COMMIT[be]="20443da1d1d435a871044f58d59074a4511870a9" #   2023-05-07
LANG_COMMIT[bg]="d92009c16ec38ef9f246f6b1c6f1f2089ec5b433" #   2023-05-04
LANG_COMMIT[bn]="88e26cecb6732a1638e3c4a476efceb0744b8567" #   2023-05-04
LANG_COMMIT[bn-BD]="1b201b0e766d797a675a13e606a77c2a0aacef58" #   2023-05-04
LANG_COMMIT[bn-IN]="df6bda4e11ba21dcf7b1dcb5d2bbdf7c83964431" #   2023-05-04
LANG_COMMIT[bo]="935ab5e1bfd0a815465c5708739664296908366c" #   2023-05-04
LANG_COMMIT[br]="6cb0051dee7978262a511cb46f1925d5db8004cd" #   2023-05-05
LANG_COMMIT[brx]="1000d2df3c96127585f0a14e25291c6fe6c584c7" #   2023-05-04
LANG_COMMIT[bs]="7f1e6809115158ac2b16ddab31dec88a52facbe4" #   2023-05-04
LANG_COMMIT[ca]="f44bfd51f7b27913a0155f9f5377ebed371f3161" #   2023-05-04
LANG_COMMIT[ca-valencia]="9063b1493493d8af3f46636187e3005830020d1a" #   2023-05-04
LANG_COMMIT[cak]="009f604d1b5ceed445c38aec693a623ee57c0fe6" #   2023-05-08
LANG_COMMIT[ckb]="673f57c3acf1b6a5f632a8c65b75a2cafb1e6061" #   2023-05-04
LANG_COMMIT[crh]="795706f56558a7501161065dd29298995dafa8af" #   2023-05-04
LANG_COMMIT[cs]="bfecb930964379527f5e304695ac0268f5f9db29" #   2023-05-06
LANG_COMMIT[csb]="cc5428e870fea4fdb950a80a599fb26d2f54d735" #   2023-05-04
LANG_COMMIT[cy]="f605b5ff5fc4b2cef1df703063c83f60853a47b6" #   2023-05-04
LANG_COMMIT[da]="faa893f3432f3d0789f7bd12f6ed46f48ddf33c4" #   2023-05-08
LANG_COMMIT[de]="652da82e5d4c892bcd98dfb5fd59ab3c01376fa3" #   2023-05-07
LANG_COMMIT[dsb]="f7a9e5ae01f873971035d1443dd2fbecded45601" #   2023-05-07
LANG_COMMIT[el]="ab536eebf4dfdb67fe381bd3ad664e62f844979b" #   2023-05-05
LANG_COMMIT[en-CA]="9c48b14218c9d190b66659d0f4dbe1a31aed848e" #   2023-05-04
LANG_COMMIT[en-GB]="6c0305c220a35c54e6b3e21254cb1ff37aab42fd" #   2023-05-06
LANG_COMMIT[en-ZA]="b0403e0287f58caf757726632367a61798f4e74d" #   2023-05-04
LANG_COMMIT[eo]="011abf9ef65b991d5bc78445f40add9e29fe403a" #   2023-05-04
LANG_COMMIT[es-AR]="9f8d4e56125591eabce0d7d015fb6ee56a35dcdf" #   2023-05-06
LANG_COMMIT[es-CL]="470817963fe265b0f48ee3726555776466ce55e6" #   2023-05-06
LANG_COMMIT[es-ES]="b5dad0705ad25bfb82583f0d8cd5a8f4aaa1f30d" #   2023-05-04
LANG_COMMIT[es-MX]="e963c7f9b00447b4aa8e17b3358f35df97ea4e65" #   2023-05-08
LANG_COMMIT[et]="55e4c15506d38930d329b4f2ba117ffa9dd99384" #   2023-05-04
LANG_COMMIT[eu]="6be93c1a76d84d242a4c15cba5c3b1483cd0be22" #   2023-05-04
LANG_COMMIT[fa]="52f45560620f65cf26518060fd0446a321e52466" #   2023-05-05
LANG_COMMIT[ff]="fa4fc6e67db01fcc1012a6dc08026cc1e356d0c7" #   2023-05-04
LANG_COMMIT[fi]="b2233dcaf31d36971bae282215096960fce61865" #   2023-05-04
LANG_COMMIT[fr]="90b9546fd42672241c5b95e90458aa23d3141ecd" #   2023-05-08
LANG_COMMIT[frp]="5e2ebaa9f6df38b155bd4bd78be1cf921a9e5613" #   2023-04-21
LANG_COMMIT[fur]="efaca0f58e1f34468447073b4c561f95cfd0b781" #   2023-05-05
LANG_COMMIT[fy-NL]="936ca0820b90b53ad0f08ea0994680d4beeef838" #   2023-05-04
LANG_COMMIT[ga-IE]="b980882ff4a67197332d7cb0891280573592dc6c" #   2023-05-04
LANG_COMMIT[gd]="dec3ee9c891a476b7708d62c2e6440c918c6d9a0" #   2023-05-07
LANG_COMMIT[gl]="36b6169bdbe12ab01ac7a30a01c9f243c399f84e" #   2023-05-08
LANG_COMMIT[gn]="17de39ca70bea73ae8dcf4d8313a449686db16cd" #   2023-05-04
LANG_COMMIT[gu-IN]="999b1ddec4bf0c758e28294869c33f53887c3b57" #   2023-05-04
LANG_COMMIT[gv]="dc546b0511676906544d4379e7a2fa5b63faf089" #   2023-04-13
LANG_COMMIT[he]="b2f1c492439c25b4fc1f4cbef88244ae8ab073e7" #   2023-05-07
LANG_COMMIT[hi-IN]="f9180f4b72de4c3978cceb32d3ceb67c2cb4c44d" #   2023-05-04
LANG_COMMIT[hr]="59101789baddf92681d4039c64e649783a35fb24" #   2023-05-08
LANG_COMMIT[hsb]="69396d65157b8b9422214cc9183bbf7ee75942d2" #   2023-05-07
LANG_COMMIT[hto]="97c189ba2ce0b3684be561fc3a271d5a85a22220" #   2023-05-04
LANG_COMMIT[hu]="50c46659243444a705bb243115e49ab31279d7b0" #   2023-05-05
LANG_COMMIT[hy-AM]="d671151372daa3db18c20e1977aa60ac30298f21" #   2023-05-04
LANG_COMMIT[hye]="edeb45b6ab567d81d034bf2c7b5e46ecaab6ea3d" #   2023-05-04
LANG_COMMIT[ia]="2b6b6f23aa8843ea436d61dce48723cfe454b3ca" #   2023-05-08
LANG_COMMIT[id]="43b1f21447ee72b0b046da02d4acfa740c80353b" #   2023-05-04
LANG_COMMIT[ilo]="94381c289f99905ed529d240f697424bb68e1688" #   2023-05-04
LANG_COMMIT[is]="27ff3f548fb22a31b55fe7db54795351d4e0111f" #   2023-05-04
LANG_COMMIT[it]="3a1ad7d878e14298891617dc99692684b5875dcf" #   2023-05-09
LANG_COMMIT[ixl]="bddeb41bdfcb3bc61555046677bea5f591852cb1" #   2023-05-04
LANG_COMMIT[ja]="89b1a0cd47ea0cc5962ae7acdd5f6dd9de44fa87" #   2023-05-04
LANG_COMMIT[ja-JP-mac]="ab1593698aed90a697755da9fe58619e59ad9583" #   2023-05-04
LANG_COMMIT[ka]="f85d5a75394f1426f8f426d2f9bd194f5af1dec7" #   2023-05-04
LANG_COMMIT[kab]="12f000955d093cc07597666b1b7d408e2d447974" #   2023-05-07
LANG_COMMIT[kk]="596b9442cda5795c4de75c8a277ed7bbb99cf8e8" #   2023-05-09
LANG_COMMIT[km]="88f8d0cfffa31f8d71dbb1bbb2bfaa814b067017" #   2023-05-04
LANG_COMMIT[kn]="d6733f8f2b217a0f581da0e99b5503679d15fdba" #   2023-05-04
LANG_COMMIT[ko]="110629894c91f363ef5cde3352ff6a44055d2d26" #   2023-05-09
LANG_COMMIT[kok]="44ba850f59b2176604719cc6351de3971a312a28" #   2023-05-04
LANG_COMMIT[ks]="ed8a90a4fc0276ab3f6ca7e74fed03e491fd8488" #   2023-05-04
LANG_COMMIT[ku]="c23ea11d167edfe320e545f3fc86dca859441a0a" #   2023-05-04
LANG_COMMIT[lb]="3cfdd0fb63338007632d05abb827bc6567f072cc" #   2023-05-04
LANG_COMMIT[lg]="b5b4d6f8c47e650b91aa44b3c87b9d1062308d59" #   2023-05-04
LANG_COMMIT[lij]="b5bf19498be31cb4bf75af7fa0a03c3ea22afe71" #   2023-05-04
LANG_COMMIT[lo]="f3cccee36002bb022417ef92dae9e264f353710f" #   2023-05-09
LANG_COMMIT[lt]="6a3b6cf62d828f9d1a8f15c6c2645cf59291678f" #   2023-05-06
LANG_COMMIT[ltg]="ae22d2eb9a1c1f2575467a56272191525dc37db4" #   2023-05-04
LANG_COMMIT[lv]="705e2c85cb2eacd95a64e76cf4bad8162593785b" #   2023-05-04
LANG_COMMIT[mai]="148f3e3f58d8bc6f0dc027535d04841a7659b27e" #   2023-05-04
LANG_COMMIT[meh]="a9d1c98f3f2003353fe19cc2e42fb3cbc5fbfb6c" #   2023-05-04
LANG_COMMIT[mix]="e36b2e23228aa1d1357da4db54b06057c868350c" #   2023-04-21
LANG_COMMIT[mk]="603abbe6acedcb1eac3258c5592853e446c7d5c1" #   2023-05-04
LANG_COMMIT[ml]="323012758824d0546cd65d7566f374bcd1879cae" #   2023-05-04
LANG_COMMIT[mn]="cc8971e2fdae906143e676df1a08de75598ff273" #   2023-05-04
LANG_COMMIT[mr]="c0c67ca08171275adcbd19b98ecc73fb0ca5c093" #   2023-05-04
LANG_COMMIT[ms]="e0c0f3216b58716a1dddc1bff2b212cf197190b4" #   2023-05-04
LANG_COMMIT[my]="4113f6659f7aecf41169fc7ec7a45830f54d1c88" #   2023-05-04
LANG_COMMIT[nb-NO]="be8d6ecc126a7ec7c5fc3cf67f9cfab0ca937c13" #   2023-05-04
LANG_COMMIT[ne-NP]="2cf91cf94b58194e20faa63558997384f6c4e7b6" #   2023-05-04
LANG_COMMIT[nl]="c118f0b9f8560b9d51768328cee25b9a8790536d" #   2023-05-09
LANG_COMMIT[nn-NO]="d5d500a675ee178aa072ed4ef2a43351dfa42779" #   2023-05-07
LANG_COMMIT[nr]="f18d00af50d3f8ee68cdc297c6e3946e97fe8b2c" #   2023-04-11
LANG_COMMIT[nso]="4b9825af59254008134779c9194e514c4cb436be" #   2023-05-04
LANG_COMMIT[ny]="f2d607deb37acc4c563ab1211996d7d18571b555" #   2023-05-04
LANG_COMMIT[oc]="1ebcfa8167b80f59d4f84a2fd2d8af2775256c61" #   2023-05-07
LANG_COMMIT[or]="369b53d6e03e21127edf3f229a92adcd6af057e2" #   2023-05-04
LANG_COMMIT[pa-IN]="780ebe1bbd7a9f72b3a5a6448c860cbf195e1861" #   2023-05-04
LANG_COMMIT[pai]="f153bcb0986448667d6e2d147592953981038c0d" #   2023-05-04
LANG_COMMIT[pbb]="60d35b101fbc2ed626647e9dcaee19804250f9fa" #   2023-05-04
LANG_COMMIT[pl]="6fc5ca236b66ecd6b8539076cfa54cf9ebf97685" #   2023-05-04
LANG_COMMIT[pt-BR]="98b83fd0d80a621b1aa01a11b4e9cf22e8a804df" #   2023-05-06
LANG_COMMIT[pt-PT]="07243250ca9cceb75f27517cc43901b011f8a7ed" #   2023-05-04
LANG_COMMIT[rm]="ea3e3710cefff27b7496deded2cebeb55a536952" #   2023-05-04
LANG_COMMIT[ro]="691beaae88d64cb52b99a13ae4afeb50c4f70471" #   2023-05-06
LANG_COMMIT[ru]="fec0131590a4a219b0e0be53e453805a68bbfd1e" #   2023-05-07
LANG_COMMIT[rw]="d64158b2ee03a857e132a925a13f7481c0bb96cb" #   2023-03-16
LANG_COMMIT[sah]="bed1d68a6961fb42a58e0ec6596a3d57c37bf8df" #   2023-05-04
LANG_COMMIT[sat]="12dba53c5814b002cea6d7f4724bb7135c9b1729" #   2023-05-07
LANG_COMMIT[sc]="276fea0d5fa8913667c8e3773f941199a9fd81ce" #   2023-05-04
LANG_COMMIT[scn]="6246e816daa30b36adad9af8b4c4d214b3468ddc" #   2023-05-04
LANG_COMMIT[sco]="1fb914dd89f9a6d6a374251fd19f1b52a512a268" #   2023-05-04
LANG_COMMIT[si]="b8375c682a491b93a6943aaf69e6fe83d4b4700e" #   2023-05-04
LANG_COMMIT[sk]="179ffeed69dce5b804112360eafafbbdeaab13dd" #   2023-05-08
LANG_COMMIT[sl]="caf17273652228c172fb55a5538dda10e6423ab4" #   2023-05-08
LANG_COMMIT[son]="f22bf9e8190c9529b4edcec6c802eed20522a64f" #   2023-05-04
LANG_COMMIT[sq]="b1eb43b6b511fc16c84e38c2ec68c9428f78e329" #   2023-05-04
LANG_COMMIT[sr]="cb689e64cfc28fcd702ed650c697e5c4b2d3f7dd" #   2023-05-04
LANG_COMMIT[ss]="af0fa0e3baca4249ba483f55276ef638b48dddd4" #   2023-04-21
LANG_COMMIT[st]="4555ea8f2512292fe4adfb8d2d9b948686d56966" #   2023-04-11
LANG_COMMIT[sv-SE]="cc0cbe4811269c9b9c7c3a72ecbe776d20ca2762" #   2023-05-06
LANG_COMMIT[sw]="df50f038bbe7452c193680feb576f7ce2f588ff1" #   2023-05-04
LANG_COMMIT[szl]="469628bfde81c54acafe281389ab76235c8860af" #   2023-05-04
LANG_COMMIT[ta]="f8a6373902738e354070e85eaec696183ff5e4cd" #   2023-05-04
LANG_COMMIT[ta-LK]="cc5b191263a125c1ee4162dd631123e9e20d46ca" #   2023-04-21
LANG_COMMIT[te]="4fd156f29b689afeb39cef0519ef15bdf0fd926b" #   2023-05-04
LANG_COMMIT[tg]="dc84b20b87db95dcd796913b8eacf0af869ad0d3" #   2023-05-08
LANG_COMMIT[th]="40bd9b95eccbbd74dc122650ef2931ed50b17be0" #   2023-05-05
LANG_COMMIT[tl]="d72e5d9172d02e1676d95b9b5b2e590b74b61a32" #   2023-05-04
LANG_COMMIT[tn]="2559633734f2e9a888bef44892a8cb47717fde1c" #   2023-05-04
LANG_COMMIT[tr]="71a2f849b6f18ce1f3efa97bcff1ef83294b7763" #   2023-05-04
LANG_COMMIT[trs]="17c30f9b1e664a68c0de70ac34a5cef77a6074cd" #   2023-05-04
LANG_COMMIT[ts]="db4e4fd6b96f2ca7a6f75331ea3f37fc0a739c43" #   2023-04-11
LANG_COMMIT[tsz]="f5166aa9a8f07ca13f7ff8516926aeae501b6b2e" #   2023-05-04
LANG_COMMIT[uk]="683de60cb052367ac409f3925bc35f56321c73d6" #   2023-05-07
LANG_COMMIT[ur]="273373a80fd0eb720e0d83df0bc14146ed68ba67" #   2023-05-04
LANG_COMMIT[uz]="481564e95fdd912bae30757be0fad7a25534b2d8" #   2023-05-04
LANG_COMMIT[ve]="b8e92dc6b06339136b87d4ba33fcb41d79509253" #   2023-04-11
LANG_COMMIT[vi]="ef96b95c910ff270733f32b0f40394dc6306fdb9" #   2023-05-06
LANG_COMMIT[wo]="995b7733fcd6d0851193f117ba031d98fe491999" #   2023-05-04
LANG_COMMIT[xcl]="bf81441a34569250d52bab58ad3c4a9e583509a9" #   2023-04-21
LANG_COMMIT[xh]="3fd21a85b8ceb02e03ee32a58700d20f11948e42" #   2023-05-04
LANG_COMMIT[zam]="e9523c4479a4f93a591355b9f5f2c1471a25900f" #   2023-05-04
LANG_COMMIT[zh-CN]="039196d5b0cfc5057cce1c7f82e5af3d6ca1a689" #   2023-05-07
LANG_COMMIT[zh-TW]="e6d4175c28c239cd17230914c3063a367e6999b6" #   2023-05-05
LANG_COMMIT[zu]="e26d616214c173b6eb29d2d72407cf77514ba718" #   2023-05-04

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
