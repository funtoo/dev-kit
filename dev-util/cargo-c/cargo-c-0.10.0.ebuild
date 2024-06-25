# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/62e72d44915675b2678f32e701bc1503d32881bb -> cargo-c-0.10.0-62e72d4.tar.gz
https://direct.funtoo.org/d6/9b/06/d69b068d7a2ec07b69c2765e4570da336a117bd7c4cb6e4214a5995723f589deeb7fc6a048ae9521fb4808e5b1dbea08fda6bd3f18fbf1dc1d81b83e68eecb7b -> cargo-c-0.10.0-funtoo-crates-bundle-5ecf4404f57fc0aa91dbea1ec9ae7373f2bda5c453661a83d65cdd48cb5e3d6eaacc6242ca700f0f66fea32d620d9aff550b91c9b668b16cabf45457e82fc60d.tar.gz"

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