# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/ce/f0/41/cef041ed0c3a530eef4790b20093de1e386faa5d2c3e80c96d789a3b7d448944e4475d5acc38ca7e5385158f032f3d4407ee8a157655cf1d9759e40fdc11a79c -> cargo-c-0.9.32-funtoo-crates-bundle-a83c41d4d8c8a2d84d2bfcaf046d3b3a18d615af0ec4492b2af834ea35e45d69ea881db1486157a7e4ae1c8b5645adf59e2b80b91f1a836b179f883e001ca316.tar.gz"

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