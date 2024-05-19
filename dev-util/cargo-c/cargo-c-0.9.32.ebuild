# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/d3/d1/65/d3d16523dde0d58974ed7db0e84259682ee34002fbb1409758eea050ca4f267452232b68c3e2040f38e579cfa406d8d52a9f9d5437349511a1446e0e985ead21 -> cargo-c-0.9.32-funtoo-crates-bundle-ffa98a3dba03dc7f65f75100b66c30d65813fe439c9ad9c194a814aeeb7515afd120e594f248f4d853e1d954a3914154c3ebc56c624b59071959242d3ead592b.tar.gz"

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