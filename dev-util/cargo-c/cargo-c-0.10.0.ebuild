# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/62e72d44915675b2678f32e701bc1503d32881bb -> cargo-c-0.10.0-62e72d4.tar.gz
https://direct.funtoo.org/28/50/4a/28504af1158334242b92e276f287cc84acc34eecfbe6006e8f7830825b3c96306276316bcf0158dae6bf773e3b82eb3955138668eb03aae62d05ddbd716c4112 -> cargo-c-0.10.0-funtoo-crates-bundle-0f25f1717de7759ee2b47c9ce852736848a38a9e4bbb50bc481444ecb4a6d21efbc5a6c3e0a80ddd83ae83b5831f9b8fffd3d495dff3d84f5307a44eca4f59c8.tar.gz"

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