# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=RMBARKER
inherit perl-module

DESCRIPTION="Perl extension for renaming multiple files"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/perl-Getopt-Long-2.24"
BDEPEND="
	>=virtual/perl-ExtUtils-MakeMaker-7.36
	test? ( ${RDEPEND} )
"

# There are differences between distributions on the name of this binary.
# currently Debian derivatives call it prename while Arch derivatives call
# it perl-rename. It can't be named "rename" as util-linux provides
# a binary of the same name.

src_prepare() {
	eapply_user

	# Rename script name from "rename" to "prename" to not conflict with "rename" from util-linux
	sed -i \
		-e'/my \$script/,/;/ s/\([^-]\)rename/\1prename/' \
		-e '/my \$unsafe/,/;/ s/\([^-]\)unsafe-rename/\1unsafe-prename/' \
		Makefile.PL || die

	# Modify man page to make sense with previous change to script name
	sed -i \
		-e '/\=head1 NAME/,/^rename/ s/^rename/prename/' \
		-e '/\=head1 SYNOPSIS/,/B<rename>/ s/B<rename>/B<prename>/' \
		-e '/\=head1 DESCRIPTION/,/C<rename>/ s/C<rename>/C<prename>/' \
		-e '/\=head2 Examples/,/\=head1 OPTIONS/ s/\(^\s\)rename/\1prename/' \
		source/rename || die

	# Also modify tests so that they work with the above changes
	sed -i \
		-e '/sub script_name/,/;/ s/\([^-]\)rename/\1prename/' \
		-e '/sub unsafe_script_name/,/;/ s/\([^-]\)unsafe-rename/\1unsafe-prename/' \
		t/testlib.pl || die
	sed -i "s/my \$generic = 'rename';/my \$generic = 'prename';/" t/rename-examples.t || die
	sed -i "s/my \$generic = 'rename';/my \$generic = 'prename';/" t/u/rename-examples.t || die
}
