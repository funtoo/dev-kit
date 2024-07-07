# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/b90aa7ffe22d31cd78288c51da28ba15c9d4074f -> just-1.30.1-b90aa7f.tar.gz
https://direct.funtoo.org/5c/20/46/5c2046324d73e468d0d01801b365c4300309b284ed18aac294249d528ef600bca0b24f22ba78d5d7446c0e83e1065ab9a1e0eea43b8ee1795e222d36ac29af6f -> just-1.30.1-funtoo-crates-bundle-707abd8b731ffea7d34066c947a6cca5b518e0c9efacc544446b0d6afbd113167a9f61412a556b724f0e087d5aab566aa9b66f533d383438dc7d57be209affc7.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/just"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/casey-just-* ${S} || die
}

src_install() {
	cargo_src_install

	mkdir ${S}/man
	${S}/target/release/just --man > ${S}/man/just.1
	doman man/just.1

	dodoc README.md
	einstalldocs
}