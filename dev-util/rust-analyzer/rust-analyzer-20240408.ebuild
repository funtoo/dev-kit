# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/8e581ac348e223488622f4d3003cb2bd412bf27e -> rust-analyzer-20240408-8e581ac.tar.gz
https://direct.funtoo.org/10/9c/6e/109c6ee4df5cf5001c53b98200948d42d83e012244f6ea1e41cfe3f91dbcfe2c17b0962d0d7b66e550d4a7a1a35b17bbbadef70924e2a4bb3f03f219bbc18cc9 -> rust-analyzer-20240408-funtoo-crates-bundle-881b7bfe29e84ca1054936c0e0f0b3e6e436222ee1e199742dcc45e29a4d6882b3da573f2ad9856bc32bf00fe75d756df5e894c2df23df8578c5dfbf0180193f.tar.gz"

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