# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-any-r1

DESCRIPTION="Script for creating GNU Icecat tarball"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"

COMMIT="d7d3e9a33d2b3b78a6e08060684580c72c0d6e93"
COMPARE_LOCALES_PV="8.2.1"
SRC_URI="
	https://git.savannah.gnu.org/cgit/gnuzilla.git/snapshot/gnuzilla-${COMMIT}.tar.gz -> ${P}.tar.gz
	https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}esr/source/firefox-${PV}esr.source.tar.xz
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
LANG_COMMIT[ace]="349b566c173325102f3b68323ab5acb6b73ae532" #   2022-05-03
LANG_COMMIT[ach]="c0df1e6f0fa47ebcb9779cb5f465d1059c59bb19" #   2022-05-06
LANG_COMMIT[af]="96d07670432bed1a1c705ed3c4d5a862cc9006d8" #   2022-05-06
LANG_COMMIT[ak]="1741b0361343c431702c25c62ea5023f5ceddf0b" #   2022-05-06
LANG_COMMIT[an]="061c207c941adaaffdb7bb6105501f0589042a38" #   2022-05-06
LANG_COMMIT[ar]="bae567482ff7d25eebcbe7248079801f55791777" #   2022-05-06
LANG_COMMIT[as]="8c532f3442763daeb6ee773b435cad8a226e456f" #   2022-05-06
LANG_COMMIT[ast]="97547f7bd8446f20080c3a0753a8cc096403eb34" #   2022-05-06
LANG_COMMIT[az]="72ef330c2422bfa75b166ec2e98f1e1fd1673ba0" #   2022-05-06
LANG_COMMIT[be]="e95728e13fce0917ceb283abaa62c538ef675d6c" #   2022-05-06
LANG_COMMIT[bg]="626c7768d5d74c847340f9ef70595519ece8e92f" #   2022-05-06
LANG_COMMIT[bn]="558f01717c63b70b7fcc9ed887c101deabece004" #   2022-05-06
LANG_COMMIT[bn-BD]="721e12ac043c95a43a7c243571873da430f68ccd" #   2022-05-06
LANG_COMMIT[bn-IN]="66dce611a2ef1da995d796a56e1dd053f9d5d401" #   2022-05-06
LANG_COMMIT[bo]="fdff43527e9e710d38de7f9e0a37e0433028d2b2" #   2022-05-03
LANG_COMMIT[br]="75c688444c744824e79601a671e5fdca832a3c90" #   2022-05-06
LANG_COMMIT[brx]="801dafb3f8bd238e0c216190527f6ce5814261b7" #   2022-05-06
LANG_COMMIT[bs]="bc98619d6c3f446e86c10da7e5056d95dae0cfdc" #   2022-05-06
LANG_COMMIT[ca]="53a4976d45ed94825c3bfae65ecea3f1c112ada2" #   2022-05-06
LANG_COMMIT[ca-valencia]="811d57b3b4c5388c16cabe816e903edd1d94c097" #   2022-05-06
LANG_COMMIT[cak]="745ff9cdf91ac493dc20f5957c7cd3d45e2790a3" #   2022-05-06
LANG_COMMIT[ckb]="d32309249e66041e5cc21f5b56e72de8eab140d5" #   2022-05-06
LANG_COMMIT[crh]="af590b90773e92a1d7647ff463a49b693a34018a" #   2022-05-06
LANG_COMMIT[cs]="75fc85827a9c3486cea6248c531e2a2b648b999d" #   2022-05-07
LANG_COMMIT[csb]="fd40ed059d0298ee04ead3bed04d2a4bfc77d38e" #   2022-05-06
LANG_COMMIT[cy]="35f86582d707fac389af5d188bb0bb3415de7c20" #   2022-05-06
LANG_COMMIT[da]="8281e95169d039c502dd164ead658aa2e0d1f988" #   2022-05-06
LANG_COMMIT[de]="04a4762f573434bb12615c2bbd3f4c0ea153d75d" #   2022-05-06
LANG_COMMIT[dsb]="a7df6e58108cc9b16b09725aa8a5b2164f8a2ef9" #   2022-05-06
LANG_COMMIT[el]="889152361dbe6b2d3a88a9e9b28f7b17a423b9bb" #   2022-05-06
LANG_COMMIT[en-CA]="69ff3ae8ee1bf5d33e871e082ba5270fed4ab250" #   2022-05-06
LANG_COMMIT[en-GB]="72ba3b5e0b529b291d601c94485d3ad2e7618ac3" #   2022-05-07
LANG_COMMIT[en-ZA]="056a1c9c0a56733d6e9aaacedac210ccd71a87c1" #   2022-05-06
LANG_COMMIT[eo]="eecbe5acb6bf8c95a70c512876d6304780520104" #   2022-05-06
LANG_COMMIT[es-AR]="56d20c43cd44d1bb70ad33a092c92fff04650102" #   2022-05-07
LANG_COMMIT[es-CL]="34ad10d628b19e2e741231470f60a41f9972aa30" #   2022-05-06
LANG_COMMIT[es-ES]="54fd7c0b27f9da0e4b5354005f9fb9baa8c65da5" #   2022-05-06
LANG_COMMIT[es-MX]="258a5c3922f2849980dece3b576549bbdd4ea9d9" #   2022-05-06
LANG_COMMIT[et]="8dccc3aa8722023a45b1bdf3d58f7f9737027617" #   2022-05-06
LANG_COMMIT[eu]="42ad6743cc1770b2f47d3453e733408db5a1365e" #   2022-05-06
LANG_COMMIT[fa]="622763228c43c99e13cc8ac63de0fdd16fe88695" #   2022-05-06
LANG_COMMIT[ff]="a6819d7bd721261eb006dc162326cb5ffe69607a" #   2022-05-06
LANG_COMMIT[fi]="090210a560ba8aa74c88a74f49e576be99b96a43" #   2022-05-06
LANG_COMMIT[fr]="d57eecbd13482054a240ed9622b467d3efb5cee4" #   2022-05-06
LANG_COMMIT[frp]="eaadceefac1e59c56bb34ffb14fdff8509689df9" #   2022-03-18
LANG_COMMIT[fur]="e6af03928c74479539d8f5ceafd6b74687a23759" #   2022-05-03
LANG_COMMIT[fy-NL]="714842b6442e639f7466a7ef8af68034c4c4e294" #   2022-05-06
LANG_COMMIT[ga-IE]="1bd8b81bcda69a87e8af506c79ed4791dba17042" #   2022-05-06
LANG_COMMIT[gd]="cbeacf37662048187521b685e78584f99cb8e402" #   2022-05-06
LANG_COMMIT[gl]="1a18225155092f615d0253d1ecca98acd754077b" #   2022-05-06
LANG_COMMIT[gn]="d758662b72ef34aa6a0579a77360949771fe38e7" #   2022-05-06
LANG_COMMIT[gu-IN]="6f2ef8ed1f872e99d7e11ab81affcf9a3a9cd440" #   2022-05-06
LANG_COMMIT[gv]="3baa8a0b7689d51a6137298d163b8498fd4984f3" #   2022-03-18
LANG_COMMIT[he]="04618f4b90cdcf9f1215d5742ee442d0b5ca63c5" #   2022-05-06
LANG_COMMIT[hi-IN]="8b192e3f182dcb52aa2fbf04bbb682402e74dc0a" #   2022-05-06
LANG_COMMIT[hr]="44533ae994aacb4c18d5d633aa1288d49a0ab315" #   2022-05-06
LANG_COMMIT[hsb]="7dac4b9c681f5475504b8e4e12000058c26baa32" #   2022-05-06
LANG_COMMIT[hto]="2a46be06473704a38ccf63f098dc6e770978a7f0" #   2022-05-06
LANG_COMMIT[hu]="280add393b606b47c7e080483102cb2d513a5956" #   2022-05-06
LANG_COMMIT[hy-AM]="bb1bf145406ce6e0f948891d60ef6298d4f1e6a0" #   2022-05-06
LANG_COMMIT[hye]="6af3ca46821915ceb048d79b0d61ab60d9dc19a5" #   2022-05-06
LANG_COMMIT[ia]="0644b30a01736fa03f3826606b250855264bda69" #   2022-05-06
LANG_COMMIT[id]="f2fba11024d9cde67cb2a318f0386c65c17306ce" #   2022-05-06
LANG_COMMIT[ilo]="cc3f6040407db0b3ff4072d0c20e0ffd251ae3bb" #   2022-05-06
LANG_COMMIT[is]="b086e5eaad74eef1705ee7e71e5f22b3d1474dbe" #   2022-05-06
LANG_COMMIT[it]="4ce887b53b7588ff07b2ebbe6e1e70b8e50260be" #   2022-05-07
LANG_COMMIT[ixl]="b47cecc45c54ca3cb62885f83cb969763045cd99" #   2022-05-06
LANG_COMMIT[ja]="8a5eee4bffb74d9e055f56b8763ee78f401ba0f3" #   2022-05-06
LANG_COMMIT[ja-JP-mac]="ca17bbf61a8103b93e35a952ea4a2a76a43d8a52" #   2022-05-06
LANG_COMMIT[ka]="012dfb41fc2b2487cd4a13bf4573433eabec4abf" #   2022-05-06
LANG_COMMIT[kab]="a005e8be5164b85735f44d45acf893ff863377f6" #   2022-05-06
LANG_COMMIT[kk]="f06eada3bbfa2447fe4fdd4f74dbac7d465042d6" #   2022-05-06
LANG_COMMIT[km]="66ae84dd76885d1d893ce81cff7dfdf51ba6e70f" #   2022-05-06
LANG_COMMIT[kn]="cc568a617e7c90707fb94662b8d945a5f2d8aef0" #   2022-05-06
LANG_COMMIT[ko]="c8cfd0b020e53f4ecedbb1e38e194ae3ab77f47e" #   2022-05-06
LANG_COMMIT[kok]="d9a31cc3593a76178d77cc9adeb10ceb11da42e3" #   2022-05-06
LANG_COMMIT[ks]="d48182bb0a721cc916c1c75859086c4483e0d30c" #   2022-05-06
LANG_COMMIT[ku]="ca2566964182af64448921d7f1e2f884ce17d587" #   2022-05-06
LANG_COMMIT[lb]="4c069030e71c21955646f1d888c3248eea3481e5" #   2022-05-06
LANG_COMMIT[lg]="df9be6543e196767829e48c86787a975c113f547" #   2022-05-06
LANG_COMMIT[lij]="f058b05af7db4f4fab06f7b72af9e9f79523f347" #   2022-05-06
LANG_COMMIT[lo]="1e8e1e2c5256265b00f1bbb301e5f85518f698d5" #   2022-05-06
LANG_COMMIT[lt]="079ded942e9d51aee48fff7e0ddda5ae724c8c60" #   2022-05-06
LANG_COMMIT[ltg]="6c74343f8cf1afa6c670394bb5cc2a2037f74b86" #   2022-05-06
LANG_COMMIT[lv]="ce9e5a93e7906fb940d61a69046342d2f62297a1" #   2022-05-06
LANG_COMMIT[mai]="9f0714839e08639b02daf2c16fe35631b5e61ca8" #   2022-05-06
LANG_COMMIT[meh]="d5fae362bc7510d7c24497823a52360429e9ef35" #   2022-05-03
LANG_COMMIT[mix]="4a4143a368eae9300c14b0c932739d0bf4b52d65" #   2022-05-03
LANG_COMMIT[mk]="5148d6e2faa6db6eb8f19dd65a1fc9e70b444ef2" #   2022-05-06
LANG_COMMIT[ml]="7efbf18851aede4bec1552f8ebbfa126cf054f1a" #   2022-05-06
LANG_COMMIT[mn]="3dbfdc105b8529fefd9f468b70d13c03134fc134" #   2022-05-03
LANG_COMMIT[mr]="083d2131757827a85b5239fe992d4c5dc5ca9c9f" #   2022-05-06
LANG_COMMIT[ms]="2e625c947ce24d2ff66a840cfed3fcbdba34cfca" #   2022-05-06
LANG_COMMIT[my]="701639e1c9053bcd2b851b44f708cc594722b193" #   2022-05-06
LANG_COMMIT[nb-NO]="84f645f9ccf1586a18bf26a8c2ba0ba9917b88d0" #   2022-05-06
LANG_COMMIT[ne-NP]="eed51c2b7e393f58a40c3c98894dbbf3a3c6362a" #   2022-05-06
LANG_COMMIT[nl]="a7874fae80bc15eae072a354b5527e46d2b007f6" #   2022-05-06
LANG_COMMIT[nn-NO]="3cb4783309c530c1de9a87ce9279aa91b19ce7f4" #   2022-05-06
LANG_COMMIT[nr]="0b0fafcceedf4726cd570e7dd9e766d5ee6a9853" #   2022-05-03
LANG_COMMIT[nso]="e125ebf30d2a82d1d15bc870a120cd769d253beb" #   2022-05-06
LANG_COMMIT[ny]="83123a045e413fe36dacb7571962f579e38d4589" #   2022-03-18
LANG_COMMIT[oc]="fba1601a5825035de5c157e54a02b0a8f21d110c" #   2022-05-06
LANG_COMMIT[or]="462189c102caff289a18f0d2e66fb87d1d836251" #   2022-05-06
LANG_COMMIT[pa-IN]="c503058164026391bb96a34465deaffa87aa1d0a" #   2022-05-06
LANG_COMMIT[pai]="528b188b573a3ea9a131f6f74671bc753ba222da" #   2022-04-26
LANG_COMMIT[pbb]="eaf8e57a6bfea72bb55d88886e902cca0b806ea7" #   2022-05-06
LANG_COMMIT[pl]="fcad82afea33c12f2c326bb4c86e9b23e3897d66" #   2022-05-06
#LANG_COMMIT[ppl]="15cd35db7510891a372a2d4a14742ab63de01f10" #   2022-03-18
LANG_COMMIT[pt-BR]="4e73bef496a8e116c4589ceb334243d3744933c6" #   2022-05-06
LANG_COMMIT[pt-PT]="f91d6c85edba2253f87de8b8ca16f016c109db18" #   2022-05-06
LANG_COMMIT[quy]="bd23f32f916216f673ce33576bc18df65f45d147" #   2022-03-18
#LANG_COMMIT[qvi]="193e64c2e739aac8da82253ec295d16981b62ce6" #   2022-03-18
LANG_COMMIT[rm]="28f75608293606014de87e8aa8b3740891c72279" #   2022-05-06
LANG_COMMIT[ro]="4ee410ec4225bd234c44e9dabe402459d0415370" #   2022-05-06
LANG_COMMIT[ru]="bdf7d74cb82043f7f8060b3c5a44699460fa5ade" #   2022-05-06
LANG_COMMIT[rw]="4b5121210f112750c388c8cb080383e98c115431" #   2022-05-03
LANG_COMMIT[sah]="079215995861b1868df8f7c9ce45bab5b45b9d7e" #   2022-05-06
LANG_COMMIT[sat]="23cf8ee51996b0e522f563671997d623e766cc6b" #   2022-05-06
LANG_COMMIT[sc]="89226c978e81201559b98677fdffcb3bc004414a" #   2022-05-06
LANG_COMMIT[scn]="5683cd3aa41fe256dfc3585efa0d3abe58d6f972" #   2022-05-06
LANG_COMMIT[sco]="baeaf5bfc3d3456eff3a5bf3df07ab40480e18fb" #   2022-05-06
LANG_COMMIT[si]="9a37c1ccfd1de276880babd3e0090a13bdb523b7" #   2022-05-06
LANG_COMMIT[sk]="a2e3c72ccbfee2f1191028588bb4994eb2aa69af" #   2022-05-06
LANG_COMMIT[sl]="6c686a208dfa317e9d9cda13874b9bc55cfee376" #   2022-05-06
LANG_COMMIT[son]="d29c45b2d27b0e64e1df7ed2c4aaec2821e69ca2" #   2022-05-06
LANG_COMMIT[sq]="ab808e918a3a18dce19bded163a333fca4dc5c98" #   2022-05-06
LANG_COMMIT[sr]="b4f5f41731d5368fb8a2ef8809f5ca2ca4be6577" #   2022-05-06
LANG_COMMIT[ss]="ca9116cc7cfdebd118bd85e1c8ad71764e17da79" #   2022-03-25
LANG_COMMIT[st]="14cde4fa62c123cb86e7e1d18460e8bea00f4c9a" #   2022-05-03
LANG_COMMIT[sv-SE]="3d54aaaf374e5a6821752d4f0bbf79f9e0a0a3ec" #   2022-05-06
LANG_COMMIT[sw]="06f015a5bae41d52a94dffa4b9f719d22204801c" #   2022-05-06
LANG_COMMIT[szl]="b459b2c9bf0f732850f04cfdbfdbe3aec37b57d6" #   2022-05-06
LANG_COMMIT[ta]="b58c291be896ddcd0b8067598509ccb7e19185a5" #   2022-05-06
LANG_COMMIT[ta-LK]="7de43ccf3da0ff309ee4578246ff0e46bb4b6538" #   2022-05-03
LANG_COMMIT[te]="212c00e4acdf8fd80e09fb9cdb7d29655347ea48" #   2022-05-06
LANG_COMMIT[tg]="57f91b7626f23cc3ced1a2bda6497f8520d69b73" #   2022-05-07
LANG_COMMIT[th]="8ca3f21a07931b52f0bd1a8e35312bb9cd5be9cd" #   2022-05-06
LANG_COMMIT[tl]="40ee423d53e24e15e6881ba2cb73219a55b25c68" #   2022-05-06
LANG_COMMIT[tn]="64c9abb25c3d931399e464f67fec8487264350bc" #   2022-05-03
LANG_COMMIT[tr]="9700b993dfd11471ad9f9ac606eb2d5c727aee7c" #   2022-05-06
LANG_COMMIT[trs]="774bff28fc2f165f17d85ff841c6830a24284399" #   2022-05-06
LANG_COMMIT[ts]="a56f065595153a03f5ec73fa49ccc580431c848b" #   2022-05-03
LANG_COMMIT[tsz]="a1c9803b73c039d7100b36669f78ce9a597425e2" #   2022-03-25
LANG_COMMIT[uk]="5cf4ec3c4b2d058ff0051895bf60396acc3ec67b" #   2022-05-06
LANG_COMMIT[ur]="df2082bc317be9116009fb18e55b9b29cacf917e" #   2022-05-06
LANG_COMMIT[uz]="b0e3a748043e8134cd7bdf8e769cd6baf50b6305" #   2022-05-06
LANG_COMMIT[ve]="4a0fc355a112227c0e2fc8c975008d473377eb9d" #   2022-05-03
LANG_COMMIT[vi]="949ecc9990c6a1213e5eb858b819d7caccc6eb2e" #   2022-05-06
LANG_COMMIT[wo]="67fe7137404ae9258ae1065100df819ea3d9ca31" #   2022-05-06
LANG_COMMIT[xcl]="ecb8d4dea05c5b3718032ef746476ed86bffbc5b" #   2022-03-18
LANG_COMMIT[xh]="756ef4ec56278ddf62e8a334b0e407970ee3fd2a" #   2022-05-06
LANG_COMMIT[zam]="86c2a4f9569a90b6b4023ee2e76af3829f0bbf26" #   2022-05-03
LANG_COMMIT[zh-CN]="59feeddc93d6db47bbf39d298a3594ce587dad46" #   2022-05-06
LANG_COMMIT[zh-TW]="36b1431be40dc69e9279b2f14bdb5642328c8260" #   2022-05-06
LANG_COMMIT[zu]="1d61629aa1b33e8848620e72fb6492ccc4f8aa59" #   2022-05-06

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
