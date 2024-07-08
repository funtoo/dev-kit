# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/b2/11/27/b21127cfe022f31929785eef616a3197d65b55fbfd7be8fd03b99e1f8aa6f193fb0941382f34db1c0566e5e8baba09ed19edc9da0f464880e1d52c1c39fa2d1e -> cargo-c-0.10.2-funtoo-crates-bundle-c12e40916a647aa78a54983d24f8b6d7786f43673e940d2a8a2f281d6436cc86b159eae34fd11ea8d6dd107690a8b98c3534512afa60348a785973cfb2c11450.tar.gz"

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