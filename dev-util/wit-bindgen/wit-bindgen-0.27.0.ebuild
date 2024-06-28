# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/749bacc556cdb4b67848c723dfbeda0a59dff005 -> wit-bindgen-0.27.0-749bacc.tar.gz
https://direct.funtoo.org/5f/08/e5/5f08e5e928a36ba5b717abbb94d2f7371bc202b871593ccf6a1417229aa9fdc50ae2e08e03a0c8ce0ad41ce6fd4de3f1a68281262d484353ea9343d260444157 -> wit-bindgen-0.27.0-funtoo-crates-bundle-56720cb41e87cb221ad7c954932e27abea2a059630ed3253bb097185f9acc5dbb2b6c31fd7e3b8a3004b5e149ff19245e229596ee10ac08cabc451e1f68d5b55.tar.gz"

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