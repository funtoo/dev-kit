# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/8b4fa41ab7495f79dfa6857fdd52aa39c216c076 -> wit-bindgen-0.26.0-8b4fa41.tar.gz
https://direct.funtoo.org/77/d0/0f/77d00f9efd700c618f85719e9c5853c5f22ad469ec0c27990437d59309f1d749c3db2ee3019323d842a1553ee76f30c5983d391e2b374d0f3c5ef8001223d482 -> wit-bindgen-0.26.0-funtoo-crates-bundle-f1c4a94320b94a34c364f334f15538b441efedebadd3c9375f9d01eeccd599227666897b5321f33d77571d6137ca698f615b5e2d70424c382c274408d5e91d15.tar.gz"

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