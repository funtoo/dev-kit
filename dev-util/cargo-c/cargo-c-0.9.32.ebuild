# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/24/ca/c7/24cac7690695123ef61e41fb2743446cfed2568b83707f3978e16738c3734790ea34bdd70391d6aa3e737c10fc854e006a83792fa5f501abf156dd9c92f855fa -> cargo-c-0.9.32-funtoo-crates-bundle-233333d20e836ae8f9a2f2ed1c89bc7c19e52cb34b227dcdae5e839bbe9b734ccae7d53329e312d5bf29bc754ed5188a13269b1b84f596b61e9800d6bfdde15b.tar.gz"

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