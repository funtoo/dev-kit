# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/95/8d/8f/958d8ff12a0391e619fda70040b60cc734f6d090dd2626be40e552e98c4598ebf3ec408f2b6c1c390cfac4e5030757c66c3b494526e51434b4d82bdb65c5fbf8 -> cargo-c-0.10.2-funtoo-crates-bundle-061804081742a9b3e05b9b17a0f3d807dee25003f7b34409a83cb1bbc292489aac7ac9d954d47dcb360003826e16684d50c35413ecc801c157401773213078cf.tar.gz"

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