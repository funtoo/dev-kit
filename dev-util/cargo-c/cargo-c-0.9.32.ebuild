# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/e2/aa/4d/e2aa4d0c75283ab5aab81536fecdca42e4c3500c2d7b3db12e08737835135b56a904fcba3e4c224384268370e5e1b85c0c320379d629a1299bb576716207851b -> cargo-c-0.9.32-funtoo-crates-bundle-4e0ca73a82510cdf4d7ad5ef3d0a338330eb2e632d74201e238d37af5016dd2b74db22fc3a72df8085d3a846ccda56368b5563b64d4ce79135f8a2820a7f6524.tar.gz"

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