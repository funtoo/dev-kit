# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io/ https://github.com/rust-lang/rust-analyzer"
SRC_URI="https://github.com/rust-lang/rust-analyzer/tarball/71a816a90facb6546a0a06010da17598e11812f7 -> rust-analyzer-20240527-71a816a.tar.gz
https://direct.funtoo.org/16/30/a4/1630a400463c81c3a9c62a8c6f17d703da67df190203c4ed30bc4f38906a78a9160e4a8a01535891d8c97bf2b51a05aeb884dc3c3fad4f13f3b592dd7db1397a -> rust-analyzer-20240527-funtoo-crates-bundle-28e4fc92f971279da1efe44f6668020434d59944743b2bb347f420f3865da819acd309baaa3d5b835690b735701a45a75b447cb8b5553d06bc1fc8072e918272.tar.gz"

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