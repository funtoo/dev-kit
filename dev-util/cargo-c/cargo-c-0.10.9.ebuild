# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/578b4ed8a8baa9faa42a072ca40b7267b125fc15 -> cargo-c-0.10.9-578b4ed.tar.gz
https://direct.funtoo.org/e2/c3/79/e2c379d6d166e293cbe38ce2b37408eeacf4543eb1b556edd1add4df40a4b3f28baceac7f3703e542f9b0c966df59c87c2669ac47537adf3a25488b3a5602e4a -> cargo-c-0.10.9-funtoo-crates-bundle-b3fbd2cf83e77d4a3c396a46de8c66b058e24e8abcb2e400aa36f39114a5a99130ff8bf89c4ef248f906a2ddd361828a996b5d5c71a7347335821c7c44b66787.tar.gz"
# https://forums.gentoo.org/viewtopic-t-1131762-start-0.html
# https://forums.gentoo.org/viewtopic-t-1111448.html
# This is a confirmed fix, but it doesn't appear related to 32-bit time. Some other sandbox crap:
RESTRICT="sandbox usersandbox"

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