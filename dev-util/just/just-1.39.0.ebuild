# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/e303f2b8f2b120ab39013b654b6ae6422d9af6d2 -> just-1.39.0-e303f2b.tar.gz
https://direct.funtoo.org/d0/3e/83/d03e83e838f64db9d3946731d8de581026099aacf1484000d687e6fbfa3abbcf8e633ea28a1f25bf654ff33e56eafc223064e54dff65f2f436f941ae55081829 -> just-1.39.0-funtoo-crates-bundle-6d051d09df36662631d0f4b49811799f015a50168141d57f3b0b05babce9f154cf68b06b377401ac2e4032c8754abbfdec3b4a975676c205d15781f43275693c.tar.gz"

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