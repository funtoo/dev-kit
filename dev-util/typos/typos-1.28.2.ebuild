# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/2872c382bb9668d4baa5eade234dcbc0048ca2cf -> typos-1.28.2-2872c38.tar.gz
https://direct.funtoo.org/42/d9/e0/42d9e04b841a2e40d6318a24c94796b46bea36f09d8bd43c7b627caa40e54dbb9ab6037c1b632208439aa79940dfe002749ad44ce2e0d9b9b170afd0b32cdf82 -> typos-1.28.2-funtoo-crates-bundle-1dd2d6fb3571cd07a0aeb66128baf69a493d525a88a668cbec5d7f0bd24e2568b1ed7dc9976c32df0b79cfb4973222a6f60c9784533894660fa5d0b120865455.tar.gz"

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