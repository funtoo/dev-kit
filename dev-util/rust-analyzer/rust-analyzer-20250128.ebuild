# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/1f86729f29ea50e8491a1516422df4fd3d1277b0 -> rust-analyzer-20250128-1f86729.tar.gz
https://direct.funtoo.org/70/96/0e/70960ef4c9b1e0a55a89c261b00663a82fb593e29eb2e30bf0b051b8225043e3af0fc473d36a2a4d6de559c5274e18cbd0de4b258412ba07cf8434822478f775 -> rust-analyzer-20250128-funtoo-crates-bundle-a72c9430ed49130fe02070f3b6d5006e442772686a9458aa3a6ea95d8afd89c4ea194d70874a129016b0def9329427a11278851c9c4fe0571abcea3a698a144a.tar.gz"

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