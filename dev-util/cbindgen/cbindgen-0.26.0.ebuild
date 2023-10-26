# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A tool for generating C bindings to Rust code"
HOMEPAGE="https://github.com/mozilla/cbindgen"
SRC_URI="https://github.com/mozilla/cbindgen/tarball/703b53c06f9fe2dbc0193d67626558cfa84a0f62 -> cbindgen-0.26.0-703b53c.tar.gz
https://direct.funtoo.org/47/ce/b4/47ceb45aee7495175f78b51d3afa5a7304dee82a493ec8bb9cdb446084f142601f4342385ece60ac7d456f0d3bc52d30c961b6e18b652d504164ef46fd648254 -> cbindgen-0.26.0-funtoo-crates-bundle-f2f57b026a06a034dc7a8451d216c48e1bf5a574297a66b0416dabb3146102549a071def72d4e855a4bc4757115fb3f5576db9fb35b2026cb10dfb7d42f3eed4.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT MPL-2.0 Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

QA_FLAGS_IGNORED="/usr/bin/cbindgen"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/mozilla-cbindgen-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}