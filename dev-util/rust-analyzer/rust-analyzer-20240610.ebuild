# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/b427d460ebafcd9ba01607a2c920ca7572559288 -> rust-analyzer-20240610-b427d46.tar.gz
https://direct.funtoo.org/d9/d6/0f/d9d60f38956e1132c7bba57b167f0a0e1704cd2540e68ccdc8a818d3951b65ae182eaf5209cfb7f70fa9c0e3c2f3658fce5c535f08edf1716a623540605015b5 -> rust-analyzer-20240610-funtoo-crates-bundle-089741ce2617bb8360571526ab27f1a64bc114d4acd030b5f7fd89e252e8d26f66dcf39d6b8da56f727791da3e3fe340b97d590c43a79dd100d10c6949c80a17.tar.gz"

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