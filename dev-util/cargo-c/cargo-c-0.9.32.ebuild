# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/93/bc/56/93bc5680dd17fae59c5d44aa1cda2dd8a87bc53c98b784f3268ea00be96bb131ed9a14594acb6e0220c5d2a9e36c95b91a736bb79afadd62a3b69481d94f0848 -> cargo-c-0.9.32-funtoo-crates-bundle-8d72b74fe4fc28f618892f5fe3c4eb5c339ffc95f5e49ab3fa84aa6b779dc184a36eb5435f0b9c84cc6b60f35829bac285eb70355ac7144a8ab500f6da3b1223.tar.gz"

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