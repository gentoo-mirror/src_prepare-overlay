# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Check if a given package has new upstream versions"
HOMEPAGE="https://gitlab.com/src_prepare/euscan-ng"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/src_prepare/${PN}.git"
else
	SRC_URI="https://gitlab.com/src_prepare/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-2+"
SLOT="0"

# web (
# 'Django>=1.4',              dev-python/django           OK
# 'South>=0.7',               None
# 'ansi2html>=0.9.1',         dev-python/ansi2html        PY
# 'django-annoying>=0.7.6',   None
# 'django-auth-ldap>=1.1',    dev-python/django-auth-ldap PY
# 'django-celery>=3.0.1',     dev-python/celery           PY
# 'django-piston>=0.2.3',     None
# 'django-recaptcha>=0.0.4',  None
# 'django-registration>=0.8', None
# 'matplotlib>=1.1.0',        dev-python/matplotlib       OK
# 'python-ldap>=2.4.10',      dev-python/python-ldap      OK
# )

# Right now euscan-ng and euscan can't be both installed on the same system
RDEPEND="
	!app-portage/euscan
	>=dev-python/beautifulsoup4-4.8.2[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"
