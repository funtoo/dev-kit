# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/c027fcf597e10154a8bc55c46182a4c2480d8d25 -> cargo-c-0.10.6-c027fcf.tar.gz
https://direct.funtoo.org/ae/d0/2b/aed02b4ad8e6185b4e1af3baf9b34b38b579d27e5c390a6b3556d1b43dc66da7f5d1b05bf2d09f436b201461d36bc11de254f1d43b88e5486b1ce17f367cff58 -> cargo-c-0.10.6-funtoo-crates-bundle-bc91e291e36276554ce417b2f4a8f89044efa50ee5d359826b88aff3da5c339923e737ad2a24cda8be158651e33df71e4348f195d2507076e26754691a8ceadc.tar.gz"

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