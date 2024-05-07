# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/3c/e6/3f/3ce63f7917f6b0e6024abb0ddfcdea956b6944e49660210be56a4eb27f7da5697d713c3181c7f522c123ff078db1789f62fe7f634d0902b11ce43aef964fe6aa -> cargo-c-0.9.32-funtoo-crates-bundle-34a7c154080accfb95b8a97a557a06514a7309e3c93da683bed0d4d2fb9277183c1ad577d175591911c11a87e662896a0f1983a19c341c09ddf4ae028dbafca7.tar.gz"

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