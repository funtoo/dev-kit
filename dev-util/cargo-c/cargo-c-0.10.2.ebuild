# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/90/b4/a4/90b4a436c2fb9b6f6b647282437903fa69fb05f789fb9b9491c07cf5d489fed6f08c4819fd4c4faf539c89a0d9a03802506d11d4fe6b16feb98cf3fe14653bbc -> cargo-c-0.10.2-funtoo-crates-bundle-7216f95794234d64e0875d62de6305d9df132233c254d0bf39f5c2a5173c1efdbb22a2cd19e8263545894efefc9a2b22cbd0a0ce4ff6c70417ec991e725f2b56.tar.gz"

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