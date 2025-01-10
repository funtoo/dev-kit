# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/8914ddfa8d45a0c27abdb48708138a5bc32e5bd6 -> cargo-c-0.10.7-8914ddf.tar.gz
https://direct.funtoo.org/4f/1b/15/4f1b153515d0de4c68b030a7bdb6a0db5d22df5e0e83f8db02a0eb064751ef160fdfeb2e22d8bed58d6a8e5faafdbd05531da7bad60172e3ab9c45fe3ed358b9 -> cargo-c-0.10.7-funtoo-crates-bundle-f148d62327fa9cc65749480bc3880bab4d6d00cc53e9f721ed7447cbf07a91a35efc6a043493040b9daec4d500a591cdcb0f6b5dc073447c2d8cb5026b4e0c39.tar.gz"

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