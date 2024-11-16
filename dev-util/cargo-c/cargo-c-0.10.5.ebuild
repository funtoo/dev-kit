# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b6081a47813aab0175645e332b14282c651c893d -> cargo-c-0.10.5-b6081a4.tar.gz
https://direct.funtoo.org/48/84/fa/4884fa2807570d0acbf6e3e3153721b8fd027dd84d0cff29eebb5417a3484197fffe7359c084a34b5fa37888f06eb2b95c257f4c6b7111e151937418493ab4c4 -> cargo-c-0.10.5-funtoo-crates-bundle-29ae7bc9e06b1c6931c92df470d3952e0da2a574cb39077a2ce02af47985c9e2feaa401ba444ec49b5d56e54959d5277d13105301c9e1e7e9ec2123e0340081f.tar.gz"

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