# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/08c7bbc2dbe4dcc8968484f1a0e1e6fe7a1d4f6d -> rust-analyzer-20240909-08c7bbc.tar.gz
https://direct.funtoo.org/7e/96/17/7e9617c4b5a73d0df7afea9ee3337d5625d4ba47c70c8c90e193ebeecc84c496e179c9cbdcc051140eb4773e48a1e394efc0151dc3d957169557c16a3fa65104 -> rust-analyzer-20240909-funtoo-crates-bundle-bc3544eabbab215b5eb01c55f8eb8976a2bf2506e00d40925e4fe9014691019fabf468b98a7af8cdc2080aebdd76838a4e375160869b1c176cde5653cf273d77.tar.gz"

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