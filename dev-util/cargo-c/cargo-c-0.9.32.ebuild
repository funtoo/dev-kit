# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/61/7f/92/617f926c83ba7107706860c5619b50546afb055fbb203eb5ef63d154571ce018a33f8d6d1243f2a6476b158011cda89cec3b4dcbff6f183a7b81f95900edc1a1 -> cargo-c-0.9.32-funtoo-crates-bundle-48e440d23f75c3569a61e8d22426c6fc1705c14dede52ae6a86ecbbd90f6f31c17147a67a2c4452238ac25739eccf31b0f2f8b911d3f4e7cca1291cfe53a0290.tar.gz"

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