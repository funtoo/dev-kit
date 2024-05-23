# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/21ec8f523812b88418b2bfc64240c62b3dd967bd -> rust-analyzer-20240520-21ec8f5.tar.gz
https://direct.funtoo.org/1d/89/4e/1d894e64abe04db9903b9d45666b84b6d55bc0ec763d5d3668ac7923713f451ae0b50c4e5387170609860dbf31aca547fee34360e51ae45923957246ece34ba8 -> rust-analyzer-20240520-funtoo-crates-bundle-28e4fc92f971279da1efe44f6668020434d59944743b2bb347f420f3865da819acd309baaa3d5b835690b735701a45a75b447cb8b5553d06bc1fc8072e918272.tar.gz"

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