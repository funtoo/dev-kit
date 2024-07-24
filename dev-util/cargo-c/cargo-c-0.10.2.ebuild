# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/f0/3d/37/f03d373e53e8659744683073e1913940f8b7caa3d13cad403e81194cb26c58ca412da4571641050dd55b3ea5eb1d18377c88e4bd9cc7a4d9671c624b7a900339 -> cargo-c-0.10.2-funtoo-crates-bundle-ad9e8d9b0754913abb8de76080f81a4c64fccb31dd0261cb4e9ea6edd0714eaa843ed1e3a6392d17aafe06fee117d97f911a454a3c5d42da16d44396e851c630.tar.gz"

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