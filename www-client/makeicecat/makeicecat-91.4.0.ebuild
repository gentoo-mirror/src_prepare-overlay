# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="dd79d69e5dc6e6e751195001f322b30746be6903"

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
LANG_COMMIT[ach]="f86822300b0fe645c761aeff85fdc14b3739b777" #   2021-12-06
LANG_COMMIT[af]="88b3255e99cf022c5645c5cc1681b7350a2789af" #   2021-11-24
LANG_COMMIT[ak]="71e4761c862f6396a1f63c88bc85ff50f6a04a66" #   2021-11-09
LANG_COMMIT[an]="1fd6771f1cde67ed1ea3a6e7e72ee6fbb006049a" #   2021-12-06
LANG_COMMIT[ar]="4f9dcae55ef95c897b54db05e6dd5a81b63e9968" #   2021-12-06
LANG_COMMIT[as]="26489fb14b4ced8ce967e567c71745f5470a55fa" #   2021-11-24
LANG_COMMIT[ast]="4b2dc9a391f8b3e2bcf2f3dcb8f200eeb6d22f98" #   2021-12-06
LANG_COMMIT[az]="94c8ce3f253b39c54701f37aafcc649f125ebcb1" #   2021-11-24
LANG_COMMIT[be]="96089ec93066fc3925f98c8926ef92a6286aaf2a" #   2021-12-06
LANG_COMMIT[bg]="52a652139739cf072480c5b542184036f337c246" #   2021-12-06
LANG_COMMIT[bn]="5758634fc42d4d6a5a6e43f35dd7df6a7d886fa5" #   2021-12-06
LANG_COMMIT[bn-BD]="04730c2232692e8b771c94000520207feb5383d1" #   2021-12-06
LANG_COMMIT[bn-IN]="1ab90458e3b8ea8fc06e8bb9c1695f9b8c8b750a" #   2021-11-24
LANG_COMMIT[bo]="58764617facaf3b7efbade4d9b197f22912769b3" #   2021-11-22
LANG_COMMIT[br]="b56d09efeff4ddb625168534638c9b4729f345f9" #   2021-12-06
LANG_COMMIT[brx]="8a1b2b2d3a5a38cad9d21bd7e35b33a6c7728a99" #   2021-11-24
LANG_COMMIT[bs]="a20825a8f6dc0b2a07f942f90ca333bd030cdbbd" #   2021-12-06
LANG_COMMIT[ca]="980c45b32872e3ee1e141b2c05a29feb9b1d4905" #   2021-11-24
LANG_COMMIT[ca-valencia]="e61ca216c9f0e0e83cdf23d6936f83c80fb7da59" #   2021-11-24
LANG_COMMIT[cak]="f151e036d09a3b329f8933dc07090a53270e1be4" #   2021-12-06
LANG_COMMIT[ckb]="c6ee017f05fde1b1232b057ba8f99e42bf64dab5" #   2021-11-24
LANG_COMMIT[crh]="c86fa3fefe03305c010dcd30cb9fc8ac9f63b89f" #   2021-12-06
LANG_COMMIT[cs]="6699545aba35ff89dc4da234186f94b7d120d818" #   2021-12-09
LANG_COMMIT[csb]="87157d7e0d71917e76700de4a8205b11d6bccb84" #   2021-11-09
LANG_COMMIT[cy]="6158e2cc1c7bc96abda7017a4376aacbdb43790b" #   2021-12-06
LANG_COMMIT[da]="3b4104011b018eab027606bb5852e3fe24677d02" #   2021-12-06
LANG_COMMIT[de]="0c29f10a2c9dd79e1e523dbb9b164d38542c494e" #   2021-12-07
LANG_COMMIT[dsb]="282bc572d641101ef18c9d6107611f9e917f3c40" #   2021-12-06
LANG_COMMIT[el]="335b615b41b97c116eacbcea779fcf5cd9cb85f4" #   2021-12-06
LANG_COMMIT[en-CA]="0477580416ce5a7d6ed48c418f9b3da7e5058cd7" #   2021-12-06
LANG_COMMIT[en-GB]="30c671613ff7b4cfac5b068e1aca85c542808eae" #   2021-12-07
LANG_COMMIT[en-ZA]="70b85e09f9c05b5d230be88bd3b402d1b9797789" #   2021-11-24
LANG_COMMIT[eo]="895cc55f5f26551cedbc41dbcd3605eb2c671698" #   2021-12-06
LANG_COMMIT[es-AR]="21f279b17a5c26de3afde291f5ddc1142be0794b" #   2021-12-09
LANG_COMMIT[es-CL]="43bc1301885f76d0955e44068e872a35d55a0704" #   2021-12-07
LANG_COMMIT[es-ES]="7675a5601501b0327daf56b48fd4a2404cdb0e30" #   2021-12-06
LANG_COMMIT[es-MX]="661b27d997c0d5474ce7ab2a119f6ecdb5ffc32b" #   2021-12-06
LANG_COMMIT[et]="02957b326b650835d2920e8a1b8db702ad7d30b7" #   2021-12-09
LANG_COMMIT[eu]="f4bcec905840ddf0cde07fee5722b5276dc5ac43" #   2021-12-06
LANG_COMMIT[fa]="0b96c0a94633cc51a30b810920b8ebcc823dfaa3" #   2021-12-06
LANG_COMMIT[ff]="3a212997b73f97fc39a5ca03556cb57c8bf09672" #   2021-12-06
LANG_COMMIT[fi]="94cc8b1a2a02567f92561dd7155880b50edb5197" #   2021-12-09
LANG_COMMIT[fr]="7155cdac25f50d8efb44532f8f57ce02e562668c" #   2021-12-08
LANG_COMMIT[frp]="75a1d35b88b90e56a0169a61e5d33e8711794372" #   2021-10-01
LANG_COMMIT[fur]="da459bf27ee85b630bb0ec3dd9fccc5f74c22898" #   2021-12-06
LANG_COMMIT[fy-NL]="3bd34a7ffc48ace1a6c7342f5096cbe6b0e7850a" #   2021-12-07
LANG_COMMIT[ga-IE]="13543599b7f3c6c968d88b4d172e7dcbe68e7a4c" #   2021-12-06
LANG_COMMIT[gd]="597267ed0c27031b9cab27a74d7465b0860ac467" #   2021-12-06
LANG_COMMIT[gl]="dbb062b509407cf174d03e7ba90f9c17a533b4c7" #   2021-12-06
LANG_COMMIT[gn]="00cf93e8511d444394b633f363c734a3158e171b" #   2021-12-07
LANG_COMMIT[gu-IN]="8a2fd55747b2d4b25bd092ed179b70f0d22adb92" #   2021-12-06
LANG_COMMIT[gv]="d52278929e23ede73dc3329dd43f8d704ffb6695" #   2021-09-08
LANG_COMMIT[he]="e2bfc97a70e0c0489e229481c606b7af04700ab3" #   2021-12-06
LANG_COMMIT[hi-IN]="2763a88cab5fb06168026b8caeaf69ebeb3a2126" #   2021-12-06
LANG_COMMIT[hr]="6e601eb1bdc84e6778cd802a89b56eb0c3304ab6" #   2021-12-06
LANG_COMMIT[hsb]="1e25a830cfbdc40c87b911548d88b614fe8f0fd4" #   2021-12-06
LANG_COMMIT[hto]="011111cd0ef5e5f6752028ea195c6a15c6d079fb" #   2021-11-24
LANG_COMMIT[hu]="5aeb7b4f6b384f34eb054c15764face31b82db26" #   2021-12-07
LANG_COMMIT[hy-AM]="6d20571b0c72ccbe15860e677777bb1e87c7e952" #   2021-12-06
LANG_COMMIT[hye]="5a204992952e580c6aa7ca645e15926d880bf77d" #   2021-12-09
LANG_COMMIT[ia]="d17aeaf708bf1d43762b59c8f1eaad97fb325ad1" #   2021-12-06
LANG_COMMIT[id]="68444a4dc1ba7bda0e473c1a07891e3bde236d34" #   2021-12-06
LANG_COMMIT[ilo]="36a2a6ff2cce9f55ea977d57d2fc78ca21bea67a" #   2021-11-22
LANG_COMMIT[is]="3ddf77d7dfcae083a30c77d651925c6b181cd468" #   2021-12-06
LANG_COMMIT[it]="f71685c98f69c532b9501d52b0051f6629fef5b5" #   2021-12-09
LANG_COMMIT[ixl]="8020cb316da59ec3d461c4e8db12f984a4182e1f" #   2021-11-22
LANG_COMMIT[ja]="8211f79c45780c255da3e44737913637b998a152" #   2021-12-06
LANG_COMMIT[ja-JP-mac]="b821347da4973b7d9d406d45d84c6f0ef78a9322" #   2021-12-06
LANG_COMMIT[ka]="3aa3f6f8fc088d22ddaecd4fdd263ab18f021876" #   2021-12-06
LANG_COMMIT[kab]="b6e50d5cff348b65fcce50865c739b3c419d402c" #   2021-12-06
LANG_COMMIT[kk]="9acf9de2252eeafcfee54037366d6f27f3b5f877" #   2021-12-06
LANG_COMMIT[km]="5917bb034bce7cb5dc11cbd7bbf4cebab3cc58e8" #   2021-11-29
LANG_COMMIT[kn]="7044b75d53000b9acdd05eecff390affaa8b6bfc" #   2021-12-06
LANG_COMMIT[ko]="5e0aeeaab72985e70303fbace20e9d0f2f648b2c" #   2021-12-06
LANG_COMMIT[kok]="1199fc09c5d724aa0466c96621a43cb789ee43a5" #   2021-11-24
LANG_COMMIT[ks]="ef04d2278ec1d26e33c50f17c5330f9e816e5c18" #   2021-11-24
LANG_COMMIT[ku]="38bbc3cce37ddf9dae928abc000d59636362ff53" #   2021-11-09
LANG_COMMIT[lb]="37a8d1ad597ef10d4466b07301d6d9b0fc90d754" #   2021-11-22
LANG_COMMIT[lg]="af65ad917705275ecc97f040f9439c96f198d67b" #   2021-11-22
LANG_COMMIT[lij]="c82493bdc61f314b694d9f3111d6c4f4edf6d7f2" #   2021-12-06
LANG_COMMIT[lo]="12b20b61ec5b2d50e308e28d6fd5bc89cf594521" #   2021-11-24
LANG_COMMIT[lt]="8c16988abfc06365037079b3fb4ec63084bfe28a" #   2021-12-06
LANG_COMMIT[ltg]="0caa763ded583f07c075a3fc8c9cb2c4c7e81b0e" #   2021-12-06
LANG_COMMIT[lv]="121fd4e43f3c5793974989d33b1870d01f275127" #   2021-12-06
LANG_COMMIT[mai]="d9baa84819eeb7194f0dac69ae77c01d8232e485" #   2021-11-24
LANG_COMMIT[meh]="c5df26074fa62c358dec91ea0d27fbc24884b611" #   2021-11-22
LANG_COMMIT[mix]="1b2f7a66e396f1ca04622b09849f498e7cb7ec18" #   2021-11-22
LANG_COMMIT[mk]="2f58fecfb4ba393cb4f635c359a7d556a280126f" #   2021-11-22
LANG_COMMIT[ml]="21913de67f23fb7f928dd0f0130431db67e49a48" #   2021-11-24
LANG_COMMIT[mn]="f33845dc7823be1aca6717339ba9f646b2f37d4c" #   2021-11-09
LANG_COMMIT[mr]="edd1ed987271d4d38084b093bc549b0abf47d80e" #   2021-12-06
LANG_COMMIT[ms]="46c196eeaa1ae191b01b926ab23c1d7c4205614c" #   2021-12-06
LANG_COMMIT[my]="9d180832fd427e80716f309faea6563bfcfcbaea" #   2021-11-24
LANG_COMMIT[nb-NO]="c874f83f13c1f269585ad2221e8122af0ceee57e" #   2021-12-06
LANG_COMMIT[ne-NP]="f460c7c6ce932e0e42038a3fde65f96e08e9484a" #   2021-12-06
LANG_COMMIT[nl]="602b01143897eb7ce28ecab7ec06d8d6bdaf78f0" #   2021-12-07
LANG_COMMIT[nn-NO]="573f9b6b8203c0801f926bab4e0d07e10dca4f19" #   2021-12-06
LANG_COMMIT[nr]="a069124a2eed27bba49bc21a6bd1d7d6d33bdfc3" #   2021-11-09
LANG_COMMIT[nso]="a215d7218295902b442ce0f5179dfafd5848c04a" #   2021-11-09
LANG_COMMIT[ny]="e261188b5c6ad0d96a907b48d9f49e40b1dc085d" #   2021-10-01
LANG_COMMIT[oc]="ce76448fc35a4e71d6c40c9f1754c305061c36ca" #   2021-12-09
LANG_COMMIT[or]="236b855042ebc2ab938268319ddd06aa6d0d4f27" #   2021-11-24
LANG_COMMIT[pa-IN]="07f382a77d22b03e490cc55ee742a476afe0af94" #   2021-11-24
LANG_COMMIT[pai]="2465bc9fe35114e1c31e88baf5b8648b2848e721" #   2021-10-01
LANG_COMMIT[pbb]="ccf2d702384173c797c0087e3ce9bba20d1a155c" #   2021-11-09
LANG_COMMIT[pl]="fc592a7c4e4ba7770a4326bfab598f8d94fc5cf2" #   2021-12-06
LANG_COMMIT[ppl]="9f558729c4fffe1e63dce6cf9c001f0268cc094b" #   2021-09-08
LANG_COMMIT[pt-BR]="efd4e1082c55687391a2e3ebf389f79add0ac784" #   2021-12-09
LANG_COMMIT[pt-PT]="a33164d7dede36bccf0afc166c2c88af0bcedcb3" #   2021-12-06
LANG_COMMIT[quy]="41466b36ed08aeccb00dfcd3352c5bc39f2af0f5" #   2021-11-24
LANG_COMMIT[qvi]="9c688f7b915daaa33657804819c562eca375c754" #   2021-09-08
LANG_COMMIT[rm]="6fee9b3d7b59556cd11c5535f284c8178dcb5abf" #   2021-12-06
LANG_COMMIT[ro]="cdeac92d7f74b0f5e5270b9c9113d17a4bd60c89" #   2021-12-06
LANG_COMMIT[ru]="ee4a538eae621849b7158de33b96196fee415043" #   2021-12-06
LANG_COMMIT[rw]="be5070f879d7a89dd53f6b6d7de72d7bb1ffa6c0" #   2021-11-09
LANG_COMMIT[sah]="a9a4ec25503100ed50e23330c16cf3b28731ca1c" #   2021-11-09
LANG_COMMIT[sat]="51bf974dd419db1e49aaf5efcd9d1f995ceebf1f" #   2021-12-06
LANG_COMMIT[sc]="287c378121f00956859c215986def619366980bd" #   2021-12-07
LANG_COMMIT[scn]="a476b4628af3b057b21fe61258fe827e2e21b843" #   2021-11-22
LANG_COMMIT[sco]="6e7f345fb3e91ae98f9f7397c9563b214cfff21e" #   2021-11-24
LANG_COMMIT[si]="577e1168948e167c75780d13856ab1f64c52b723" #   2021-11-24
LANG_COMMIT[sk]="bf786d2841c78a1b67f04e23994510e9a22365fb" #   2021-12-09
LANG_COMMIT[sl]="7533c90a0a46d93d1abbf4375e878d14ac393dbb" #   2021-12-08
LANG_COMMIT[son]="36cb22b07fc304713f67f1de668aced9f6f3b540" #   2021-12-06
LANG_COMMIT[sq]="541cfc0d912877cdfc1c171f49b03131a2e8438b" #   2021-12-08
LANG_COMMIT[sr]="53a0c3003821516f6f4ca554b382c8b29330c5e7" #   2021-12-06
LANG_COMMIT[ss]="b6f77b4c81bd97e5625cfdf562641c57bca54af4" #   2021-11-09
LANG_COMMIT[st]="fc907a18a8b705fa3185371322dc90200605d801" #   2021-11-09
LANG_COMMIT[sv-SE]="8aaa5a42b584c59c83cc299c44ac7c3b9867d5f8" #   2021-12-08
LANG_COMMIT[sw]="a5dd0440feffb160e76aded213acb2d52dfd4edd" #   2021-11-22
LANG_COMMIT[szl]="1899b9c11b25b0629a1aca387278e7fd351e7bd4" #   2021-12-06
LANG_COMMIT[ta]="abbbeb27aaf20717dac742d5f296aee4d604f2b2" #   2021-12-06
LANG_COMMIT[ta-LK]="9b115bccd15da59fb54edb238ba33b290e1ff4b0" #   2021-10-01
LANG_COMMIT[te]="0ef3d0a41f5d7c8fc5f8a649102ef3d51d11ccce" #   2021-12-06
LANG_COMMIT[tg]="4680efcc94cf63409df06307373c50857c16eeab" #   2021-12-06
LANG_COMMIT[th]="575ae1c6b120df3411d1c00cb6ead902cd76cfa5" #   2021-12-06
LANG_COMMIT[tl]="0b391d5c2ba679cd487a3416f94526423948b91d" #   2021-12-06
LANG_COMMIT[tn]="9e5ac6746d2ed67597fdd9b6bb0ba5a29de52c9d" #   2021-11-09
LANG_COMMIT[tr]="9b037a83641556e32ac3045d582332b875c62c89" #   2021-12-08
LANG_COMMIT[trs]="0e8cdd87b4760aca3cd1accd78806618f5eaf160" #   2021-12-06
LANG_COMMIT[ts]="9f9fd6dcc62625df8e934708d7e8e7d62eb60798" #   2021-11-09
LANG_COMMIT[tsz]="2fc235c03f3d34e974c286f74786e0e46b9893ae" #   2021-11-22
LANG_COMMIT[uk]="c18d4b8093d3fed216f4f3f9d59830a2f2148bd8" #   2021-12-08
LANG_COMMIT[ur]="9d0b4c5840b12cfa15f0089f2c354af5e40a0b1b" #   2021-12-06
LANG_COMMIT[uz]="fc5ae6e89ea758637384a3c75e57ae7fd865c253" #   2021-11-24
LANG_COMMIT[ve]="5ba676f6f4a26735875abb57a46c05fa6ed4be23" #   2021-11-09
LANG_COMMIT[vi]="2f9e100eb3c1498602ee755e05d0246704cb3bc3" #   2021-12-09
LANG_COMMIT[wo]="99e031224dd32ae50c67bfacf685fbd95f5fef84" #   2021-11-24
LANG_COMMIT[xcl]="f15c60b3776a3a07ccb0d78f1287e17def98fcd2" #   2021-10-19
LANG_COMMIT[xh]="8b1940abab0fa2384707c51935cbf395d34c11dc" #   2021-11-24
LANG_COMMIT[zam]="f5a2e750b2729eb7ccba99f90904c5d51ac8b4b2" #   2021-11-24
LANG_COMMIT[zh-CN]="90d17d67fae666844e84d2456d8456f1f55727dc" #   2021-12-06
LANG_COMMIT[zh-TW]="623a4321a07f75144c2497267dd7bd0ecc7626b5" #   2021-12-06
LANG_COMMIT[zu]="b87d346c55b1e06edd667da68c0cb8daa2a86379" #   2021-11-09d

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
