# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" CLI and Rust libraries for low-level manipulation of WebAssembly modules "
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools"
SRC_URI="https://github.com/bytecodealliance/wasm-tools/tarball/897ab1f691a9c9d5a8fc811a42fdd332d1ba5da9 -> wasm-tools-1.223.0-897ab1f.tar.gz
https://direct.funtoo.org/d6/9d/d8/d69dd8fe230657a8ebe5415af2c450b7dc6238c9abbf55afc64ddf878f3ae4d8e535d58dcf1fd3a2955155a0a91a75ea5dc118bdf8d5c7e16d2bb69445c5a253 -> wasm-tools-1.223.0-funtoo-crates-bundle-be24887da1839f4ad0aa335e70fa7c4876d344cb9dada6c430a9c25d4f7e0c703848b7b276d3b94f1d0a4543113a97b3a6e597f0b75cd043d50bac836866969f.tar.gz"

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