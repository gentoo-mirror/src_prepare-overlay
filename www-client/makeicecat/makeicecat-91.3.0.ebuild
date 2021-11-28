# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="32631cac00953abbac61dc7ab1a0eafbdd59b53a"

SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz -> firefox-${PV}esr.source.tar.xz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz.asc -> firefox-${PV}esr.source.tar.xz.asc
	https://archive.mozilla.org/pub/firefox/releases/89.0/KEY -> Mozilla_pgp_key-20210507.pgp
"

LICENSE="GPL-3"
SLOT="${PV}"
KEYWORDS="~amd64"

IUSE="+buildtarball"

RESTRICT="buildtarball? ( network-sandbox )"

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

MOZ_LANGS=(
	ach af an ar ast az be bg bn br bs ca-valencia ca cak cs cy
	da de dsb el en-CA en-GB en-US eo es-AR es-CL es-ES es-MX et eu
	fa ff fi fr fy-NL ga-IE gd gl gn gu-IN he hi-IN hr hsb hu hy-AM
	ia id is it ja ja-JP-mac ka kab kk km kn ko lij lt lv mk mr ms my
	nb-NO ne-NP nl nn-NO oc pa-IN pl pt-BR pt-PT rm ro ru
	si sk sl son sq sr sv-SE ta te th tl tr trs uk ur uz vi
	xh zh-CN zh-TW
)

declare -A LANG_COMMIT
LANG_COMMIT[ace]="abfffc2c7275204a28701ad4f5a96a8890daad92" #   2021-11-22
LANG_COMMIT[ach]="25f7912237f1cbf8c9d63fb0cc712e81b10e3bf2" #   2021-11-24
LANG_COMMIT[af]="88b3255e99cf022c5645c5cc1681b7350a2789af" #   2021-11-24
LANG_COMMIT[ak]="71e4761c862f6396a1f63c88bc85ff50f6a04a66" #   2021-11-09
LANG_COMMIT[an]="6fd76b9961ed7cebea1790cf11de726e1548027d" #   2021-11-24
LANG_COMMIT[ar]="aaeb4417ef0d070b7da8cc3bddfe86e0c3b7b06a" #   2021-11-24
LANG_COMMIT[as]="26489fb14b4ced8ce967e567c71745f5470a55fa" #   2021-11-24
LANG_COMMIT[ast]="d8185453a0059a353393e75e9ddd14c6f7d3de25" #   2021-11-24
LANG_COMMIT[az]="94c8ce3f253b39c54701f37aafcc649f125ebcb1" #   2021-11-24
LANG_COMMIT[be]="1c898cae028c84f9983b6c7488cf7f8f6a0e8690" #   2021-11-24
LANG_COMMIT[bg]="786912fd79711695c82855a4c0a52ecc6e311597" #   2021-11-24
LANG_COMMIT[bn]="5c5467d2734a4c7a6b47bbdec5d3f298f508e1ef" #   2021-11-24
LANG_COMMIT[bn-BD]="2060b4eb00035a1fe439bbbfe1ce213c04aebad1" #   2021-11-24
LANG_COMMIT[bn-IN]="1ab90458e3b8ea8fc06e8bb9c1695f9b8c8b750a" #   2021-11-24
LANG_COMMIT[bo]="58764617facaf3b7efbade4d9b197f22912769b3" #   2021-11-22
LANG_COMMIT[br]="e3cc5c5dda1c4cfebd7223d68a8ac27e272a4056" #   2021-11-24
LANG_COMMIT[brx]="8a1b2b2d3a5a38cad9d21bd7e35b33a6c7728a99" #   2021-11-24
LANG_COMMIT[bs]="4ac730e1ab3261137c47c9a8e82c7279eacc8bc8" #   2021-11-24
LANG_COMMIT[ca]="980c45b32872e3ee1e141b2c05a29feb9b1d4905" #   2021-11-24
LANG_COMMIT[ca-valencia]="e61ca216c9f0e0e83cdf23d6936f83c80fb7da59" #   2021-11-24
LANG_COMMIT[cak]="8c8a525e7a34ea54e6f4e4b2fa118be8698ee4fe" #   2021-11-24
LANG_COMMIT[ckb]="c6ee017f05fde1b1232b057ba8f99e42bf64dab5" #   2021-11-24
LANG_COMMIT[crh]="c3c9ddcc037363a3800cddf921480603987d91ae" #   2021-11-24
LANG_COMMIT[cs]="b71be2407c75980c485f2cbf3ac42b57ff7327e5" #   2021-11-24
LANG_COMMIT[csb]="87157d7e0d71917e76700de4a8205b11d6bccb84" #   2021-11-09
LANG_COMMIT[cy]="b2d7027503db5bc50f4a8ed4107166a72c98a8b9" #   2021-11-24
LANG_COMMIT[da]="b58d2f932de9cdb4324c9194262aeabcc395106d" #   2021-11-25
LANG_COMMIT[de]="2044bfdda01d5303f8d6e214b9a01f60b8e57eaa" #   2021-11-26
LANG_COMMIT[dsb]="31b168521e6579f2e07831ddc664590ccb70cfc0" #   2021-11-24
LANG_COMMIT[el]="26135fbfe15355a6518730b074eacf4edcc59ca0" #   2021-11-24
LANG_COMMIT[en-CA]="345c906da776981db7f6b629586c36450ca49e6b" #   2021-11-24
LANG_COMMIT[en-GB]="02abf634aa4437987add090b1191e5c206dff81b" #   2021-11-24
LANG_COMMIT[en-ZA]="70b85e09f9c05b5d230be88bd3b402d1b9797789" #   2021-11-24
LANG_COMMIT[eo]="1a0b1a0efc599d4a09955baa678464e8cfbacb4d" #   2021-11-24
LANG_COMMIT[es-AR]="fc796769676fd2ef21b92a64bef8c6801a742e9a" #   2021-11-25
LANG_COMMIT[es-CL]="d26b08055321dfb1afa47a3d076ebb399fb628ea" #   2021-11-24
LANG_COMMIT[es-ES]="7f1bbcc49c00857051bfe9143131e7ddd94866d0" #   2021-11-24
LANG_COMMIT[es-MX]="b1eac43528022d54f3615964968462eb474b97ef" #   2021-11-24
LANG_COMMIT[et]="0029210aa969b5a338920a22b5f36e2995abe71c" #   2021-11-26
LANG_COMMIT[eu]="57dba8684696d0692bd680ef0fcb7aaf7fc89256" #   2021-11-24
LANG_COMMIT[fa]="07a2592b5952f19d53bd7217db7eb73a5c970e96" #   2021-11-25
LANG_COMMIT[ff]="a283afd9f557b01d15725966f31edb3f98f1e226" #   2021-11-24
LANG_COMMIT[fi]="678e8535776d00a78752ed9ef82fc3d5068a55c4" #   2021-11-24
LANG_COMMIT[fr]="a550528c0098598e0916c9dbb6d265d42f73f5b6" #   2021-11-24
LANG_COMMIT[frp]="75a1d35b88b90e56a0169a61e5d33e8711794372" #   2021-10-01
LANG_COMMIT[fur]="a0c278ddfe9a7651a9e406856429d544c6b4fe94" #   2021-11-24
LANG_COMMIT[fy-NL]="4ae6ed286478f03130ceb51dc4972204f5702a4b" #   2021-11-24
LANG_COMMIT[ga-IE]="e915648545040ef03a1a3f474dff09a6978d855b" #   2021-11-24
LANG_COMMIT[gd]="78652d14f1e0516f9698fc6f299f7b827a8c2b59" #   2021-11-24
LANG_COMMIT[gl]="cb964d17286c9d5e4dd3ae1b57f806c37fe84774" #   2021-11-24
LANG_COMMIT[gn]="2d029fc3eb3214ec4ae6c2c0b261d33df70de65d" #   2021-11-24
LANG_COMMIT[gu-IN]="202d4029847a7cfdd881a37d8e2ff9f6f9235a7c" #   2021-11-24
LANG_COMMIT[gv]="d52278929e23ede73dc3329dd43f8d704ffb6695" #   2021-09-08
LANG_COMMIT[he]="ef36ae113a692b477569b3e809068b0e23b7514e" #   2021-11-24
LANG_COMMIT[hi-IN]="db1df7555e038dc19bb5f07e505d9af34aa96d9a" #   2021-11-24
LANG_COMMIT[hr]="b558109040f91cfc02939e3038c0fe73223448fb" #   2021-11-24
LANG_COMMIT[hsb]="2ab02a7110eed2a46aa8da554fc75455c3dc7c2d" #   2021-11-24
LANG_COMMIT[hto]="011111cd0ef5e5f6752028ea195c6a15c6d079fb" #   2021-11-24
LANG_COMMIT[hu]="cbcb123a0ede9b0338c7821bb1450b4f529bba51" #   2021-11-24
LANG_COMMIT[hy-AM]="9f31864d28b635236d657e1a3589f5878d633afe" #   2021-11-24
LANG_COMMIT[hye]="81e98ebe06eed64c826bd899101f5cd3ca98ee27" #   2021-11-26
LANG_COMMIT[ia]="fd6391f74915b07f6b04e7c7056565990f2a2aed" #   2021-11-25
LANG_COMMIT[id]="4093b635eeee71e6105eb3877112ac567d8fa985" #   2021-11-24
LANG_COMMIT[ilo]="36a2a6ff2cce9f55ea977d57d2fc78ca21bea67a" #   2021-11-22
LANG_COMMIT[is]="d2e556465ebcda142796d9aff28373757d7e230d" #   2021-11-24
LANG_COMMIT[it]="6892ced71074b40c807c046e023e4b6736f0256b" #   2021-11-26
LANG_COMMIT[ixl]="8020cb316da59ec3d461c4e8db12f984a4182e1f" #   2021-11-22
LANG_COMMIT[ja]="1b2efb6f96587751951b7d7dcc4d07d259e5e7fd" #   2021-11-24
LANG_COMMIT[ja-JP-mac]="3e4b00e7ee72cc5c8066af117812c7b65954ccc5" #   2021-11-24
LANG_COMMIT[ka]="ff6e173e867c3f374b825b34bcbdf815d93d6039" #   2021-11-25
LANG_COMMIT[kab]="da82bd7f0d9fc4e170ee3a3fe7af91ba00eb7fee" #   2021-11-24
LANG_COMMIT[kk]="fc544286ae2854a7966903935d8c3786ab638a16" #   2021-11-24
LANG_COMMIT[km]="b99a608765cdb1f2a2ff2fc38e3d4271e32f416e" #   2021-11-24
LANG_COMMIT[kn]="948d796b2bf2a22aaf34d60eebaf83ce00e64e68" #   2021-11-24
LANG_COMMIT[ko]="c047b7220a20004665937f239f238a630347d315" #   2021-11-24
LANG_COMMIT[kok]="1199fc09c5d724aa0466c96621a43cb789ee43a5" #   2021-11-24
LANG_COMMIT[ks]="ef04d2278ec1d26e33c50f17c5330f9e816e5c18" #   2021-11-24
LANG_COMMIT[ku]="38bbc3cce37ddf9dae928abc000d59636362ff53" #   2021-11-09
LANG_COMMIT[lb]="37a8d1ad597ef10d4466b07301d6d9b0fc90d754" #   2021-11-22
LANG_COMMIT[lg]="af65ad917705275ecc97f040f9439c96f198d67b" #   2021-11-22
LANG_COMMIT[lij]="2bb5105ab5bef5f9709a65a03c70f4f7b394f7eb" #   2021-11-24
LANG_COMMIT[lo]="12b20b61ec5b2d50e308e28d6fd5bc89cf594521" #   2021-11-24
LANG_COMMIT[lt]="a52b02fd98d0ee0a2a7ab00456a26fe8ea87310f" #   2021-11-24
LANG_COMMIT[ltg]="abe699f2089437840334b26ab711524547428eb3" #   2021-11-24
LANG_COMMIT[lv]="1f985238d393b08556ebb79340ecdfcb0b6a85e0" #   2021-11-24
LANG_COMMIT[mai]="d9baa84819eeb7194f0dac69ae77c01d8232e485" #   2021-11-24
LANG_COMMIT[meh]="c5df26074fa62c358dec91ea0d27fbc24884b611" #   2021-11-22
LANG_COMMIT[mix]="1b2f7a66e396f1ca04622b09849f498e7cb7ec18" #   2021-11-22
LANG_COMMIT[mk]="2f58fecfb4ba393cb4f635c359a7d556a280126f" #   2021-11-22
LANG_COMMIT[ml]="21913de67f23fb7f928dd0f0130431db67e49a48" #   2021-11-24
LANG_COMMIT[mn]="f33845dc7823be1aca6717339ba9f646b2f37d4c" #   2021-11-09
LANG_COMMIT[mr]="f383500ba795566647ae95e3166ffde719e4108f" #   2021-11-24
LANG_COMMIT[ms]="891b99cf2bace9437b257c0727e87bdf4d82bb81" #   2021-11-24
LANG_COMMIT[my]="9d180832fd427e80716f309faea6563bfcfcbaea" #   2021-11-24
LANG_COMMIT[nb-NO]="b5eaa7f48a330edeb9393cf30bedeeb556627598" #   2021-11-26
LANG_COMMIT[ne-NP]="56a66e46491690e51e6126d82a2c9958d281d636" #   2021-11-24
LANG_COMMIT[nl]="24ca91d18a4d3be9fd1bd2b6b4be150f0e4d25d6" #   2021-11-25
LANG_COMMIT[nn-NO]="48caa5931c26fcba34211c9200be1f619e47c346" #   2021-11-24
LANG_COMMIT[nr]="a069124a2eed27bba49bc21a6bd1d7d6d33bdfc3" #   2021-11-09
LANG_COMMIT[nso]="a215d7218295902b442ce0f5179dfafd5848c04a" #   2021-11-09
LANG_COMMIT[ny]="e261188b5c6ad0d96a907b48d9f49e40b1dc085d" #   2021-10-01
LANG_COMMIT[oc]="9b4dbf2beb6c8ca173f91d701e0955357e90f807" #   2021-11-25
LANG_COMMIT[or]="236b855042ebc2ab938268319ddd06aa6d0d4f27" #   2021-11-24
LANG_COMMIT[pa-IN]="07f382a77d22b03e490cc55ee742a476afe0af94" #   2021-11-24
LANG_COMMIT[pai]="2465bc9fe35114e1c31e88baf5b8648b2848e721" #   2021-10-01
LANG_COMMIT[pbb]="ccf2d702384173c797c0087e3ce9bba20d1a155c" #   2021-11-09
LANG_COMMIT[pl]="dd077c7fa4711eef96cf9ddf99c5eceeecdd6203" #   2021-11-24
LANG_COMMIT[ppl]="9f558729c4fffe1e63dce6cf9c001f0268cc094b" #   2021-09-08
LANG_COMMIT[pt-BR]="f79e5e60c459819a2d88913fd82bf078dc7edb9f" #   2021-11-24
LANG_COMMIT[pt-PT]="cc25e3fca4c768eca36e56c1b21c98a723ebe5fe" #   2021-11-25
LANG_COMMIT[quy]="41466b36ed08aeccb00dfcd3352c5bc39f2af0f5" #   2021-11-24
LANG_COMMIT[qvi]="9c688f7b915daaa33657804819c562eca375c754" #   2021-09-08
LANG_COMMIT[rm]="a4ec54512eb8dad82d7424b5067241e0c1222489" #   2021-11-24
LANG_COMMIT[ro]="047dc6d6b6adfdf41153779fe00861dfb501a45d" #   2021-11-24
LANG_COMMIT[ru]="926290e4cc195fdd14b209f2a1bd3c2c35381024" #   2021-11-24
LANG_COMMIT[rw]="be5070f879d7a89dd53f6b6d7de72d7bb1ffa6c0" #   2021-11-09
LANG_COMMIT[sah]="a9a4ec25503100ed50e23330c16cf3b28731ca1c" #   2021-11-09
LANG_COMMIT[sat]="b1d6f930fdc275a34c6eb7dfb6732f1f42f7114c" #   2021-11-24
LANG_COMMIT[sc]="99839067d6cc6551cf6643fad9a264e4f9eafc5c" #   2021-11-25
LANG_COMMIT[scn]="a476b4628af3b057b21fe61258fe827e2e21b843" #   2021-11-22
LANG_COMMIT[sco]="6e7f345fb3e91ae98f9f7397c9563b214cfff21e" #   2021-11-24
LANG_COMMIT[si]="577e1168948e167c75780d13856ab1f64c52b723" #   2021-11-24
LANG_COMMIT[sk]="beadb6203af35defc71a71afc62c6d0d98ae67c6" #   2021-11-25
LANG_COMMIT[sl]="b089dcebba2bc97a7a254e04388384a50ea86a72" #   2021-11-24
LANG_COMMIT[son]="ebe8f04a3aa140501aba18aba120d333157a4414" #   2021-11-24
LANG_COMMIT[sq]="32bb31896a8d90626eaf4ba054b553d1fa98b1aa" #   2021-11-26
LANG_COMMIT[sr]="c5be8de00340062d2bce0af3046e712b96c81125" #   2021-11-24
LANG_COMMIT[ss]="b6f77b4c81bd97e5625cfdf562641c57bca54af4" #   2021-11-09
LANG_COMMIT[st]="fc907a18a8b705fa3185371322dc90200605d801" #   2021-11-09
LANG_COMMIT[sv-SE]="9d25f621bcb5d272522834c6182586dc05e80f87" #   2021-11-25
LANG_COMMIT[sw]="a5dd0440feffb160e76aded213acb2d52dfd4edd" #   2021-11-22
LANG_COMMIT[szl]="5412e31bb42dc8669943c0f0bce939b244b675a7" #   2021-11-24
LANG_COMMIT[ta]="9365b6ebaf00f3adea989a12e498afa7a08e2bc5" #   2021-11-24
LANG_COMMIT[ta-LK]="9b115bccd15da59fb54edb238ba33b290e1ff4b0" #   2021-10-01
LANG_COMMIT[te]="b45c06b66c22031b60936051cac52baa19c9de1f" #   2021-11-24
LANG_COMMIT[tg]="20929b0fde4250bdba5a9d88e6474891b9d6968f" #   2021-11-25
LANG_COMMIT[th]="0755013b861abf026c4993de15174acd3efc6354" #   2021-11-24
LANG_COMMIT[tl]="b86635b9fae29c30cd73c1b6359ae2c65dcbff92" #   2021-11-24
LANG_COMMIT[tn]="9e5ac6746d2ed67597fdd9b6bb0ba5a29de52c9d" #   2021-11-09
LANG_COMMIT[tr]="73e6cf559bfd3f552267660a68e5077e3e270b95" #   2021-11-24
LANG_COMMIT[trs]="92155b4b2f8a1e194515e82e38d725d35e612e5a" #   2021-11-24
LANG_COMMIT[ts]="9f9fd6dcc62625df8e934708d7e8e7d62eb60798" #   2021-11-09
LANG_COMMIT[tsz]="2fc235c03f3d34e974c286f74786e0e46b9893ae" #   2021-11-22
LANG_COMMIT[uk]="bb0f29750c59e1d62055b0db08600f0c87673767" #   2021-11-25
LANG_COMMIT[ur]="4469d72b1ffbfbcd9ed3940755ea50558191fc07" #   2021-11-24
LANG_COMMIT[uz]="fc5ae6e89ea758637384a3c75e57ae7fd865c253" #   2021-11-24
LANG_COMMIT[ve]="5ba676f6f4a26735875abb57a46c05fa6ed4be23" #   2021-11-09
LANG_COMMIT[vi]="7d718c79f78a5c0d956ce8ce7b566dc9d9fd5ae4" #   2021-11-24
LANG_COMMIT[wo]="99e031224dd32ae50c67bfacf685fbd95f5fef84" #   2021-11-24
LANG_COMMIT[xcl]="f15c60b3776a3a07ccb0d78f1287e17def98fcd2" #   2021-10-19
LANG_COMMIT[xh]="8b1940abab0fa2384707c51935cbf395d34c11dc" #   2021-11-24
LANG_COMMIT[zam]="f5a2e750b2729eb7ccba99f90904c5d51ac8b4b2" #   2021-11-24
LANG_COMMIT[zh-CN]="b8dfd7a958cdb4c348e9c7dc0a31f1e232d08409" #   2021-11-25
LANG_COMMIT[zh-TW]="8f466cc3049c65a8ec6e4d8b4ef37420b70fda8f" #   2021-11-24
LANG_COMMIT[zu]="b87d346c55b1e06edd667da68c0cb8daa2a86379" #   2021-11-09

fetch_l10n() {
	local lang
	for lang in "${MOZ_LANGS[@]}" ; do
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
}

src_prepare() {
	default_src_prepare

	# Making sure that latest Mozilla public key is available for verying the firefox tarball
	gpg --import "${DISTDIR}/Mozilla_pgp_key-20210507.pgp" || die

	mkdir "${S}/output" || die
	cp "${DISTDIR}/firefox-${PV}esr.source.tar.xz" "${S}/output" || die
	cp "${DISTDIR}/firefox-${PV}esr.source.tar.xz.asc" "${S}/output" || die

	mkdir "${S}/output/l10n" || die
	for lang in ${MOZ_LANGS[@]}; do
		#en_US is handled internally
		if [[ ${lang} == en-US ]] ; then
			continue
		fi
		mv "${WORKDIR}/${lang}-${LANG_COMMIT[${lang}]}" "${S}/output/l10n/${lang}" || die
		mkdir -p "${S}/output/l10n/${lang}/browser/chrome/browser/preferences" || die
		touch "${S}/output/l10n/${lang}/browser/chrome/browser/preferences//advanced-scripts.dtd" || die
		rm -rf "${S}/output/l10n/${lang}/.hg*" || die
	done
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
