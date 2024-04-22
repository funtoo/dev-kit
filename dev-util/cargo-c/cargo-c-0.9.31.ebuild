# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/16/94/c5/1694c50b0334a97e86b1f44fd3cdf21e9b42709dd711507f60d0467b69e1e554af349964f06a414c7dc128d8a81fc33340e6a28f034a63c36595ed651bfd3c8e -> cargo-c-0.9.31-funtoo-crates-bundle-85297c6a54219630edfbf625d6321b13eba9871819d8104a2be1cb1e8229a11210b99cac6d8627f07a7c04f5a9b3b19b498f9da18876fc3d317e2aabf246f941.tar.gz"

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