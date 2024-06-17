# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/f2d59e4f4cc1ed0fa14a78be6fb275d47462e837 -> just-1.29.1-f2d59e4.tar.gz
https://direct.funtoo.org/81/bf/d9/81bfd9ba036aca87600fdee47d06161d354058139ae7101912ce7f742ee3958a851496cfbbeb34c3ed73541b9766c863388b66851f3dca3538a8e8f4f61992cd -> just-1.29.1-funtoo-crates-bundle-c4a19031766b66b9ed7e2f2db2d4034e3ca37e662da0e2eef00567b36c75ec7b445746d44223949bd001c9bc996bdc6bb5094c0c45e1fe4b8e890c01d73b2da0.tar.gz"

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