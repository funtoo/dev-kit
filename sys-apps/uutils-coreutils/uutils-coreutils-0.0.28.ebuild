# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform Rust rewrite of the GNU coreutils"
HOMEPAGE="https://github.com/uutils/coreutils https://uutils.github.io/coreutils/docs/"
SRC_URI="https://github.com/uutils/coreutils/tarball/9074cdeeeee32e4bc127191ccd55ab4b27ce5898 -> coreutils-0.0.28-9074cde.tar.gz
https://direct.funtoo.org/83/30/bd/8330bd7dd85f9113e1dacf1a31bd2d3efdc54f70cf41c72ba809d485296d8087193dd3a6383176f2f976ba1648329b2ef4df5fd558f1b2cd5762b8bf4d6963a5 -> uutils-coreutils-0.0.28-funtoo-crates-bundle-f81ca77525ae68f3d8f4f9b3d46a69d9713bc6b1505e13582fd7de37f11c69949cbb17ffcd434cb0ca41dd2af0e448fa226de6a7f57100deac62d6f50eb9202f.tar.gz"

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