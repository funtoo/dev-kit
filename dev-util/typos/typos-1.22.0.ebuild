# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/41752caac953aa62b357d386cc658221af004915 -> typos-1.22.0-41752ca.tar.gz
https://direct.funtoo.org/82/4d/c7/824dc786954c89531a2b4ba33a2e2aef2c0a07b980d89cfc3590219b513421790e869b12b99422a981c9249574e82b1a3432ed85ddc254a1cd71c158bb442cd2 -> typos-1.22.0-funtoo-crates-bundle-3e117cfd56457740d82900f501be2b9995cc44f3e20044c2e80a2e2745f08281f97dce7e53c9893e10750fc821c6f0f96e518555c0c30d699db85f5fed81ed02.tar.gz"

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