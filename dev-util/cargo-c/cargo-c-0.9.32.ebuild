# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/a5/79/ff/a579ff1f2bce189e5a3112924f9e57e2bac1d624b0e156aadae7eede62a14ff5e0ec51b9196dfdc91f8fc23cc142e2a30818a5a41220834cfdb03e0c0e77f58e -> cargo-c-0.9.32-funtoo-crates-bundle-23c52e0da7d6fd711326bcbea1207ec7112c6e2c765ee93daacb103d4b9396594d4639ef6618217057a6630d308439e1bdd46d4173284533bb48e13e7b263c04.tar.gz"

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