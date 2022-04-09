# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="3aec3e591e7b1de0bfe5025a54ef5771a9823917"
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
LANG_COMMIT[ace]="f6155e909f24705f4ab25a5007827bfd9f3dc814" #   2022-03-18
LANG_COMMIT[ach]="a6a1f17aa1023d85c1c75e67d83947f13a4f00c5" #   2022-03-25
LANG_COMMIT[af]="0165be0dce2a94e07085503f4470759e782c18fb" #   2022-03-25
LANG_COMMIT[ak]="eac0f78f05e1d12cdbb51e01729c3747a7658333" #   2022-03-25
LANG_COMMIT[an]="dad9f15dc642da60b09c237834d4473c58dea052" #   2022-03-25
LANG_COMMIT[ar]="564a022e3f9b0c816405b55950c4ec638cff67e5" #   2022-03-25
LANG_COMMIT[as]="491b4239255ffd87da11ad6b3611768d75915986" #   2022-03-25
LANG_COMMIT[ast]="764385536c2e67d9eb62df4f99234a6d48fc133c" #   2022-03-25
LANG_COMMIT[az]="9db736d30a182d19b9bd31891e7216b6dbc71310" #   2022-03-25
LANG_COMMIT[be]="6a2713cb6c4d3dde777ea62b4ff2c90495e49812" #   2022-04-01
LANG_COMMIT[bg]="37d8b5725368d51ff1655358da2d68270a45dd28" #   2022-03-25
LANG_COMMIT[bn]="2f4e1c45a3c66f9a2d06feb5372a8f4cd918dc87" #   2022-03-25
LANG_COMMIT[bn-BD]="b12503c3cc2d5813097f092fed60de2db8628dce" #   2022-03-25
LANG_COMMIT[bn-IN]="107b16ed2ca95236f2fac82d482672911d131311" #   2022-03-25
LANG_COMMIT[bo]="f5ceb27fb60ab4774a8d65f8f38f33ecaeb386f0" #   2022-03-25
LANG_COMMIT[br]="c08f24e5583203027c897e99854322fe3004f9e8" #   2022-03-25
LANG_COMMIT[brx]="1e9598fd3437a97c5e0e653bec9f4eae8c5ffbb0" #   2022-03-25
LANG_COMMIT[bs]="fd4b2d33c2ab71c93aac76c9d8cf9e1387e3f1f2" #   2022-03-25
LANG_COMMIT[ca]="03a1366dfcacacc5536fc9efc48c6baea1859057" #   2022-03-25
LANG_COMMIT[ca-valencia]="23f8f5ff3f7622ba40a2e4ded555a1927c09e68f" #   2022-03-25
LANG_COMMIT[cak]="69b0a5895506621c0ba887904adea46a742f3c2e" #   2022-03-25
LANG_COMMIT[ckb]="2edde20e15361f5ba8de7796d8f4d79e3f05ec8c" #   2022-03-25
LANG_COMMIT[crh]="773f748ca6754a84803e05949d3efc43997cda44" #   2022-03-25
LANG_COMMIT[cs]="ff948c073ef9d169d57a2ec889607c17ddf72069" #   2022-04-05
LANG_COMMIT[csb]="376da039898ec83cb52fb268bee95e47f5adab11" #   2022-03-25
LANG_COMMIT[cy]="9a0cfe023125d6a5d3d478f695a1b36fa38a5d1b" #   2022-04-04
LANG_COMMIT[da]="7cd9a9c8351db26178c0685cef253402cc01cd09" #   2022-04-08
LANG_COMMIT[de]="9709cbf2a1f4524f32279b129b4d5918249a2b6f" #   2022-04-06
LANG_COMMIT[dsb]="6f7971449d1dcedfe47b8d1550711baff3ab48e8" #   2022-04-05
LANG_COMMIT[el]="86a6d243ef757ec5f5999acc52cff3af8470fe6c" #   2022-04-07
LANG_COMMIT[en-CA]="d4eeb05b4901ca84d8ec0c534d665a3f18d91593" #   2022-04-02
LANG_COMMIT[en-GB]="993337c98643339c20f76d56589fbcd7eda04339" #   2022-04-03
LANG_COMMIT[en-ZA]="3abdaa085584697da6ab3d73bf35dd8543f30a54" #   2022-03-25
LANG_COMMIT[eo]="1e03892fc5c667bf0c01fa6e7229b85a3f751cad" #   2022-04-06
LANG_COMMIT[es-AR]="4e3480e7c4a9649c9c3ee76d48c0811f9ea495ad" #   2022-04-08
LANG_COMMIT[es-CL]="232f5c0992f858d1bd617a97bc6f503de87276c0" #   2022-04-06
LANG_COMMIT[es-ES]="73c2a60896447ba90b10c14adaaeea2e915ef01a" #   2022-04-05
LANG_COMMIT[es-MX]="44885c9349379fbc2c3a3856068a47c8a4a116e0" #   2022-04-02
LANG_COMMIT[et]="dba4681b8881584557ccf6c0fea56122fb7bddc0" #   2022-04-08
LANG_COMMIT[eu]="36e71f59adeef0a59fe1a1d744729039125450f7" #   2022-03-29
LANG_COMMIT[fa]="ffd3f6dc2b7a017abcccef83b7f532274bb44051" #   2022-03-25
LANG_COMMIT[ff]="3b208dd6cbccbb8da37e3337efa2335b77f151aa" #   2022-03-25
LANG_COMMIT[fi]="43932fc3d92f8b71b2425550551e2bde7fe93397" #   2022-04-06
LANG_COMMIT[fr]="57506da6281fcaea823748a6781276ce8a554f9c" #   2022-04-06
LANG_COMMIT[frp]="eaadceefac1e59c56bb34ffb14fdff8509689df9" #   2022-03-18
LANG_COMMIT[fur]="201383bd8b75b53e7502bd2b29bcc3d9e9f79650" #   2022-03-25
LANG_COMMIT[fy-NL]="0716f056ededaba603e5c1e5f00fcb467f573299" #   2022-04-08
LANG_COMMIT[ga-IE]="7dfcc393651a095f490bc8cd47244ada28309c27" #   2022-03-25
LANG_COMMIT[gd]="c6ae71534dd9e3b57b251a254297f8fdada807a1" #   2022-03-25
LANG_COMMIT[gl]="654d4ce4dcbf8bd93503e4c15a97f43675b0592f" #   2022-03-25
LANG_COMMIT[gn]="c922e2880276aefb0dde2ed6910880e36201045a" #   2022-04-04
LANG_COMMIT[gu-IN]="b4e70828715162554b89aefab981a9bbd41a8367" #   2022-03-25
LANG_COMMIT[gv]="3baa8a0b7689d51a6137298d163b8498fd4984f3" #   2022-03-18
LANG_COMMIT[he]="639238bc1dee218cf79874188958cef8ba434725" #   2022-04-07
LANG_COMMIT[hi-IN]="88c2bbb85a170f69bbf318dded191ddbb6de31e8" #   2022-03-25
LANG_COMMIT[hr]="4ce6f0329fa935fb8c261fb85e7e309cb487d93b" #   2022-03-25
LANG_COMMIT[hsb]="467a11445d7b0ebf0aa4485118f6337e9e36e33c" #   2022-04-05
LANG_COMMIT[hto]="7bd2d9d7dec0004c0c34c57ce62d9d1be61a94bc" #   2022-03-25
LANG_COMMIT[hu]="80db3824c61a440330d94034a18f6a155260d08d" #   2022-04-04
LANG_COMMIT[hy-AM]="80a0f9b52c6f4877df8d782f6ccc61ceaa9dd663" #   2022-03-25
LANG_COMMIT[hye]="8b8a52963dce25c63f97c932e7d5d606956b1c66" #   2022-04-08
LANG_COMMIT[ia]="b0b341ab973598b0a5f2d45bf24f6570686696fe" #   2022-04-08
LANG_COMMIT[id]="a4c6c61d2b01b5b5bae878ea63ebd7258ae7695a" #   2022-04-05
LANG_COMMIT[ilo]="eb289c9b09ef4614dd9dde8293cf4291b4382131" #   2022-03-25
LANG_COMMIT[is]="0ea4304030c3c6ac42cf93728db1a0e77c02b5a3" #   2022-04-03
LANG_COMMIT[it]="55eb748f9ba55d03391eb193b00e7a284054d9b9" #   2022-04-06
LANG_COMMIT[ixl]="d3e650806ed04b06baf6a94d0dca4b24fd35a98d" #   2022-03-18
LANG_COMMIT[ja]="041938418d2dda2d0a20dc7f70f44e42182a8d47" #   2022-03-26
LANG_COMMIT[ja-JP-mac]="260e8bb82967d99f70559cfff91e61d74293ebfd" #   2022-03-26
LANG_COMMIT[ka]="d949593f43ebd0095ea98973be2562bbbe49415c" #   2022-04-08
LANG_COMMIT[kab]="5355a35131d324488e956945ec30f07b1e6cbd70" #   2022-04-01
LANG_COMMIT[kk]="40fa338d7f533e25c9766b71e3186c73f99890e2" #   2022-04-03
LANG_COMMIT[km]="2599391fef0945a653647510e6a64ce18c75732a" #   2022-03-25
LANG_COMMIT[kn]="0769d83097c9af6abe2159757273e5b91471298b" #   2022-03-25
LANG_COMMIT[ko]="5d63037fd8bfe3a64382293b2cdb22991568eefe" #   2022-04-08
LANG_COMMIT[kok]="738382271ef2bf055f2c680a452a398bcb4c1c58" #   2022-03-25
LANG_COMMIT[ks]="c7e404d38f6d668477746b335372c8230f619f51" #   2022-03-25
LANG_COMMIT[ku]="1901f1bc082a3ad7c57693fefef89ce4755523f3" #   2022-03-25
LANG_COMMIT[lb]="57c7a26ba4fffeb8a15a82b6de20643608931f4c" #   2022-03-25
LANG_COMMIT[lg]="0c804fb860ed798e4f4a088cab09ffc3467ff36a" #   2022-03-25
LANG_COMMIT[lij]="db2fd21de7be731d7dc2d60261b9d8a7139bebff" #   2022-03-25
LANG_COMMIT[lo]="76d0966925213ee4b4f3f9ae6f9dceffcd7a88b4" #   2022-03-25
LANG_COMMIT[lt]="ecd18d531aae87df37773c439a81304cef1c26ff" #   2022-03-25
LANG_COMMIT[ltg]="190e29bd1ff5ab3ed762c6015275c9fe2dbbe07e" #   2022-03-25
LANG_COMMIT[lv]="359ebfbee1dc8f22b013e2c085e7b7c32e5197ea" #   2022-04-01
LANG_COMMIT[mai]="d923869b0f2f0c9fc9423f7d14d2b547da0c82c2" #   2022-03-25
LANG_COMMIT[meh]="3c2fef23649ba6ef01fe1b300e5a6d8078a0790e" #   2022-03-25
LANG_COMMIT[mix]="cc64d26863c9f1fe6bdca86ec1186ca4482003d1" #   2022-03-18
LANG_COMMIT[mk]="4e1dc80774598c855b322e121c00ecde994e1321" #   2022-03-25
LANG_COMMIT[ml]="26bc585b1b440220ee20bb590dc3272e53681f2d" #   2022-03-25
LANG_COMMIT[mn]="0afd8663c0661778af7b5ef3850d31bfe59e67a4" #   2022-03-25
LANG_COMMIT[mr]="ca47c8f2a44b1905700162915ed28469cd40a191" #   2022-03-25
LANG_COMMIT[ms]="99c14dfc31cbcd11df70350874325e2b18be71ce" #   2022-03-25
LANG_COMMIT[my]="c7a3a3587ae558689bbcf06a2e2c4cd5b50bc926" #   2022-03-25
LANG_COMMIT[nb-NO]="2ebce58d32229c1d28b6ff4bd9b75bdc169d1f45" #   2022-04-05
LANG_COMMIT[ne-NP]="30eda84a67337e77faac0b4bd0c32e9a998a32ae" #   2022-03-25
LANG_COMMIT[nl]="efb998ea332a12459f44b98a50b2661648befcaf" #   2022-04-07
LANG_COMMIT[nn-NO]="17f6ebf5eb5382dd05ea6226dc9de928330683b5" #   2022-04-06
LANG_COMMIT[nr]="e5f83b13ce7038c7a441ec88b1a3075dfee3e920" #   2022-03-25
LANG_COMMIT[nso]="e6c706ffcb02674856bca7f0ee3e0459a2664406" #   2022-03-25
LANG_COMMIT[ny]="83123a045e413fe36dacb7571962f579e38d4589" #   2022-03-18
LANG_COMMIT[oc]="8201e29144c9b156024e996e4432e5aa44ff19e9" #   2022-04-07
LANG_COMMIT[or]="df56c5fdca70d72e418829d8d339e0bbb9fe701f" #   2022-03-25
LANG_COMMIT[pa-IN]="0b4f5dbd3f00114c42c9aefd9cf193ccb9c34ab2" #   2022-03-25
LANG_COMMIT[pai]="0c25bab274807f90a06cd9e57826c0408430fb09" #   2022-03-18
LANG_COMMIT[pbb]="98f3ab336424c0e1235b4560d70ccedd8eceb3c6" #   2022-03-25
LANG_COMMIT[pl]="4b116d976cd47c93ba1c2906d434c4dfc899b670" #   2022-04-03
#LANG_COMMIT[ppl]="15cd35db7510891a372a2d4a14742ab63de01f10" #   2022-03-18
LANG_COMMIT[pt-BR]="e406b257bcae8df8c550a72be4d1265e1020d303" #   2022-04-08
LANG_COMMIT[pt-PT]="e3adf4b215edf04b83e84cc9fb21f99b24df5efd" #   2022-04-04
LANG_COMMIT[quy]="bd23f32f916216f673ce33576bc18df65f45d147" #   2022-03-18
#LANG_COMMIT[qvi]="193e64c2e739aac8da82253ec295d16981b62ce6" #   2022-03-18
LANG_COMMIT[rm]="cd04cf985a34a9097415b2bbb587a860039964fd" #   2022-03-25
LANG_COMMIT[ro]="e0ad5ff53035963292dc5d616a211e3a59350593" #   2022-03-25
LANG_COMMIT[ru]="70d94ffbf052cf39e61324d8a9f98375a544c362" #   2022-04-06
LANG_COMMIT[rw]="c3f86f3fc745b882992296bf3a062635a37d4176" #   2022-03-25
LANG_COMMIT[sah]="186576755410e20ecdc655c7e01c88def668b180" #   2022-03-25
LANG_COMMIT[sat]="5221d4c24af3892b17866e227ac44fd0179a1b23" #   2022-04-05
LANG_COMMIT[sc]="8dd9dcac4c457767190acd11dcfdd8fb98bc07cb" #   2022-04-07
LANG_COMMIT[scn]="f5ed91ac56160875a03d5f7aa29824ffa635e4ba" #   2022-03-25
LANG_COMMIT[sco]="13ae1b5a7950b64b0c6a345f5d0f679df45fce9e" #   2022-03-25
LANG_COMMIT[si]="d95bba5c8188d000865636bbacdfb9d1da678082" #   2022-03-25
LANG_COMMIT[sk]="e159017af95204c1ce13e07edac4f82170cdc55d" #   2022-04-05
LANG_COMMIT[sl]="97b7f64a7c2baf462f6aa554cee7f54a84edc74d" #   2022-04-02
LANG_COMMIT[son]="ee30412da10637ef7cf8aad070cc988b6445ef27" #   2022-03-25
LANG_COMMIT[sq]="10f45c5e8baa0962c79093df33f99e0c8b14c6f8" #   2022-04-08
LANG_COMMIT[sr]="dcc3f5478c5cb5b64d9868390ba5ef625095dfa9" #   2022-04-06
LANG_COMMIT[ss]="ca9116cc7cfdebd118bd85e1c8ad71764e17da79" #   2022-03-25
LANG_COMMIT[st]="c75a436d4445fa054bdd44be1650c138a6437ee1" #   2022-03-25
LANG_COMMIT[sv-SE]="9e38bb83edb1fdfe23dc6fb54cb0263964d09c5a" #   2022-04-05
LANG_COMMIT[sw]="55ef358f2f593215cd478e0c42d577b646188e00" #   2022-03-25
LANG_COMMIT[szl]="866996405789638f9860df156b329f38b74c6407" #   2022-03-25
LANG_COMMIT[ta]="74acdf45b478aa375ce4d966d545e68b8b2930e5" #   2022-03-25
LANG_COMMIT[ta-LK]="56df223832d34beac85462eecd279a0cbab84bc1" #   2022-03-25
LANG_COMMIT[te]="d0b0f1eb15290867503c3f137e32816c3e14bd97" #   2022-03-25
LANG_COMMIT[tg]="67ff46e34a2625043b905525ecfe2d018c8e45c8" #   2022-04-09
LANG_COMMIT[th]="dd80686ee9b59d0dd5cc7c3ea68d5e209aa107ab" #   2022-03-31
LANG_COMMIT[tl]="2f33c68386b924466491deca0ff7434f0cbb85a1" #   2022-03-25
LANG_COMMIT[tn]="23f1fb4c1661cb94679bac75cdd9823457fe8d25" #   2022-03-25
LANG_COMMIT[tr]="2307c87f4803b4c463ac6c483caba8099e9d68f5" #   2022-04-05
LANG_COMMIT[trs]="3b998842fd476c72f59ca7ac3c049a02c8461d47" #   2022-03-25
LANG_COMMIT[ts]="694bfde1d584b41c3e0bc7dd447949caba0f89a8" #   2022-03-25
LANG_COMMIT[tsz]="a1c9803b73c039d7100b36669f78ce9a597425e2" #   2022-03-25
LANG_COMMIT[uk]="7e8e7f5f43a0ff807da558173da9c39d8e89d6f6" #   2022-04-02
LANG_COMMIT[ur]="599fe64223d2abe2fb375105aaecba241b3526fc" #   2022-03-25
LANG_COMMIT[uz]="23b956afbeaa9137a7735bdb4046bdeba308014b" #   2022-03-25
LANG_COMMIT[ve]="7b43a2860317b754dc7909b37494157ebfd574c8" #   2022-03-25
LANG_COMMIT[vi]="eb64307acafe4ca655dd627beba6acecf3c94a94" #   2022-04-07
LANG_COMMIT[wo]="98ea3b272b0eaada77d9c7cef4b1f8d0ade08923" #   2022-03-25
LANG_COMMIT[xcl]="ecb8d4dea05c5b3718032ef746476ed86bffbc5b" #   2022-03-18
LANG_COMMIT[xh]="82bc45198281e2e4a8c2d6057d9aff300c83678b" #   2022-03-25
LANG_COMMIT[zam]="e8b680fe4ebc37c2649af4f7c463167679e6b159" #   2022-03-25
LANG_COMMIT[zh-CN]="2e6f420c89d0cc5551b1b3141c8194b439ca868a" #   2022-04-05
LANG_COMMIT[zh-TW]="a132b94328c5c17c104534bc8dc1811f1516876b" #   2022-04-03
LANG_COMMIT[zu]="e2ccccf480c4824592d12c900f26ade5888baea0" #   2022-03-25

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
