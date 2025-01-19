# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform Rust rewrite of the GNU coreutils"
HOMEPAGE="https://github.com/uutils/coreutils https://uutils.github.io/coreutils/docs/"
SRC_URI="https://github.com/uutils/coreutils/tarball/31d1de5a3a449d451f8c5b8a794dbfdb5fc427a5 -> coreutils-0.0.29-31d1de5.tar.gz
https://direct.funtoo.org/cd/34/4f/cd344f215e8ac2d2a76552a6c09d8f38a67a8d31171141c538e9cdf97262a0c9fb2bba112fcaed800ff684491be90273e84c8cc4a44bb0db86279f2fad0bffe6 -> uutils-coreutils-0.0.29-funtoo-crates-bundle-68b141fb4da3084e5f46d98682cc9e32d1318d4211df2d4de5e170c45d99482764220750b97f3f7ea4cdccba55086ad29de7b9f1186acb3f33ce0a89e67fac97.tar.gz"

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