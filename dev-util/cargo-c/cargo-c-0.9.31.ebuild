# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/93/98/33/93983301a4a9a8d8b94bff55a89d69ec5281286ccda7218f69643bc335ab137c9d54e46de78c8a8e8c20f27420b99fa79e2fc40a38e9120ffcda2677f865875f -> cargo-c-0.9.31-funtoo-crates-bundle-44d45af40cd457b5581684876495e68694baa08ff146d0ac4be2cc87735395ff265e73873d054d0c4f71dbfa88426a129f3a5fc568ac0ec7a25224a1efb39f41.tar.gz"

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