# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/1a/0b/08/1a0b08ccf2daf208bca017538ad6cd8519a0f398da1b27b010a637e8d6ad923322ad2afa18fa969ddf1e8212d2410244a56f7fdf4fa5c8b5987673adb3286e4e -> cargo-c-0.9.32-funtoo-crates-bundle-79d6129a70bcf962ac21b64b0978439816042f3cbf99308208bc43ed8da5e2d756fe40cd7411cd8ae8e5400b536e101edd65fda571c8d1d8f0d9d560ebfe3f00.tar.gz"

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