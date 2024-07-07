# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/4d/a3/2d/4da32df5ef03b5e78a0b3154207e9525c7f82c68a313f3a552f4028d7598d9512219ffc5ab4ac80c29d30e7bfc716230de8484d48839f1fee30ecbc5e7b7f53a -> cargo-c-0.10.2-funtoo-crates-bundle-14e6c7d3df68f83eb964a0f86f0bd32a13f33e98151116a11a35615ecc0a33d510fbcb785dfe5db36f02d57f836c534fc1726aff7d6be1ac466f2284e9b5dc23.tar.gz"

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