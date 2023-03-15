# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="f55ede39713d1533734f37e39927cbb78abe1604"
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
LANG_COMMIT[af]="2464536a688c02aae2dfac0bc0f754408ab01f30" #   2023-02-20
LANG_COMMIT[ak]="b32c81cc32943d662fcd96f834f0d66f3a829ac8" #   2022-12-18
LANG_COMMIT[an]="27e2e38ca60bf912697b9d13ac3dacf325bc1dd8" #   2023-02-20
LANG_COMMIT[ar]="b4d862f7d8f70c79ea40249472b75a18901ced8a" #   2023-02-20
LANG_COMMIT[as]="2897ff58e8af2f57b04b6490a06e8feb5ee6c4d8" #   2023-02-20
LANG_COMMIT[ast]="e01e4677180ddb387533bc847ba1b32d84ae8db8" #   2023-02-20
LANG_COMMIT[az]="d15e4f1b98d49a48f57039a0bd332ca47e158859" #   2023-02-20
LANG_COMMIT[be]="2b55ac65a8c306b0c7dc8c1611fd535d7705682c" #   2023-03-10
LANG_COMMIT[bg]="cd4a32db66fd302c3ef8f2e5462c9cb3101bfbe2" #   2023-03-02
LANG_COMMIT[bn]="a30fa1bfcf5fcbc35e0b55ba285792b60837ac8c" #   2023-02-20
LANG_COMMIT[bn-BD]="fd53e4087a939d90f0f504886688f139987cf674" #   2022-12-18
LANG_COMMIT[bn-IN]="e01ae0d8708c488a4cbbcb1c50d76872e8e5d8da" #   2022-12-18
LANG_COMMIT[bo]="eb98ccdeb631d721a0671b5798fc0b2d652ad1ab" #   2022-12-18
LANG_COMMIT[br]="95bc8f88101eac1a034d17856c53027832751299" #   2023-02-20
LANG_COMMIT[brx]="af14cafc566adc6b5fa6449f718be54646dfd5ee" #   2023-02-20
LANG_COMMIT[bs]="bcdac5c2fb8b71f788d06bcd7b8a6ec544b3c59d" #   2023-02-20
LANG_COMMIT[ca]="1ecf304ecc6c82c5a0a6c4fbc7ca97a59e7177b1" #   2023-03-04
LANG_COMMIT[ca-valencia]="9416377b81cc82a23a649121fec43db540d6d8fa" #   2023-02-20
LANG_COMMIT[cak]="1037621f808dbc8db8d1e2f152522075e5318826" #   2023-03-13
LANG_COMMIT[ckb]="909ebfa0a2b48739fdf5ba9a9c18a43044a76b02" #   2023-02-20
LANG_COMMIT[crh]="57de4917546c0d3056966b2a750bd4fff3d51f33" #   2023-02-20
LANG_COMMIT[cs]="d3426cf3b0277e4a48c47055a781fb710c4d45b3" #   2023-03-04
LANG_COMMIT[csb]="4d4b92207c4e5bb2b1d3c142b90d5deb32011c36" #   2022-12-18
LANG_COMMIT[cy]="f608af20f398a517fb01a65efd469211673620d7" #   2023-03-13
LANG_COMMIT[da]="ecd344314f4609c207384ecf30d5a2689497a038" #   2023-03-14
LANG_COMMIT[de]="8d74351ed62814678863f5d443f01e8e07a32d9b" #   2023-03-03
LANG_COMMIT[dsb]="395b472d5b1afccbf28634a20d9091e6b6405bdf" #   2023-02-28
LANG_COMMIT[el]="a03f9806fdb4054989a46c2fe2ae1b1882e30d1c" #   2023-03-13
LANG_COMMIT[en-CA]="9a2fc1e74b318d213e384e21b3910a9c6ca71ed1" #   2023-03-06
LANG_COMMIT[en-GB]="1e5d7da54bb3739b6307924bff1306b126f2dbcc" #   2023-03-12
LANG_COMMIT[en-ZA]="7bb277d54160b0941c7be95602a052dae1839c0a" #   2022-12-18
LANG_COMMIT[eo]="acfe472711938b401b9fb27a7425fc29b171d53f" #   2023-03-05
LANG_COMMIT[es-AR]="7fe6b158fb40c50fe85b1ee760a7f6ad8fcc4cce" #   2023-03-11
LANG_COMMIT[es-CL]="91f5c760e71be9d78b18b7e3b15510bc6057c6ab" #   2023-03-13
LANG_COMMIT[es-ES]="2ff0ff19edca1485bb701dd24412c2b0a5d1673e" #   2023-03-12
LANG_COMMIT[es-MX]="8364cad66d8d2da9bf5a0c24db6af9ef3b78a024" #   2023-03-13
LANG_COMMIT[et]="fc09dbd3e54982a544f26768f6b82be99fd3dda8" #   2023-02-20
LANG_COMMIT[eu]="d82b0f37d25705078db125be2abea0cd06d61ee0" #   2023-02-26
LANG_COMMIT[fa]="e3b0e9ca5efca5a8538f772bb287664ddeabf112" #   2023-02-20
LANG_COMMIT[ff]="de5688e760aa79389238739eaa913dfcd075dc26" #   2023-02-20
LANG_COMMIT[fi]="50ce6e22b9e63ad3c60cb684b4ad36a44d18a11f" #   2023-03-03
LANG_COMMIT[fr]="353063dae24690d52ace14132ead22933ae95455" #   2023-03-10
LANG_COMMIT[frp]="8f254f50f86014e566eb47318d4e9a566bfc2ee2" #   2022-12-18
LANG_COMMIT[fur]="831b327152a57bb1b492feb985547a99344aa3bb" #   2023-03-14
LANG_COMMIT[fy-NL]="642ebb46d26b045841cd923af482ca0db302081e" #   2023-03-10
LANG_COMMIT[ga-IE]="47cc8acbc79bbe29611321efbe0ea7d2d566c8e0" #   2023-02-20
LANG_COMMIT[gd]="11eafbae1c48be53565d9de6d1742b3dad7447c2" #   2023-02-20
LANG_COMMIT[gl]="761c582b21067e2d82dbd4a12e55d4cbaaf4fae2" #   2023-02-20
LANG_COMMIT[gn]="95a6e012645b4176ff9d8c47c7c3d101a8c1065e" #   2023-03-10
LANG_COMMIT[gu-IN]="dae8b7a2957b8a18cfd4e961020ddc18dec78196" #   2023-02-20
LANG_COMMIT[gv]="cb82f55bf0ff941d74af343cfc44a22b9ab049d7" #   2022-12-18
LANG_COMMIT[he]="395f2d401290c5f6ca35487b4a42a852f7d11b13" #   2023-03-10
LANG_COMMIT[hi-IN]="c5d12bbc65a2105e5e11b4adbb0a23405412e755" #   2023-02-20
LANG_COMMIT[hr]="9ff572dd0fc3b0eb1d1972f8820b850cacbdcc23" #   2023-02-20
LANG_COMMIT[hsb]="8e8209b40a2a7b4d32b201c8f3bc54e4ef4ced52" #   2023-02-28
LANG_COMMIT[hto]="ddccad5fa28b3db90a85c279d905ad9ed282510d" #   2022-12-18
LANG_COMMIT[hu]="6807f209dc6ddf98bf20eed314a430a805e04886" #   2023-03-13
LANG_COMMIT[hy-AM]="5fb1e76e2f18324c9fe07bfaa87326f6d22ec5a7" #   2023-03-14
LANG_COMMIT[hye]="125a8b56b1d73f694dc3502b0c7e0508a19c9361" #   2023-02-20
LANG_COMMIT[ia]="9802203c9d4d3d821eeda6cd1c2851a4105dba8b" #   2023-03-11
LANG_COMMIT[id]="1c8ff54eee1987bef496f0e9ee693fa6ca708d04" #   2023-03-05
LANG_COMMIT[ilo]="751fd13acd40c6aac9f1b989892a3d3f163e0ba1" #   2022-12-18
LANG_COMMIT[is]="cc12873f223c53f647966458f2acd15e96bc43e9" #   2023-03-11
LANG_COMMIT[it]="22d6340a1e6ef8ddf6a15d8bf271f9e654db7a57" #   2023-03-14
LANG_COMMIT[ixl]="f4a62351d8945ef0097a4a3876e19746ff0563c2" #   2023-02-24
LANG_COMMIT[ja]="ab887affb5fd22dbebca8dd71780282d7ed4e827" #   2023-03-01
LANG_COMMIT[ja-JP-mac]="3f0b15eb476f09a539e3c44a638e724827835888" #   2023-03-01
LANG_COMMIT[ka]="cc9cc538d0972d9f95b2985e928669aa7c03c58e" #   2023-03-03
LANG_COMMIT[kab]="0c231f9473f339f1867504b01e012f836413dd98" #   2023-03-10
LANG_COMMIT[kk]="1808cf73c2e3dbe6864aae4fe9a8c7540cdf0fa1" #   2023-03-08
LANG_COMMIT[km]="22787a33f53b1d03e7663324d35ba06410e0e7bb" #   2023-02-20
LANG_COMMIT[kn]="5785690d0f72850bcd973d7302217eddcaf9716e" #   2023-02-20
LANG_COMMIT[ko]="56c06c390de4511971170922d69ddfdf96a5464e" #   2023-03-13
LANG_COMMIT[kok]="6f423912a7e9bdf7abae4b092f45eb5deb2e152c" #   2022-12-18
LANG_COMMIT[ks]="ccb5b54d4e52c2e556da677f1108b0866e1ad55d" #   2023-02-20
LANG_COMMIT[ku]="4a45a193ebcd2ef307b1c27b8e86e24742e35edb" #   2022-12-18
LANG_COMMIT[lb]="34a600e3153157d7a980ba01de8eccc1f43c06e3" #   2022-12-18
LANG_COMMIT[lg]="d852e1d1be4258ed1c06493d39d8ead2c7da21cd" #   2023-02-20
LANG_COMMIT[lij]="736163f6150eeb45377acf3946a664773c36fd12" #   2023-02-20
LANG_COMMIT[lo]="b3aabd668a89df9a854216711f99e79b8f3ea120" #   2023-03-13
LANG_COMMIT[lt]="5be3de1f80c9924231917c7b05bdca2b86bf4701" #   2023-02-20
LANG_COMMIT[ltg]="fa99c6b5ee5333a153b7d1d80188505ea48e6d9a" #   2023-02-20
LANG_COMMIT[lv]="be97fdfa4a9094951259960bfa372442edb46899" #   2023-02-20
LANG_COMMIT[mai]="b76b0972d57e51a24c02b4ec6329ff9e5a75a144" #   2023-02-20
LANG_COMMIT[meh]="a9e2ec814aebfa28369fd28a49daf6f9fdefb6ab" #   2023-02-20
LANG_COMMIT[mix]="cb01d9e0d66c9c0519eedef6260d2f0f4d1bea14" #   2022-12-18
LANG_COMMIT[mk]="c4ea25970ce282978720ea99d69cf86dc4136c27" #   2023-02-20
LANG_COMMIT[ml]="642bf639f550aef1ce1a34a1604212a4ddfcfa48" #   2023-02-20
LANG_COMMIT[mn]="c7317af50b769bf1e5b2c485b93fdb9dde60a9ee" #   2022-12-18
LANG_COMMIT[mr]="5da11fdd463a66d93470d1dc5ec09938816a9591" #   2023-02-20
LANG_COMMIT[ms]="0ba09b128c673309b192728b1ac1c297b7de1c13" #   2023-02-20
LANG_COMMIT[my]="bedc003a34cf6fb91496fe147d7fab8ec022819c" #   2023-03-05
LANG_COMMIT[nb-NO]="0c29eae42bd6506d5cd59e8e507036a9ed979a14" #   2023-03-09
LANG_COMMIT[ne-NP]="03e331ce58950ef9bbea1900f18e63dccd80abe7" #   2023-02-20
LANG_COMMIT[nl]="5739fce098c1c3e2e65f7971f64a4ea984b8fc93" #   2023-03-10
LANG_COMMIT[nn-NO]="fb6bb5d151dbca355a79a2f93441d648d28ae549" #   2023-03-05
LANG_COMMIT[nr]="0d6264799f9dbef96c4faac84f523544528aaec2" #   2022-12-18
LANG_COMMIT[nso]="f70e2f3b5df1933143f151c173f434c2b908c043" #   2022-12-18
LANG_COMMIT[ny]="16921adfc93303665cd72d7c352378eaf02c5d36" #   2022-12-18
LANG_COMMIT[oc]="32b8d1bc29d4b1c34069e9874c2c94ccb9de0583" #   2023-03-11
LANG_COMMIT[or]="7d97ecc307fad4948ea4875738c12c8f0d141c44" #   2023-03-13
LANG_COMMIT[pa-IN]="8a6fa63392586520dc594fbf75ca19e9a6d69a20" #   2023-03-02
LANG_COMMIT[pai]="add9300a8f4d1363285dbc1ecf7a666a1dc10d43" #   2022-12-18
LANG_COMMIT[pbb]="f231d6ec10b46c498e5c70fc07ba798e64af8fca" #   2022-12-18
LANG_COMMIT[pl]="fe03bc5a66b396447adf9f940a32708386fc6798" #   2023-03-04
LANG_COMMIT[pt-BR]="956953dcb4a7061e1361c0990dd5042636c16d5b" #   2023-03-13
LANG_COMMIT[pt-PT]="e7e1e3c4c97f2e7631c2e2a27fcb67e8dd68812c" #   2023-03-10
LANG_COMMIT[rm]="b9303b481cfb17a31101e7b0207aea758442f8e4" #   2023-02-20
LANG_COMMIT[ro]="005365f54f7ee7b83a508e51f5bf56d7f9a4d5b8" #   2023-02-22
LANG_COMMIT[ru]="1ef03b00b57d89fc34468a48321b971a73e78bca" #   2023-03-11
LANG_COMMIT[rw]="22f4425e8bc53d54fb2644f73157b1710af61234" #   2022-12-18
LANG_COMMIT[sah]="5d19a1851dd7c7e6822eb9b59797127df0551777" #   2022-12-18
LANG_COMMIT[sat]="6395f4e362204dcd4e79cf887b4e2be52a1a2e31" #   2023-01-16
LANG_COMMIT[sc]="a4c9ad4fd0217109fa7e895947dcd43bcd3a8622" #   2023-03-14
LANG_COMMIT[scn]="1b0014105d935315076f3ba10ead040ea04ad6ff" #   2023-02-20
LANG_COMMIT[sco]="ce9681c3d1a8e60741489837eba9c30080a43476" #   2023-02-20
LANG_COMMIT[si]="34a71d2517ba64995f3a840a0df98aa107244547" #   2023-02-20
LANG_COMMIT[sk]="89bf2c43a45233ee4989f79e529bde2cc877f0c8" #   2023-03-12
LANG_COMMIT[sl]="706316c29272428a369a138a833995c1cb6b2cff" #   2023-03-13
LANG_COMMIT[son]="d459430680f0900a94956a10be1f9484eb37762f" #   2023-02-20
LANG_COMMIT[sq]="5d9e0e476a108907a4e46b4e45c8288803e84355" #   2023-02-20
LANG_COMMIT[sr]="5d35d6898f2711c6dcc55322d777da4eb6e98514" #   2023-03-12
LANG_COMMIT[ss]="b6cc956a0bcb3b13ab1e5e5fe66e7457a0e4748d" #   2022-12-18
LANG_COMMIT[st]="4b515f19216142b11b425466cd26f1535f1a1abe" #   2022-12-18
LANG_COMMIT[sv-SE]="9dda553636aa27546def141e15b1f8fef4497814" #   2023-03-11
LANG_COMMIT[sw]="039ecea14a5ad6b07115a83cecf93757372f4809" #   2023-02-20
LANG_COMMIT[szl]="6200e5f7188e1b6b27f4eeaa1dfc9b1fbd9c7325" #   2023-02-20
LANG_COMMIT[ta]="153ea30935ea3ae9f9072e143a9c4e6139c2fa4f" #   2023-02-20
LANG_COMMIT[ta-LK]="c22f871721410fb4a0932785f5b2c281209e1d42" #   2022-12-18
LANG_COMMIT[te]="3f695e759a140f44105df252a99bee713698967a" #   2023-02-20
LANG_COMMIT[tg]="342423426d3d149e1036be3f2237c53d9d81824c" #   2023-03-10
LANG_COMMIT[th]="6f1f5c8484977ced942b5527053af7fdaba00263" #   2023-03-11
LANG_COMMIT[tl]="79d063eea34ba131ec3c76b33891ae255e0af919" #   2023-03-11
LANG_COMMIT[tn]="68e898f8292ee6f7b7f5a02cc008301ead335004" #   2022-12-18
LANG_COMMIT[tr]="4f4c4180b2feb2ab9d788046a8852b0c542a9b0c" #   2023-03-12
LANG_COMMIT[trs]="cb0055b9c5ce061098f74851b7836ffd0130e318" #   2023-02-20
LANG_COMMIT[ts]="ded5bab4c38d0085861ce44b3c87f4034553c888" #   2022-12-18
LANG_COMMIT[tsz]="63e79676c6cf93175636364b7d551c8b7ac1fbc1" #   2022-12-18
LANG_COMMIT[uk]="60d7ccf6607e3ea98ed2226343669f36da1a7a1f" #   2023-03-11
LANG_COMMIT[ur]="ce9cffcea1f42796cbcdd85a1e105e4cefea063c" #   2023-02-20
LANG_COMMIT[uz]="5e864bcbb1ed3ff45377a1e615c34fe13b2bf4b7" #   2023-02-20
LANG_COMMIT[ve]="2736e0ab1341290aa9939d9485222a4b1bb09fd2" #   2022-12-18
LANG_COMMIT[vi]="c8078c7a01bfa953cbda6aaaccbb837e4d45e5f1" #   2023-03-12
LANG_COMMIT[wo]="549e202968aaf7419099e6e2393dbfec05ed78c3" #   2023-02-20
LANG_COMMIT[xcl]="baceb9cfb38dc7f436987154d8fe5b4f4f9acd9d" #   2022-12-18
LANG_COMMIT[xh]="dddcd4e5511b6ab9eed19242a77aea405ffdc99c" #   2023-02-20
LANG_COMMIT[zam]="faed701453789fed7e1c5f405e0276bf2ee94498" #   2022-12-18
LANG_COMMIT[zh-CN]="d7d8fbc9879fc9e0f57f67aa3ffa003f41d743b7" #   2023-03-10
LANG_COMMIT[zh-TW]="eccdcbf7f12efb13ed76f198c12f0d8147f3559c" #   2023-03-10
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
