# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/89/aa/db/89aadb99814589425a90baa15ba4a1a36c0f44c2747102e5526f80794cddc1c8bf48f81aadf096a82209d08897bac9ab55ca5fd7bb9a551585976a1b351ae0a8 -> cargo-c-0.9.31-funtoo-crates-bundle-677f7257f318493635b2af85c0c173d8bb5e5ffaf8397648a4b9749941938a65c51773f6cc7cc80a6e7f126bc61905d80b27f48ed30fe467100596449b258723.tar.gz"

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