# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/f9/a7/36/f9a7362c217391a4d7da527a476d8a762a6c848b62d890e8ad4f91e7f2da25f99281b54d17edf2894fcf90ca5a02085f676b3d414f451ce58a60fc1018d97cb4 -> cargo-c-0.9.32-funtoo-crates-bundle-cbeb2a62dc9e4649e2984b9a83527f74015cc19519623469501e4d6074708e258012dc11911e936b63444aa3830409b46de23d63a3946607e1be174b3926c508.tar.gz"

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