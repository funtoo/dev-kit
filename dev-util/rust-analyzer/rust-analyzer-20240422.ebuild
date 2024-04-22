# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/47a901b9bf1f99b1ec5222d478684fc412d526a5 -> rust-analyzer-20240422-47a901b.tar.gz
https://direct.funtoo.org/84/f1/07/84f10707dd88b4ba9345426e054a87028564d0e4829df7decdb2d33c0e5114d3103c71a5c09b1a89e079ecb6b71bf1ca2407bd1d9598da76a8fbb954c85c1a99 -> rust-analyzer-20240422-funtoo-crates-bundle-5266e5c13da942f79c405fdaad4b343d0c36a95407755797349ba10923ac4b5c90380cfbb9148aa4c68d22d617e336064ffcc585f0f97101bebe9ae1c17981af.tar.gz"

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