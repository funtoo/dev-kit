# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/af2d6e8d9086efbe00258bbdac4767a46ae9ee53 -> wit-bindgen-0.35.0-af2d6e8.tar.gz
https://direct.funtoo.org/40/b4/4d/40b44d8e12bd72fc131be2a1dc8ab703ac1e98bf94392b34d9f17ad379e87a2d6e54aff2e3e0542edfee55ee724c972e78fb98484bc6465bc65499ea84856126 -> wit-bindgen-0.35.0-funtoo-crates-bundle-3dadad56b92ee1f620e95a06af866e3e06126b9a6d3c600c955548e28b9ddefbbfb08f0f6371cad5e34133074b3b4475e9d2b97396e66381548936fc89f652b8.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DOCS=( README.md )

QA_FLAGS_IGNORED="/usr/bin/wit-bindgen"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/bytecodealliance-wit-bindgen-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}