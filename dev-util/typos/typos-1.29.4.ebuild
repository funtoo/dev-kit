# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/685eb3d55be2f85191e8c84acb9f44d7756f84ab -> typos-1.29.4-685eb3d.tar.gz
https://direct.funtoo.org/b5/91/3b/b5913bb9514ffe66d02ed36dbf1ed21a13a03cf46d35f803ff965b606f40114d635a9a3c657bb20ebcb6d9a3bd1594b6d2ac258b14bbf847657861833c88ed33 -> typos-1.29.4-funtoo-crates-bundle-98e29801364d5431187c28b4b05bc9cdd748eb39617b0a2ab433df61bc9b6a7e8b3b8709d7d5fc006855506514eea46ad20f4dc883600d34d6cae47428d2c00e.tar.gz"

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