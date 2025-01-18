# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/592805652c4759d30aa34f8d370527c1e79af0ec -> wit-bindgen-0.37.0-5928056.tar.gz
https://direct.funtoo.org/19/a3/b6/19a3b6b41129591bd00561c79f1dbef75267bc37f53dd396c6a4958fb165f48aa5e417d1fd5780b2bf05f6fb1cf7009fc452774351e596ffb1527175e7a2eebd -> wit-bindgen-0.37.0-funtoo-crates-bundle-8958429c82028c39dd62f57d3bfee2bb81f8cbfbfd47de6cb26f522a68845090792399e40c4c26f5142ed8a59ff6600047a455447d626c7638706db7ada4c98e.tar.gz"

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