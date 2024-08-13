# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/7b4d9e5165ef49731d05d53210f2d8f8192ee78f -> wit-bindgen-0.30.0-7b4d9e5.tar.gz
https://direct.funtoo.org/ad/be/25/adbe25989a26c00041b5b38840dc98150870ec8f960038961bf3b45f9ecd26a1d61ab662775c9bee0687b6edaa8fe9331dec7c74eb23bc1d1ef990633edbb8a1 -> wit-bindgen-0.30.0-funtoo-crates-bundle-78e0747f7ade9cbaf97cd9358dcb31489b907b73a70df6c688a334700b649f32596c15b1ad4445f7529523ec6fe9376566603f66bc1d201a66a3f53a8ea27c0d.tar.gz"

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