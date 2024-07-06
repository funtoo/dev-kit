# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/1e/da/50/1eda501a525cdee06c98d4464918ff2e702c9ec24e6b956d7777a9ec1bd9a4f716bea001ebf7825dd71bd3275eb11b7f2352f09aa9876cb6a5982f4cab7a3570 -> cargo-c-0.10.2-funtoo-crates-bundle-3859ab30008408b24039b486bba646355c30cdc6b38c01541da2e90bf86196948c1bf735f9ac2f61a3d2d41d211fa4898c52b4e83962fc6d8301ef7c279f38b2.tar.gz"

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