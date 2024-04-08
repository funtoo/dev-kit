# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform Rust rewrite of the GNU coreutils"
HOMEPAGE="https://github.com/uutils/coreutils https://uutils.github.io/coreutils/docs/"
SRC_URI="https://github.com/uutils/coreutils/tarball/68c77b4bd129bdc12d03cc74fe0f817d2df75894 -> coreutils-0.0.25-68c77b4.tar.gz
https://direct.funtoo.org/50/c0/a3/50c0a32b6f01d328d5c16965c0fdfde994b65680c108ed23d123e8f3ed11f3d56b32add4c82bff8fd187507c88303304e9ba453a00e3f09dc9f5631ce28274c5 -> uutils-coreutils-0.0.25-funtoo-crates-bundle-9196d6c0861cf42343c48ee45cfbf075d051a9888c7f739e9e93102e8a3a59254d722d2b9b7259a71275c532e78dc4316af265835cfb56f911327cb08ff9cc55.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

DOCS=( README.md )

QA_FLAGS_IGNORED="/usr/bin/coreutils"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/uutils-coreutils-* ${S} || die
}

src_configure() {
	cargo_src_configure --features unix
}

src_install() {
	cargo_src_install
	einstalldocs
}