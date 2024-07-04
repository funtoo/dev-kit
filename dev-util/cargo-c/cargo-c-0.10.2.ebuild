# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/a6/3a/c0/a63ac0f233f00340e6fc3de04049b0ada73a754055dcfbad5b9199d8c2d85a8ba7f18734442a8b1ffb883a20887a6955275306d0a7181309ad6d39f466b61aa5 -> cargo-c-0.10.2-funtoo-crates-bundle-ffdb4598786974068e399201780752bc114f0f58a52c9fa58ae79d4b13116e42c18a37338e6f91750c90dd386c6ae9aac55c7a6b5df112e613b41da1f3ae21e9.tar.gz"

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