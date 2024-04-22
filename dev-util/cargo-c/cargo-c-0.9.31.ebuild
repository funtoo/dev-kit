# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/ed/21/33/ed2133a2d0929be681bafd80386208b0f3b0492c4a1abf1464adadf4d4bd8a6a120a6eb7e4c5263fa8fca7739b64379cd66359966dd81b791aae71e0d9b68eae -> cargo-c-0.9.31-funtoo-crates-bundle-10e6457e423ededbfed2ad2f32472225984a40329f2449c36a5444b2ef2c798b8dbfada04ca0989ea35940b9f1c24f82e62b1b475f813cbe18db90bfb26e8e96.tar.gz"

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