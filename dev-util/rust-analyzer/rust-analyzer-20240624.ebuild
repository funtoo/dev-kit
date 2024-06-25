# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/2fd803cc13dc11aeacaa6474e3f803988a7bfe1a -> rust-analyzer-20240624-2fd803c.tar.gz
https://direct.funtoo.org/6f/88/6e/6f886e6146548eea4a30d8396c5105b37726d4b6bb9863234d41309e6e0bd627177efd9b9c181657c8d792288bc8d8f988aaa079ea93a5c7c6d7df93c14a6804 -> rust-analyzer-20240624-funtoo-crates-bundle-089741ce2617bb8360571526ab27f1a64bc114d4acd030b5f7fd89e252e8d26f66dcf39d6b8da56f727791da3e3fe340b97d590c43a79dd100d10c6949c80a17.tar.gz"

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