# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/62e72d44915675b2678f32e701bc1503d32881bb -> cargo-c-0.10.0-62e72d4.tar.gz
https://direct.funtoo.org/c4/87/80/c4878036e0dae9d6503d88da439706f77972bdc3d27014ca6a7ba043aea36cc6ec00ecc31e811b21f4f428a8d5c573ec9ff67c9457b380715564ed36533066fe -> cargo-c-0.10.0-funtoo-crates-bundle-6197e406da8da09592369b7058ccc4385d825b6c32ae472fe800e0a766e5edae8089f2938f60e415cad72d47d91ad8b9e5443dc69f46f1a79fc7e9d3e8972b98.tar.gz"

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