# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/d0/da/d4/d0dad4a16790e4089ec819e3a2dfa94fcdc429985ca685839956baa8b15c3d872f8f9fd9f9279c0fec5256dd405799fb290a80a75007a892cbdf245067756d34 -> cargo-c-0.9.32-funtoo-crates-bundle-d9f172779f6463cf66ba2a81bc7729af784f87f94133f6bd4a721e756766be87fa4489bf65a8f07cd5c80994c5ce6f00b955ebdc750cdf82301d68259a7e2003.tar.gz"

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