# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/de/0d/69/de0d69f2265a04de64bf8e9a2231c2a628f2fc0169e84f3ffd4e69629a335b326b850f0522344fa0e49947d48ac4408c4604b89ce9d5745a62064eb01fe874d6 -> cargo-c-0.9.31-funtoo-crates-bundle-633857ccd90dbd7a0bcb76b041de69af18e3170d272cc055c76ab331aff4f00630d31d4e615d950363cf851c40ae6970c1312236fde50e143f85389c5382f381.tar.gz"

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