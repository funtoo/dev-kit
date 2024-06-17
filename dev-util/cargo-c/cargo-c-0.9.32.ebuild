# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/40/ec/23/40ec23062a5ba9c002e9ddfaa4e909f97e3ab906db30909a6d211b76c3755b8d12258416f44222ff8cc0ef0b56d38264988d6b068fccd04a1514df1571d6e802 -> cargo-c-0.9.32-funtoo-crates-bundle-e10328ec8c2ae5fb07da514903eae0194268c382f9a1497729c1fffa3e059da0cd00223dbd8259027a0a70cf569d3acf5a8288c76960c7b7c26437240dd74d59.tar.gz"

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