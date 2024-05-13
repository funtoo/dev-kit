# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/5bf2f85c8054d80424899fa581db1b192230efb5 -> rust-analyzer-20240513-5bf2f85.tar.gz
https://direct.funtoo.org/f5/f9/71/f5f971a19f01b0bf21b75a88ae4712b680b0a0ffbcd90a3b28ec32d5c860a33cf4a24cf266ce7412b6f68d94ee19629454d5918f48779ffcbf6d2fd598202dda -> rust-analyzer-20240513-funtoo-crates-bundle-5266e5c13da942f79c405fdaad4b343d0c36a95407755797349ba10923ac4b5c90380cfbb9148aa4c68d22d617e336064ffcc585f0f97101bebe9ae1c17981af.tar.gz"

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