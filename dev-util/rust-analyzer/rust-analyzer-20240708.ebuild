# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/a5b21ea0aa644dffd7cf958b43f11f221d53404e -> rust-analyzer-20240708-a5b21ea.tar.gz
https://direct.funtoo.org/74/31/ca/7431ca89de97695ff7b1ad8e1dca060bdef33c939a854ea38d6ab4c0e8dc3ef9a5ead4392ba16068479892cbb1ef6ce0d0d27d6572e0d21144634723a58f360c -> rust-analyzer-20240708-funtoo-crates-bundle-7c2b228efc4320f578a75108fb68fcc7b292ad04a13f3bc8d49a60990e16805e5b3ce5e9a0d2e2c2e829e45ea900e21e709e4d1acdf4dcec61de53e73f4d7a30.tar.gz"

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