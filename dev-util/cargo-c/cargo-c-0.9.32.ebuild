# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/e9/4b/00/e94b00d9f173948117f642715a5c5c11cb731a4f2d9f57494991db2ad0308b3077138b2196f541a98fa3353be91e0457970705af42aff60abd7c2620bccd2e1c -> cargo-c-0.9.32-funtoo-crates-bundle-cc9a27a605bb1b5343f603c9e746be12b34428880e93c74a28404c55d486112c62686fc0db40be7303b516bca9e9dcf91667f381a723840711cb46ebfbc3ad46.tar.gz"

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