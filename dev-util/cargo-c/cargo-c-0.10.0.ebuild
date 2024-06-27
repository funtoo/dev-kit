# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/62e72d44915675b2678f32e701bc1503d32881bb -> cargo-c-0.10.0-62e72d4.tar.gz
https://direct.funtoo.org/ab/44/5f/ab445f63080374277be1100453007676fcb304348b6f96b81aa8358cfa1f99da23704d642dc8ef27189502c7f27efec0f53a4b4a5851786468d2d83f67379451 -> cargo-c-0.10.0-funtoo-crates-bundle-17ae70f338af56211f0a293560bd28882931aea54457dda6a9255c8dde97b65eca7fc9ebe02e91bd35d727805d944b9735422e5a394c10074855140b8ca33f26.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="sys-libs/zlib
	dev-libs/openssl:0=
	dev-vcs/git
	net-misc/curl[ssl]
"
BDEPEND="virtual/rust"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lu-zero-cargo-c-* ${S} || die
}