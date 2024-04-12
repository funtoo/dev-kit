# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/f0/fd/db/f0fddb4e26e41bddb34a9ffd68c3f32442c8761246bcbfcb51a95e7be540a0b3dac894451c217457dae1855417ba86fe5dc8fd71efdff3e3a2cc5607ee6a58cb -> cargo-c-0.9.31-funtoo-crates-bundle-3c98033e64d1e7b5e050afd3fe27d553f387b6ea3d1647130d07160739dea5bd56e0ff47533b2f2f63ef39224132e90c4224d6e3551b65e2b539a4fcf7669511.tar.gz"

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