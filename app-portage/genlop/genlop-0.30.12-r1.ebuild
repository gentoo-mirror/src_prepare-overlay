# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit bash-completion-r1

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Perl"
SRC_URI="https://github.com/Ociidii-Works/genlop/archive/genlop-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	 dev-perl/Date-Manip
	 dev-perl/libwww-perl"
RDEPEND="${DEPEND}"

# Please send help
S=${WORKDIR}/genlop-genlop-${PV}

src_install() {
	echo "S=${S}"
	dobin genlop
	dodoc README Changelog
	doman genlop.1
	newbashcomp genlop.bash-completion genlop
}
