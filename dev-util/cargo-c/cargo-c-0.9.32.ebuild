# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/51/f3/8e/51f38ee3bb0d62c9684c0ccaca2a6703f98db8b2f7977e35047699ea2702fef8a201efbac7a6a1c808e3180db22730bb4dee66d9f43d2938a19ad4cf93ef4bcf -> cargo-c-0.9.32-funtoo-crates-bundle-cf19661ad61eb03e6ac7ad2c4503822a4cafc1f53229b586554398b388f5fb590d6368d40c19401f40dfac593ed486694604af3ff4ab7e0e54537d4cfc05b2ab.tar.gz"

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