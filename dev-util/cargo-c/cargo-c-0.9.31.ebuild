# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/5d/cc/69/5dcc698a93c2b20b6e1561b3b16da4c5adef3226a179554de9a74a6cfadbeb0db00a863627706d75428e16bc1784b4800a177535416c56720d69e12bf1d82cad -> cargo-c-0.9.31-funtoo-crates-bundle-c8753d8a56e5554b807485dd35adfc6ca6e035d18f90d745205b52ce85df6de84f67743a12a9dfd52ea68df73013f4141f2ee3f00030e52d430aa8fe142e9e83.tar.gz"

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