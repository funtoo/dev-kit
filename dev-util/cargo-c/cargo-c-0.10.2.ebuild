# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/16/bb/86/16bb863345eb9af5d7609bb55e0e8ab5b20c1c7635e5f4dc638c495ae0bb100a49a450d3a7f4ebb3f0ba42555f862248cd526f6f130b391a098500b7833f5ef9 -> cargo-c-0.10.2-funtoo-crates-bundle-d3df00b57ae315ebe07ea6b7fdc0a0c5ccb43e1e11a1f264fc7dc34d94bb5e193fcd595e4570a460c818de92829f33e4c4bddeffcfe326eced7b1da0e0a8cfdc.tar.gz"

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