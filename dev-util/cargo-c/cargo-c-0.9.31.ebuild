# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/ec/87/1e/ec871e2dddf11d93a0a190ae9513d16775da5a4477889d581625a0128128587e4ce83d23d3881fd8cce71f2d8f1029e0b36c3a1eee2dd0f3f704b1214ecacc10 -> cargo-c-0.9.31-funtoo-crates-bundle-2c910d82de18597f7cb7bcb4904f74ff0bfdc69f9a8dab8f2112471c0504125c6668ce4fd1d78ad4ee267d62e0950a2c77337fc9a39d52e9e6ebab79948fa3d4.tar.gz"

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