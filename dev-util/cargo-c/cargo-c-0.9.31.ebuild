# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/5c/f4/9e/5cf49ee0ed01ccd482837c5148d16909cd32d9c1c7bd81e2c71a84207aa33503fbebae094db6cb730e777e0730164ab71a4ed9d3d4819867db05398040da56a4 -> cargo-c-0.9.31-funtoo-crates-bundle-48968197c9e9e2092869a23fcd091de438a6d26270ddf0c52577d0b0e3b02e867fa479d20f407686ecf3384edd9baf0e4046417e76ed954faef5b317f43703e1.tar.gz"

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