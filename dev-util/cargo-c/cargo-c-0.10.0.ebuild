# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/62e72d44915675b2678f32e701bc1503d32881bb -> cargo-c-0.10.0-62e72d4.tar.gz
https://direct.funtoo.org/fe/99/b2/fe99b27cb261409ab186b5a9c76a8f5e0759a0d1e8296121bbe3d4f78fff82e35e10a401d4959bbacf41d1368bc8d3dfd9763af05584f3d6834a30f2c2c642bb -> cargo-c-0.10.0-funtoo-crates-bundle-2b2f1b4834b705ea18b7d9387754384dce9a3a4b7d756a57e1a4287ecb49d9c78c61e8d86c26be6d78d22ffbbc87e29f7dbfc85c727252a885ce2b30bd8d0800.tar.gz"

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