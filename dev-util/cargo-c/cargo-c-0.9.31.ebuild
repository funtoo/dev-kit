# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/1f/ed/e2/1fede22d9f253b0d6f33d4a4fc7b3b163771877899f66f0f3f2f570f2ea732ec3934bd2860e39e473a053c3cc2e93fcb3b838abaa3082610ab3dfd15fdb46075 -> cargo-c-0.9.31-funtoo-crates-bundle-076cdd37ccf5ffde755036ab526b518d7e4d82137405091f0e377a69ea589e9da4d4b5180d17a8c38f8702b1a807e5356a6696953cadc7692cc71c1c91c8f789.tar.gz"

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