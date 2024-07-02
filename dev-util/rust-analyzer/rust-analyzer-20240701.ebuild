# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/ea7fdada6a0940b239ddbde2048a4d7dac1efe1e -> rust-analyzer-20240701-ea7fdad.tar.gz
https://direct.funtoo.org/2d/8e/4d/2d8e4d147df6eeb9a5c9cd5c38fb5e8fccd8dc7a84b6d0a14ffe5e968b96065e6e8c4b1eb3d043d9d01deab06a7819016fe50b568fb1fc7345844a6b0d792ab4 -> rust-analyzer-20240701-funtoo-crates-bundle-089741ce2617bb8360571526ab27f1a64bc114d4acd030b5f7fd89e252e8d26f66dcf39d6b8da56f727791da3e3fe340b97d590c43a79dd100d10c6949c80a17.tar.gz"

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