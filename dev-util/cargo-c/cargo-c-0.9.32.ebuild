# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/2e/11/e9/2e11e95019bf8d200be46d08cb5b461bd704bda9b0fcd7d5d1be747219364c6a8e7f8d9989126bde13032421c5abe307a46c010cb83a672cde48d8bf13215ac8 -> cargo-c-0.9.32-funtoo-crates-bundle-1b255727d9fc9bae34438db296539d3d947216bba344c2cd881b0d4e801b0da3d2417d315ea78220c34c9fa29707119bb34dd14f61b1933e4469b22dd83938be.tar.gz"

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