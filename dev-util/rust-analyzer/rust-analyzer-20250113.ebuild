# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/8364ef299790cb6ec22b9e09e873c97dbe9f2cb5 -> rust-analyzer-20250113-8364ef2.tar.gz
https://direct.funtoo.org/87/33/85/87338535df69e5bb18509f2df15e882c71edc8eb46dbb290e097771db17d3522bcc78dbb319ca957ef08cda5c1304f538cc8736703f969c44fe77c0d3f5437b3 -> rust-analyzer-20250113-funtoo-crates-bundle-370049bf8af50aa653e7d39a532ee4639ed4ca124ac22503c46c680899ad79113bddf842da9d868678271e2e3ae23c4c77e6f0acb41200b42fd7d690c0303282.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/rust-analyzer"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/rust-lang-rust-analyzer-* ${S} || die
}

# To populate a custom version for rust-analyzer use the CFG_RELEASE environmental variable
# If this is not set rust-analyzer --version will return 0.0.0
# Upstream code reference: https://github.com/rust-lang/rust-analyzer/blob/master/crates/rust-analyzer/src/version.rs
src_install() {
	RUST_VERSION="$(rustc --version | awk {'print $2'})"
	CFG_RELEASE="$RUST_VERSION (-standalone-funtoo)" cargo_src_install --path "./crates/rust-analyzer"
	einstalldocs
}