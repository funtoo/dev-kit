# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/ee7d7ef74b9c1fa00c6780da41a838752c76b3eb -> cargo-c-0.10.3-ee7d7ef.tar.gz
https://direct.funtoo.org/2e/36/21/2e3621f7d55f4ab75119d7cd7c7db0d84f5373bfa0908355de5da37d1ae763b6ff75c0685cd3510c3b8606a4154a33a55778135b8ec97ed8541335bfbd56f7a5 -> cargo-c-0.10.3-funtoo-crates-bundle-deb47f3b6989e3fa861944b239676c7a69b599f8708a3ee613edd30533103f55cb44eaa100ee6ee74bea3c21a22bc1cd2f769b5aacff2f13cc1ebae2a1b0a492.tar.gz"

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