# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/d01f29c66d1bf1a08730750f61d86c210b0d039d -> typos-1.27.0-d01f29c.tar.gz
https://direct.funtoo.org/b7/49/c2/b749c2e45fecdd6593d1193b9b9f48195ff0c5c7957bb7e302e834ca9786e2e97ce0f7b8dcd68df07c97011c3bb057d7727cc9a7d850bfa4084525368afac42d -> typos-1.27.0-funtoo-crates-bundle-1dd2d6fb3571cd07a0aeb66128baf69a493d525a88a668cbec5d7f0bd24e2568b1ed7dc9976c32df0b79cfb4973222a6f60c9784533894660fa5d0b120865455.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/typos"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/crate-ci-typos-* ${S} || die
}

src_install() {
	exeinto /usr/bin
	doexe target/release/typos

	local DOCS=(
	docs/design.md
	docs/reference.md
	CHANGELOG.md README.md
	)
	einstalldocs
}