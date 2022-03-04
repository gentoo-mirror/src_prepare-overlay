# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="6c4accb674d2df8be0aabfa03f7679f66bbf70f5"
L10N_REV_COMP="587012866a2b6898d37be3d50016be437989f67e"
SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz -> firefox-${PV}esr.source.tar.xz
	https://hg.mozilla.org/l10n/compare-locales/archive/${L10N_REV_COMP}.zip -> icecat-compare-locales-${L10N_REV_COMP}.zip
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
LANG_COMMIT[ach]="977c0eee5774e3bd19a25900142d1dca3eb2ee29" #   2022-01-17
LANG_COMMIT[af]="162654a20c86192e124df9766ec5ecd54143d085" #   2022-01-06
LANG_COMMIT[ak]="016d55423f1da4b5de32ee8cbcf7898118d12473" #   2022-01-06
LANG_COMMIT[an]="d10834e1c7ba839ba9c372205f4371c4d3c19791" #   2022-01-06
LANG_COMMIT[ar]="11550f5f34f7c4bb641cd62369bc9c198248618c" #   2022-01-26
LANG_COMMIT[as]="b44ae7a12113d545a666f18033c91858d368273b" #   2022-01-06
LANG_COMMIT[ast]="41dcea23a9d890ee00cb4cc3797559fe461244bc" #   2022-01-17
LANG_COMMIT[az]="0366cdbc61ed5620510c848b85cd593d376c75f3" #   2022-01-17
LANG_COMMIT[be]="abf0478add79930beb3097c2304f3f2225d92e41" #   2022-02-06
LANG_COMMIT[bg]="36c2b720e031299cc64ca36b8ad73405afbf15e7" #   2022-02-03
LANG_COMMIT[bn]="010d5f74034cb2c18fd1100e0d0888a245d52a60" #   2022-01-17
LANG_COMMIT[bn-BD]="3d534d7d3797931d9d886e28dbd6657b4ff7a1cb" #   2022-01-17
LANG_COMMIT[bn-IN]="fe46ec9c6a1fab36c0715dc2a5df86f957a531ed" #   2022-01-06
LANG_COMMIT[bo]="97059fd9d1a83e254bf84da12f1612062e82d271" #   2022-01-06
LANG_COMMIT[br]="858100c5ec0740e1894d1272de9a1b4e2d72b33e" #   2022-02-04
LANG_COMMIT[brx]="573ec21d6a1aebf6a342533bb06b77c79b6e994b" #   2022-01-06
LANG_COMMIT[bs]="9ebb98165b36860f938bfb97c1956090e8daf920" #   2022-01-17
LANG_COMMIT[ca]="ed3ceba213d7c1462f9ead5665b92c3f6ee44945" #   2022-02-02
LANG_COMMIT[ca-valencia]="d8f8751d595bf879afe5bfa8e3854ee5b6d1b977" #   2022-01-17
LANG_COMMIT[cak]="0bbd8b94c9c02fa5ec6a3e5fd3bf3e69b0432829" #   2022-01-17
LANG_COMMIT[ckb]="bd043d903599db44feb371bf29d4a3d510a48a0a" #   2022-01-06
LANG_COMMIT[crh]="ee017344c9935dbaac5e737fdb7b396944ce92d0" #   2022-01-17
LANG_COMMIT[cs]="142eaea80044ef2c53c7986c4a2e26259d46e011" #   2022-02-04
LANG_COMMIT[csb]="cfca971fd3676f22b831325bdcaf89d2dae8da6d" #   2022-01-06
LANG_COMMIT[cy]="5ec73257e61e8efec15086579949df7e74069eee" #   2022-02-14
LANG_COMMIT[da]="6ccb92ba0b671548fcdb2040bf42bb21604f3d92" #   2022-02-15
LANG_COMMIT[de]="e138c597027dc665c2c06aa90b22e6df235f907a" #   2022-02-09
LANG_COMMIT[dsb]="a5a3284f3845e18003e88fd0b0c822dc5982a381" #   2022-02-10
LANG_COMMIT[el]="e5e338c560af146680fb0bb0e69d002055c9dd12" #   2022-02-11
LANG_COMMIT[en-CA]="47495d026325edbcf500b88c437bfa20d066db7e" #   2022-02-15
LANG_COMMIT[en-GB]="f623ff497604a1f24b6b57e2fba32368f5e27d7d" #   2022-02-10
LANG_COMMIT[en-ZA]="8b696d61e2f653738e1e9d38086f0464bc4c5f9e" #   2022-01-06
LANG_COMMIT[eo]="879b99194c7b241e4a68b6ea73f295c41539db01" #   2022-02-13
LANG_COMMIT[es-AR]="44975e7ce27d8d895af5c35909a9fc748eb86fd2" #   2022-02-11
LANG_COMMIT[es-CL]="7494321544d9a289dcdcfb687ba6ae407553694d" #   2022-02-10
LANG_COMMIT[es-ES]="618aebaeaca4b82aa3072b4ceb59e2c1debc2dd7" #   2022-02-14
LANG_COMMIT[es-MX]="970fd46401ea471ba6f886607f2124424cc9a189" #   2022-02-08
LANG_COMMIT[et]="6232a1e2884cdef938578c8fa62d94a0daf5e496" #   2022-02-10
LANG_COMMIT[eu]="ed8fb7ed0677c4b36a5b50cfb07a1e968bb9a6d6" #   2022-02-15
LANG_COMMIT[fa]="fb843f2121544da95b60b20d7147be7069091be2" #   2022-02-15
LANG_COMMIT[ff]="ec175d67f9056e5fd2cb6568ee546336efb77d5c" #   2022-01-17
LANG_COMMIT[fi]="bde25da854ae4e6a12a9b5cb9326fd1e6428eca7" #   2022-02-15
LANG_COMMIT[fr]="bf61dd44e1c6b5292077ca980a4dc0e2c6a17f06" #   2022-02-14
LANG_COMMIT[frp]="1f7e8a74a38847bb61bdaa59b9c4087232409beb" #   2022-01-06
LANG_COMMIT[fur]="f7443e146b5c0bcef3c4afa8df76af7e24967854" #   2022-01-17
LANG_COMMIT[fy-NL]="218bf89139061fb15ad7aced1c6fb5ffc8c9dcce" #   2022-02-15
LANG_COMMIT[ga-IE]="2d955174d7ab6068656b2f02e4d8c689bb2399bf" #   2022-01-10
LANG_COMMIT[gd]="00dad207fa7a90fb3f30d81fc309767eed8b9b8b" #   2022-01-20
LANG_COMMIT[gl]="12d14b505e0fc7ab9ca38b3d3e4530acb008fff8" #   2022-01-20
LANG_COMMIT[gn]="1d9bd033efad77505dfe23021203fedbb9083271" #   2022-02-14
LANG_COMMIT[gu-IN]="d2c670d798b925090af6321cb3270fa6f806108d" #   2022-01-17
LANG_COMMIT[gv]="f2fc53ab3d11da177cc94ad7ed6e136ab27bf269" #   2022-01-06
LANG_COMMIT[he]="2aa7b17642d24e276a005793d76ba2b3bdc5facf" #   2022-02-08
LANG_COMMIT[hi-IN]="274838883f7f1f14d5f14d5116e7df11cc404911" #   2022-01-17
LANG_COMMIT[hr]="d51b43f56056d1e5efd34e15059cb9eb8d34f5f7" #   2022-02-11
LANG_COMMIT[hsb]="4ca8bb594b515fecca5763b2320c113472bff832" #   2022-02-15
LANG_COMMIT[hto]="dc63a5c6a9c9cc98602262b039b6b11c76d628e5" #   2022-01-06
LANG_COMMIT[hu]="f2ddbe0eeeef462861f509b7874b18ab3c35a0f3" #   2022-02-16
LANG_COMMIT[hy-AM]="c5f29b8efc600b11b60af8837fe195c8652072f2" #   2022-01-31
LANG_COMMIT[hye]="58b5de2c61c2c664fbd322d68d26c29ecd7ecc2d" #   2022-02-16
LANG_COMMIT[ia]="97b0f4d4ab1c3679263855ad61fe71279a5f138a" #   2022-02-12
LANG_COMMIT[id]="b460cd7f7b3867e1db00b09c064bb7e3279991a4" #   2022-02-12
LANG_COMMIT[ilo]="a0b9dc5857dbdecc57f876f053014002cf2305cd" #   2022-01-06
LANG_COMMIT[is]="ae2175c511c37cf68c41f78f5d779fda66741c3c" #   2022-02-15
LANG_COMMIT[it]="ef1dec7ba71313c104804620b858f49edad60406" #   2022-02-16
LANG_COMMIT[ixl]="f76c5867094658a58456e202779f5216235fabac" #   2022-01-17
LANG_COMMIT[ja]="74484225b855c06e9cf8332939e6a36c2cd0493b" #   2022-02-06
LANG_COMMIT[ja-JP-mac]="c9a06fd559d5eac83be838c2c992f28c39324356" #   2022-02-06
LANG_COMMIT[ka]="300bd68426f1a75e754e0aceee03b0cf257524a3" #   2022-01-27
LANG_COMMIT[kab]="34cdd7ae3a2706650cb51cc379fb0c2b25516169" #   2022-02-06
LANG_COMMIT[kk]="f34ffb08787eb336151f6218a295c218cb6f49e2" #   2022-01-27
LANG_COMMIT[km]="c04f31c98e50315177467bd4e079200d3b38b835" #   2022-01-06
LANG_COMMIT[kn]="0bc693a82c819a27e71f41828c040e7be4b92785" #   2022-01-06
LANG_COMMIT[ko]="17fe8344f59d13cf19d1126f21e4c02dcf3921f2" #   2022-02-09
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
LANG_COMMIT[nb-NO]="0bc72f781481f50e11e9313f1baa214f8f2e73a4" #   2022-02-15
LANG_COMMIT[ne-NP]="5676e8e0b93e18fb5eeb238953c512d4f407340c" #   2022-01-06
LANG_COMMIT[nl]="22a4e7c33e985047132db447d7e1bb71702d374c" #   2022-02-15
LANG_COMMIT[nn-NO]="35102ac77bebd2c8751b9d41bc964398c5b02dff" #   2022-02-10
LANG_COMMIT[nr]="b812f24744280f56682cf2ada7f252c3d10b5230" #   2022-01-06
LANG_COMMIT[nso]="284888d07de6a01f08acf74c0005938261be25e1" #   2022-01-06
LANG_COMMIT[ny]="b6c1a809d12fb11656d255e3792b0af62557d527" #   2022-01-06
LANG_COMMIT[oc]="2bcda92b3f759992b1c19cf182a805e894ed2cb5" #   2022-02-14
LANG_COMMIT[or]="dd4117a6306811f85bd427c15023597a8cdb802f" #   2022-01-06
LANG_COMMIT[pa-IN]="bbfc43db3f0349eff76131142d6621b1d45e21ab" #   2022-02-12
LANG_COMMIT[pai]="c83cfee2ebb4d0ba889d11bf3bf612652985fc0a" #   2022-01-06
LANG_COMMIT[pbb]="7f952a799823c4684a7d9222588ba2de6b3069d2" #   2022-01-06
LANG_COMMIT[pl]="4eafa8d7ea2792dbb8aaa11a20c01688a65302f3" #   2022-02-09
#LANG_COMMIT[ppl]="26ee9bc20a9361b03653b82bdae58bfa87e1797b" #   2022-01-06
LANG_COMMIT[pt-BR]="26d128c87881a7ab52c787cf483771d22ce3dd60" #   2022-02-16
LANG_COMMIT[pt-PT]="53625bcbd4d9093f325d98edc087b5f22453b821" #   2022-02-11
LANG_COMMIT[quy]="9c3130f42c678b15ce1d536d565b740612596c95" #   2022-01-06
#LANG_COMMIT[qvi]="cf1900a2362788f000d14e27673f59cf0e4aa972" #   2022-01-06
LANG_COMMIT[rm]="91906bb9c17686385dd1f647e1169e7136b77524" #   2022-02-16
LANG_COMMIT[ro]="ba7fe96d6c98e01a48f442d520c39d119c7e0727" #   2022-01-17
LANG_COMMIT[ru]="66b17e807de6262c50cdfbfd2d9dc5f07d3f3e3a" #   2022-02-12
LANG_COMMIT[rw]="48cbd9cb539b75ab37a5808383fcbc0887a44a0a" #   2022-01-06
LANG_COMMIT[sah]="12fb102e7bc76dab1456ed0b88fc14c73f981ca9" #   2022-01-06
LANG_COMMIT[sat]="07d8d17940d6c5b34422d3868fe8fb6195917ac3" #   2022-02-16
LANG_COMMIT[sc]="14a1b41f804a89dd00d978056ebfc966a638cbb8" #   2022-01-17
LANG_COMMIT[scn]="6729c4bfb82228012e51e2077cf8f2ce254e8fe6" #   2022-01-17
LANG_COMMIT[sco]="8aed4c4ac1dd708f213d350a46617cd3faca0a09" #   2022-01-17
LANG_COMMIT[si]="639820754f8563d1fccf89f48c4b155db6a3ae8d" #   2022-01-06
LANG_COMMIT[sk]="53d798cb63ce1fe3b2efb74747ed8e15f4107ee0" #   2022-02-08
LANG_COMMIT[sl]="94847137bceb69343cbd4f3b0b3ad44d08f09502" #   2022-02-13
LANG_COMMIT[son]="1541de0c90d66751ae72c24d4fa8105a585cf203" #   2022-01-06
LANG_COMMIT[sq]="05efafdd60c5a69d6d75adf8ccb97c5b07aee239" #   2022-01-17
LANG_COMMIT[sr]="fc2038de2801930ce585dd1817c3de3367523630" #   2022-02-14
LANG_COMMIT[ss]="82188bb8444fb9b1436f72664c5d4ca49d1ae316" #   2022-01-06
LANG_COMMIT[st]="ac23a90a715031a3d31caa8fd83c6cbe6f75a6fe" #   2022-01-06
LANG_COMMIT[sv-SE]="a4fe5b2d85d36420e7e83efed62183a2cd7f9ffd" #   2022-02-09
LANG_COMMIT[sw]="82318e61508faba1806a969e15810fe8c280bbdb" #   2022-01-06
LANG_COMMIT[szl]="000ee773591f17bcd9fc5ed5eb504000a016ce5b" #   2022-01-06
LANG_COMMIT[ta]="2545635e99da1c3bdfc3536ba8c6a68a7498d014" #   2022-01-17
LANG_COMMIT[ta-LK]="ed472d476e6823843f16cf7fb54a4e0272d16610" #   2022-01-06
LANG_COMMIT[te]="0c5e4eb71c5ffe04c651f377355ead0f976960cd" #   2022-01-17
LANG_COMMIT[tg]="8324518ee86b916b2b333e12be5272587f6e706b" #   2022-02-16
LANG_COMMIT[th]="9c09c46a50141cfb213f77a97a78df9a2c37cce7" #   2022-02-09
LANG_COMMIT[tl]="c7615e24b3453bb59a41eb017db2e04c781c8782" #   2022-01-17
LANG_COMMIT[tn]="335e015d7dfc8ae5639660d1907b7fdb7b02e037" #   2022-01-06
LANG_COMMIT[tr]="a14cd1c820286ebc48d122c33458cbd32f3dcda1" #   2022-02-15
LANG_COMMIT[trs]="43debe20e58afdd09ddbcd2f7dd62039c1e8c5f8" #   2022-01-06
LANG_COMMIT[ts]="c399d15ac7c8b32ffee8bdac14539181ea7aab37" #   2022-01-06
LANG_COMMIT[tsz]="d47c303e79c080e90a0ec9337a75a843c729bd21" #   2022-01-06
LANG_COMMIT[uk]="1a54b745e7350cfb51464aded5c596f53cc7ca08" #   2022-02-15
LANG_COMMIT[ur]="d7318f049d0d3544f36aa9023f94faff13b7d950" #   2022-01-20
LANG_COMMIT[uz]="9bf0718f3dc3c70e34fdf556c3006adde39a1635" #   2022-02-09
LANG_COMMIT[ve]="d4f51eb857143131eb70733a15fd558e14ab727d" #   2022-01-06
LANG_COMMIT[vi]="78b72670d90773e63e12febbb66f4b07b9c7ff8c" #   2022-02-12
LANG_COMMIT[wo]="625cc2e007db82c90ecddd39e34f1969c4088e09" #   2022-01-06
LANG_COMMIT[xcl]="6d6d615e1753f149a4c00788dac23f98acc0f5c7" #   2022-01-06
LANG_COMMIT[xh]="09a4bf9ceb7fe52e7fd54b2c8a15c16c6a4c56f2" #   2022-01-06
LANG_COMMIT[zam]="4840c22c1cdffa89f4ba2ed3341ed1a2572c9f93" #   2022-01-06
LANG_COMMIT[zh-CN]="413aae81fe1c8dabdd9978618d0f741318809f5f" #   2022-02-15
LANG_COMMIT[zh-TW]="05f141fae4316ba05cb4e5d5716a500e4ca112ad" #   2022-02-08
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
	unpack "icecat-compare-locales-${L10N_REV_COMP}.zip"
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
	mv "${WORKDIR}/compare-locales-${L10N_REV_COMP}" "${S}/output/compare-locales" || die
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
