# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/9b/0c/e3/9b0ce364fa6a3bd25ea042d6f370a95534fb3101ac1ab50fbd63aad310625e5de2861bebcfebaaf356f6401cb610c997f7d90c5a5579c3de1ee8ee7e702e8b80 -> cargo-c-0.9.31-funtoo-crates-bundle-703d7c4b151bc808db7a386068ba454ef83301e9aefccb38cf061dc198f6ebed9e26f1541308f373af061f122d3d6c702abd25ee78b456695bc3b222add3eec1.tar.gz"

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