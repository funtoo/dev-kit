# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/f9/cd/b3/f9cdb345ee2286f015d1f2b8349713792a3cbe691a8d365d0894d47553f7b333555b599bce4c39f8ed23ebef66821c78dc47e9c22a47a28c3bd31e869da5c9e5 -> cargo-c-0.9.32-funtoo-crates-bundle-4ca6f3919ec20006cd106304e5f9b4eb03919616f694b0ef83d3217aa460bfca5a066c20677dd40bb763bde5e7db435b6a67edd70689fa25207c4b47025fae79.tar.gz"

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