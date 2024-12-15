# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/8914ddfa8d45a0c27abdb48708138a5bc32e5bd6 -> cargo-c-0.10.7-8914ddf.tar.gz
https://direct.funtoo.org/c2/f5/c2/c2f5c2a5f54c37034945a88d3a38ec9b651969967874348446911a569804c9a1c01e5af309a4918c94ccf618dcd8c1b4da68b2b18317d481ec109de5b9367ac9 -> cargo-c-0.10.7-funtoo-crates-bundle-49984185c4c0db5a656a9657513653b1570fc8ce9781adbbf684aebbafc271eed6d55e6229db9dbb119333b4054eb8e40f54160909cfd818f35538419d67499e.tar.gz"

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