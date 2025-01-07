# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/8914ddfa8d45a0c27abdb48708138a5bc32e5bd6 -> cargo-c-0.10.7-8914ddf.tar.gz
https://direct.funtoo.org/b8/4e/71/b84e714033f18e39ad05a0b8ec1c75d1f4bf3050ba9e948458d4b5e4011a602746ceec476087ded784d8f8297d8e592e4eab61aafda07bf7108bbe909b5b3ef8 -> cargo-c-0.10.7-funtoo-crates-bundle-a38641ce98fcec7fd1ee027523a1c59cf7972b55bc8686d0358123f6645be451e596683e6d888a2c410314f361901536dec85ef5a1e436f6908c61e2ece6659a.tar.gz"

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