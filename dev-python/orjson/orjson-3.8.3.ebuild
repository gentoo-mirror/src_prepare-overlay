# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{9..11} )

CRATES="
ahash-0.8.2
arrayvec-0.7.2
associative-cache-1.0.1
autocfg-1.1.0
beef-0.5.2
bytecount-0.6.3
castaway-0.2.2
cc-1.0.77
cfg-if-1.0.0
chrono-0.4.23
compact_str-0.6.1
encoding_rs-0.8.31
itoa-1.0.4
libc-0.2.137
libm-0.1.4
num-integer-0.1.45
num-traits-0.2.15
once_cell-1.16.0
packed_simd_2-0.3.8
pyo3-build-config-0.17.3
pyo3-ffi-0.17.3
rustversion-1.0.9
ryu-1.0.11
serde-1.0.148
serde_json-1.0.89
simdutf8-0.1.4
smallvec-1.10.0
target-lexicon-0.12.5
version_check-0.9.4
"

inherit cargo distutils-r1

DESCRIPTION="Fast, correct Python JSON library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="
	https://github.com/ijl/orjson
	https://pypi.org/project/orjson/
"
SRC_URI="
	https://github.com/ijl/orjson/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=virtual/rust-1.60
	test? (
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		amd64? ( dev-python/pendulum[${PYTHON_USEDEP}] )
	)
"

distutils_enable_tests pytest
