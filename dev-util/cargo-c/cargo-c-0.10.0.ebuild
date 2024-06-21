# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/62e72d44915675b2678f32e701bc1503d32881bb -> cargo-c-0.10.0-62e72d4.tar.gz
https://direct.funtoo.org/ca/fc/78/cafc78b4b0a9d07eda53b17eb899c139ac063d4d100c03f200b23ab4c2011f1ccc13cf6b1600bc74f2d20a8b7b7655eebf60d8d38276511f9278fd1083c715f9 -> cargo-c-0.10.0-funtoo-crates-bundle-2ed93bb1f3d508efb63c01e0d1bdbf8e211b4f70f82134fb34a281e4dd5948cc869470f048568ef61b33af29401724dfbd2087eed201f6a24b8867507f62b91c.tar.gz"

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