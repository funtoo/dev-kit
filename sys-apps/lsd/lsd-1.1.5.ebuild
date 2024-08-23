# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern ls with a lot of pretty colors and awesome icons"
HOMEPAGE="https://github.com/lsd-rs/lsd"
SRC_URI="https://github.com/lsd-rs/lsd/tarball/5b104dcf3ad7861517deb221e23248d51a814968 -> lsd-1.1.5-5b104dc.tar.gz
https://direct.funtoo.org/23/8d/14/238d1473100a049f7f39dbc46a0d791a9c11f7fa21749c13eef110e83829c06c7c1da2766317d44f2ac0da4554ce5d6dfcb4282048398870ee1819a43f5db738 -> lsd-1.1.5-funtoo-crates-bundle-1285c6f27c9ca87c83d570e429e7b36ee8943de56a69c96bdaccfbe3bbe6ebde7c015aa9ebfb6943c42a3e2a55b00b80dd297bf9a6aad39e9493a3ffb3cd27f4.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+git"

DEPEND=""
RDEPEND=""
BDEPEND=">=virtual/rust-1.31.0"

QA_FLAGS_IGNORED="/usr/bin/lsd"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lsd-rs-lsd-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}