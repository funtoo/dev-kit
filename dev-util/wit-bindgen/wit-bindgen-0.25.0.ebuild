# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/9b50b8e78940af080ed3b7c0238e11b04a4bd17b -> wit-bindgen-0.25.0-9b50b8e.tar.gz
https://direct.funtoo.org/73/5a/07/735a070a11a7b402c3a7eb87420081dc9edf74c306ff7ecc90e9b94b36c54dc12e96a531a87c742fc4a336ec5700dd417f4465c2c99516674bfaf65927765cb3 -> wit-bindgen-0.25.0-funtoo-crates-bundle-95803253e64ea8a1d2b84db4dffb88de23a1cbe9375632e9f829a83533d8cf14c6f0c587233d9c7622350f44d9e1cf8179f5ed1d126a154e91db3f99b7a2c650.tar.gz"

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