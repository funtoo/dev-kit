# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/29/c4/f2/29c4f20e343ee98916037d7a9e7bf1485ba4bdd99a52ab7ee26def55ade6da3e496b5a595436a2925e59f50b32dcfce985afa6574e878e097edff4d9dd048443 -> cargo-c-0.10.2-funtoo-crates-bundle-022e9aa8c503a4ec536561b2156b115e93206af92a3724ec6a152f8495d7f47b1c8d9e22a04a89f3ecd1b963b87ba13ae1bf370323ee0fecd905a8424b13e21a.tar.gz"

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