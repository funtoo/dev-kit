# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" CLI and Rust libraries for low-level manipulation of WebAssembly modules "
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools"
SRC_URI="https://github.com/bytecodealliance/wasm-tools/tarball/91be0bbc8c5df685a74d87295e9cfff0be9c07c7 -> wasm-tools-1.219.1-91be0bb.tar.gz
https://direct.funtoo.org/03/2d/c9/032dc9444751ff65676f0da0275033be936cecbfdbcf1a564b58222c728873cb29c9b2342754dde3ae8a97188ef39d8575452153055dc74ecda45ec7d1d8896b -> wasm-tools-1.219.1-funtoo-crates-bundle-3c4f547a8f6df7258724f633373008cad2794d8c068db67b80b1b9e59a57c84c3b21e5b1c9c6926e9de4ec74aa808e65d15b67a7a6d19d74ed040fc4cdfb39bf.tar.gz"

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