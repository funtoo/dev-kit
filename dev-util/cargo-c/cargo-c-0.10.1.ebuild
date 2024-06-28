# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/756974fb8962be45319fa3ad3bd9eb8033bdc76a -> cargo-c-0.10.1-756974f.tar.gz
https://direct.funtoo.org/83/c1/9e/83c19ee23c90d3e032d4275e55f73c97f9124f7013f3ccfd7a03d906823fb7fbc2332b995762180bb1c244fed453ce019977a6a169e16443f7c9a4b237e18368 -> cargo-c-0.10.1-funtoo-crates-bundle-6c4cd5e0f79c0f03ae71607b9ea1d8c8c21869773d639721e4a3f29da537de6e0df1b40bd1d4abe0387ed7c70a89bc6426d20bf54864ac0ae0f571bbc7a640bc.tar.gz"

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