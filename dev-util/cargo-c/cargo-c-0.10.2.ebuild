# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/a0/2d/e6/a02de6a5a02ac401f64954bed6b5ed4d1f03759ef6e5cd7e839e4794e6b9b1e35bb5c5994a699b8f59c8f4219349f0cf2254edfd9989a98f152aec3565d8befb -> cargo-c-0.10.2-funtoo-crates-bundle-8447bb33b9cf19c882a3ab615be4210cd52b37ca39d799f5151d2b182d9fd22f59d5c26566a6e6e197de6b184ae263dc7934f10361b4d83b2239c5f5e0da09dd.tar.gz"

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