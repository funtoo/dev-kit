# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform Rust rewrite of the GNU coreutils"
HOMEPAGE="https://github.com/uutils/coreutils https://uutils.github.io/coreutils/docs/"
SRC_URI="https://github.com/uutils/coreutils/tarball/6dff066e6fa4ad9b713ed7c34c7c198115dec6bf -> coreutils-0.0.26-6dff066.tar.gz
https://direct.funtoo.org/88/9e/13/889e1324e0482f456149f03e9888ba6812a4b2696df6bab103c24e465f96b46114a700940740f150a72eab191aa12ec8fba48b39360acb901783ddee3b635166 -> uutils-coreutils-0.0.26-funtoo-crates-bundle-873ff6f3f4f7cb7e5c4f7fe6a82650ad3131115f61fe78799f704880114afaafb782771f408d00aed42844691150c64d28f849d01fd1ee1f602d7eace8e53c4b.tar.gz"

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