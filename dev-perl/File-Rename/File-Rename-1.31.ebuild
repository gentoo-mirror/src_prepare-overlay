# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=RMBARKER
inherit perl-module

DESCRIPTION="Perl extension for renaming multiple files"
SLOT="0"
KEYWORDS="~amd64"
# No virtuals for
#   Pod::Usage
#   File::Basename
#   Test::More

RDEPEND="
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-File-Spec
	virtual/perl-Getopt-Long
"
BDEPEND="
	dev-perl/Module-Build
	virtual/perl-File-Spec
"

# There are differences between distributions on the name of this binary.
# currently Debian derivatives call it prename while Arch derivatives call
# it perl-rename. It can't be named "rename" as util-linux provides
# a binary of the same name.

src_prepare() {
	# Rename script name from "rename" to "prename" to not conflict with "rename" from util-linux
	sed -i '/my \$script/,/;/ s/\([^-]\)rename/\1prename/' Build.PL || die
	# Modify man page to make sense with previous change to script name
	sed -i \
		-e '/\=head1 NAME/,/^rename/ s/^rename/prename/' \
		-e '/\=head1 SYNOPSIS/,/B<rename>/ s/B<rename>/B<prename>/' \
		-e '/\=head1 DESCRIPTION/,/C<rename>/ s/C<rename>/C<prename>/' \
		-e '/\=head2 Examples/,/\=head1 OPTIONS/ s/\(^\s\)rename/\1prename/' \
		rename.PL || die
	# Also modify tests so that they work with the above changes
	sed -i '/sub script_name/,/;/ s/\([^-]\)rename/\1prename/' t/testlib.pl || die
	sed -i "s/my \$generic = 'rename';/my \$generic = 'prename';/" t/rename-examples.t || die
	default
}
