# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/8c/7b/ca/8c7bcacff847952d6f4f72b65b5b61796278214920ec13cfe291f95d4fd4a5df4b83294170d3036b5a2413625069e2ef9bf3cf5bcd2bad991c6eb870be46aee4 -> cargo-c-0.9.31-funtoo-crates-bundle-d091aba71e400ee0991c4de408ae38cac80b5be72e9e18059b5891aed25cfd2e6c18d8a2c820505b83fab9fcb682be3a3409be25e2f6afc14e47089770dad90b.tar.gz"

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