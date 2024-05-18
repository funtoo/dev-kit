# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/ae/c0/38/aec038f57d585969cda22d3e3270d647647ca89bfe790a009c1421fd04f4ee0e5c316805cce7d4daf1152d6737f2e9420fd4438ab3bded85c6fc22f005c8afd1 -> cargo-c-0.9.32-funtoo-crates-bundle-fbe99156006ee516ae8fcc3d8c8f83b497d355a2060800209f9f871fa8c55287272dbf85012eac266ea0488ce6fad3fa8de916a85cc380d6bb3e8a0bf87bb75f.tar.gz"

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