# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" CLI and Rust libraries for low-level manipulation of WebAssembly modules "
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools"
SRC_URI="https://github.com/bytecodealliance/wasm-tools/tarball/25787121be440eda96aa1b75fd36608333a316c0 -> wasm-tools-1.221.0-2578712.tar.gz
https://direct.funtoo.org/87/5b/e8/875be8d4b87bf229eb57f9412f99c067619f69c44a403a579d8ee0104e548dc212eae6d1adf8b612d3848b30c789f221b2ddd8b49a2978d85cd170c624e64e34 -> wasm-tools-1.221.0-funtoo-crates-bundle-5448c0c2fba3de32ac8661f9b64992ec2f6b726a76237354788fa01eb13abfb99c78734662879de7b9116ec244ccf507073901d163404653179237d80d1d33bb.tar.gz"

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