# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/d9/ad/5e/d9ad5e9c0b25f610c0aa94e4d326eb54cff7f2d9ae9a9f58b57b97301abdbdbf51790f30cfe8d0ad2d503dc275516fca1d10952260de183c3b4756fe37b37903 -> cargo-c-0.9.31-funtoo-crates-bundle-e53f425039d10483a28fd9b013b47b7abcaddd53d44bb559c02637d2e386781e17e03b3e161f569fab0f4823f5abb3ae7c3f737d58e98f2cafafd326752bd63c.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="sys-libs/zlib
	dev-libs/openssl:0=
	dev-vcs/git
	net-misc/curl[ssl]
"
BDEPEND="virtual/rust"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lu-zero-cargo-c-* ${S} || die
}