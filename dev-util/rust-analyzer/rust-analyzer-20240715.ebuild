# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/e9afba57a5a8780285f530172e3ceea1f9c7eff7 -> rust-analyzer-20240715-e9afba5.tar.gz
https://direct.funtoo.org/7d/a8/80/7da8804909b550554765d8499e6f7fbdd7c032fc7361f0249fdc8c5960883c26017a7a039580f4089de0fa9590f14e6a29c6baa4a44946e85812a5f49b7e9d19 -> rust-analyzer-20240715-funtoo-crates-bundle-ab7f6f77dce89f8cc4005db50d63f84c828f78ac3a054044e4978b911c32c843b3cf061bd816de6d52ada0474bac872f8165b3f46991385cc707dc66cea6a032.tar.gz"

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