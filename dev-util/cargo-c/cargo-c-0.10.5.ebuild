# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b6081a47813aab0175645e332b14282c651c893d -> cargo-c-0.10.5-b6081a4.tar.gz
https://direct.funtoo.org/87/25/15/87251514cf4ae6050b944b778f1d5cd88955f1ea0b65dfe3c4c29798ac8b26a0ec610a82a5b2258d437bd4a4084e4e705471e791926d0eb98b9cc3f5e8317d54 -> cargo-c-0.10.5-funtoo-crates-bundle-407e6d420f35242284c8f255fe5ab2c0cbba94919ee026213915f0e4d29e7e7577931d388ce7d42fab8af09c6074204dff5ab17a9cc4f6e3defcd25a838da472.tar.gz"

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