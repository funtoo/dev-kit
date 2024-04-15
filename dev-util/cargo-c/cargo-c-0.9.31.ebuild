# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/5d/79/e9/5d79e9fcd4c196cc42fdc899e4420b2b4dd4409da13c536786ac04577ecc6be08935e91817466d655edd25b013e2f4a63f7464429104757bee4e64e58ac041fa -> cargo-c-0.9.31-funtoo-crates-bundle-c55896635b83aece6009f675d9bbf39013fabc7a2a901704d7bbfcef18b7afb750be11c610286c93ea30e7b998baad618e0ea478d41cdac096651a4be035d8c0.tar.gz"

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