# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/e103334cd1eef38b4ae9800dd6f09b4a8aec6e9d -> wit-bindgen-0.28.0-e103334.tar.gz
https://direct.funtoo.org/c1/75/ec/c175ec4205bdc4006b23e8958b103d8723272a5a17f6b441a9eb0bfdf20a8d7c161c21b8c65a27b7bd1abbc53e69378ae55195d1f201ca95934102e6e2997382 -> wit-bindgen-0.28.0-funtoo-crates-bundle-48aaab038b1b1dba1efc3e20014a9df4cdafc067fe6d22becfe2e3ed7e025221491643a8a3436023eed9ef9a57860038917ed4114675f01c29b76e7b085255ff.tar.gz"

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