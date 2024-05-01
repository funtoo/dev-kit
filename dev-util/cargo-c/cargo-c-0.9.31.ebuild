# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/be/51/10/be51103a3485280352507557ebe138a9e78cc197014e7f3a644fe2d0dd7cbfe6fd22a969f5f973001da2ff5a93916fbfe08daf3317a9029a582eaab2a91f6a5a -> cargo-c-0.9.31-funtoo-crates-bundle-78b86c1882c294c8006811f44744e23a34c0af79517e5304ac2a2ced75b3665ee763dbbd39736386f4a85eb8ab038dbdf78751fa7d374d2fd3547b86cb0f5e63.tar.gz"

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