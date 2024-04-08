# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/2f/db/b6/2fdbb68d077c9e48af57ee1f0413d6263dbff7413ae7028da7c75cdb57207954615fa719f80565b6051aff85b0e34864b6c9abb613d4996367be5bceeb898aac -> cargo-c-0.9.31-funtoo-crates-bundle-8f227dc41518b502b03825a1c0e21e0ae2f72917212c71cee9d7fc3d2825f9e2e853570f2b4a23edf0ad3e114835059161273600afcb252b45c414b2cc4a4c08.tar.gz"

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