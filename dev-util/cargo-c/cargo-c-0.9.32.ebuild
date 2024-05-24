# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/11/11/66/111166151cccd855ebcaf3640e8585dc3289639c7a395885d894fd34a872897227054e0fd143f4398517b7d1638daacbd02c59a4010644798b3460d7fd04f8ac -> cargo-c-0.9.32-funtoo-crates-bundle-667cdea12c70a40fa8222748f0cf898df139f4dabfe3c1f39327c8ea4d7eb163d53e3d3a8adef5f0ead0db7ff34221e4e264b9e7e22c9d368067400626303181.tar.gz"

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