# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/756974fb8962be45319fa3ad3bd9eb8033bdc76a -> cargo-c-0.10.1-756974f.tar.gz
https://direct.funtoo.org/9d/aa/aa/9daaaa18902e747ddf7f98508476b1fc147382f42de92f3d6f322b2b70347624fe3a29df66a84eaceea7f87a03b4dbd8af8b21569bfdd3c295de66b4c52bebcf -> cargo-c-0.10.1-funtoo-crates-bundle-17ae70f338af56211f0a293560bd28882931aea54457dda6a9255c8dde97b65eca7fc9ebe02e91bd35d727805d944b9735422e5a394c10074855140b8ca33f26.tar.gz"

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