# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/5dbe3fe75c584aee2063ef7877a639fe3382461e -> rust-analyzer-20240415-5dbe3fe.tar.gz
https://direct.funtoo.org/f8/6d/ec/f86dec693776e71463d5df5632afcb2dc4d660566fb9f665e897b5f3cfd2ab730c59c29a473ed430040f887f5a56e0237377c76539edabd3d14544c5e415043b -> rust-analyzer-20240415-funtoo-crates-bundle-6d855821a0ad4f2b62631973853cf162858f71dc6ed372d3e2744f00eafd9f62206f70106555a88b293a5e17c04aabba36870bc3631ce1aa2ea9ecac4c306f50.tar.gz"

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