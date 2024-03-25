# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern ls with a lot of pretty colors and awesome icons"
HOMEPAGE="https://github.com/lsd-rs/lsd"
SRC_URI="https://github.com/lsd-rs/lsd/tarball/0e70dbdb7ae99b409130820bfea383ce8fca7492 -> lsd-1.1.2-0e70dbd.tar.gz
https://direct.funtoo.org/1a/c7/1a/1ac71ac45ad33f0507b293017481b7c57a3b431f6bae5ba4e1403642986530cd41572e8c2202e9f47f2a56d55124cc20158267d62794285331e3c29f97302a4a -> lsd-1.1.2-funtoo-crates-bundle-a732516cc1607bd8673ee9620663a94f66d2a765985118ea77254fd5893551afc2ff03ad067dac42e1b4af4785775d12b756b3d850a535b12789e2ca5213bf2e.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+git"

DEPEND=""
RDEPEND=""
BDEPEND=">=virtual/rust-1.31.0"

QA_FLAGS_IGNORED="/usr/bin/lsd"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lsd-rs-lsd-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}