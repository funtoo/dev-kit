# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" CLI and Rust libraries for low-level manipulation of WebAssembly modules "
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools"
SRC_URI="https://github.com/bytecodealliance/wasm-tools/tarball/28c8962b1484bf150a0fcf7848db160d67e6573c -> wasm-tools-1.216.0-28c8962.tar.gz
https://direct.funtoo.org/05/c7/48/05c7486738674c600c647cedbb7e4fdb155e0f2c923eeb16dba54f8fc1b4117d6ab10484ce7ec95fb315572ae74cbc14dffc412b39cfd79a548616a9a1cbe48c -> wasm-tools-1.216.0-funtoo-crates-bundle-3a912c8c3f9d5b746977d0f74fd09c0ccb270c140ef80438cb840852f1430eba2b6510694d8b5b971affb2d62a2bd483463baf61355a2d3fd04f8bb461d56bbc.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DOCS=( README.md )

QA_FLAGS_IGNORED="/usr/bin/wasm-tools"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/bytecodealliance-wasm-tools-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}