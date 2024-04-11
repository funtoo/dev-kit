# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b140d7ca93d0ca734552866b205ac525fb13c67d -> cargo-c-0.9.31-b140d7c.tar.gz
https://direct.funtoo.org/36/b2/78/36b2787fa4a5e74dd10c67c1687bec80053a2f8d765ce14405205610afb4fabb8a5574066f2e1186af67aaad90cd948bb581e46d609909f18107835acb1f8c94 -> cargo-c-0.9.31-funtoo-crates-bundle-e2a958b28ee509be3119ad2ddb954aee47c43fa46bbabc45980827fd9a537b77669cedc36cc16dba89f97266a6384e19a74c4664516315702ec62671591d747c.tar.gz"

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