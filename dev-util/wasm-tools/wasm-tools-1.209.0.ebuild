# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" CLI and Rust libraries for low-level manipulation of WebAssembly modules "
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools"
SRC_URI="https://github.com/bytecodealliance/wasm-tools/tarball/0d97aa723f63c9344d27663d776b77e42f1dfac8 -> wasm-tools-1.209.0-0d97aa7.tar.gz
https://direct.funtoo.org/44/0e/cd/440ecd9dc0aef952a2fafe662c59a40de55896675275a6399c64587c7c1a12823afec99ec4581997c56648851b854518553d14b8bf470dd04815e7a248186a20 -> wasm-tools-1.209.0-funtoo-crates-bundle-5d197c840f450e6e94e4dd63138f0b99bd1ad6c2dffa92c1d09a75f7f350936d136c3ad142b0a349a01c22b81bfcfad0a58e4571d90c4d74f8c646f43fc5daa9.tar.gz"

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