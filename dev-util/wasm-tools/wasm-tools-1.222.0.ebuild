# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" CLI and Rust libraries for low-level manipulation of WebAssembly modules "
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools"
SRC_URI="https://github.com/bytecodealliance/wasm-tools/tarball/892d4b6ef074688fb673ed634741316e0ea455f4 -> wasm-tools-1.222.0-892d4b6.tar.gz
https://direct.funtoo.org/99/09/ef/9909ef79e02a78a361dec6a104cf31e66c536ebac4adda0a0123a2ac08622cc73e79ccd980876b73945578bb0a7bcd43f2c01de5bace5ef2472a0c3e45649e9b -> wasm-tools-1.222.0-funtoo-crates-bundle-131100062e5aeed57025a0969aa488e57862fddc50daaa76f134384a3d5e4fc66b1498ed5fc04afb047289c7766f8a6dc21e8222e7f0df5d073fa082e1c59197.tar.gz"

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