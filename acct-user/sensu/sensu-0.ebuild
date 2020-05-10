# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

KEYWORDS="~*"

DESCRIPTION="Sensu Monitoring Framework"
ACCT_USER_ID=60
ACCT_USER_GROUPS=( sensu )
acct-user_add_deps
SLOT="0"
