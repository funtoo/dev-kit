# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/f0/0c/78/f00c7851f2f524e692e8f3e6be5ff0d3df1b612348f435b54c8826b93b4df1e1613a26c5b3283171f509b8643646cbde228aa39c45590e4fc9c932f6eecfc7e2 -> cargo-c-0.10.2-funtoo-crates-bundle-5c8861f5ec521346236a365f2a63247ea52d2c42807af1c4981a7a897067860998d83e2b9e661f5936c30613d4bccf4a682fb08bb4737003e0ada21ecd68aafd.tar.gz"

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