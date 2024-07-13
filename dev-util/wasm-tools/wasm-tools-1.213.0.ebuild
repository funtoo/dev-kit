# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" CLI and Rust libraries for low-level manipulation of WebAssembly modules "
HOMEPAGE="https://github.com/bytecodealliance/wasm-tools"
SRC_URI="https://github.com/bytecodealliance/wasm-tools/tarball/3895cb78da9b0cade910bb598ac427938e890dcb -> wasm-tools-1.213.0-3895cb7.tar.gz
https://direct.funtoo.org/59/45/97/594597e4987fccb8a0e58d2150ae56df921dc40e41fdf4f44a476107d13764cc527d3a5d32fe8f568ccc2f045acad26b903d72f2f981d5f4d77527c8315721a8 -> wasm-tools-1.213.0-funtoo-crates-bundle-9a67d037d29ecc16d39ab84349cc2cb46f5ebf939a442301291c3acebcd2f36fe5cd52244f57a908c12be6b6dc0d73ef966e9f7847a2cbb2cfddc7acfe01bbdd.tar.gz"

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