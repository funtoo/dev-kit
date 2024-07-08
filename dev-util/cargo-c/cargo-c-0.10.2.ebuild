# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/ba/f3/a7/baf3a7f717ccf8eb9ae88327721d0c553d76b48cb2f6ad877504caae933020f9097511161d4ba41b1c5080f9c31297fb0ec7f7497e6f5aaf443b4bf486f0bea5 -> cargo-c-0.10.2-funtoo-crates-bundle-846c343c3eff2ec8a3c9b2840351b810cb43d557db324dfd3e0364754a94f6cbe11b45f414fabca3341f6aef4e7f1816d3b7f444e9a4a8e99a4f078e40afd87b.tar.gz"

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