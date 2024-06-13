# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/cfe759ac8dd421e203cc293a373396fbc6fe0d4b -> typos-1.22.7-cfe759a.tar.gz
https://direct.funtoo.org/04/c5/ec/04c5ec0c8723b97f23ef11fa08c5826d1901873ed81e64860ce89a999c0b71a99c8afbbf373fcd16e8e9e8be67d2a1ed64067eda1066b4f1604f46c389362f8c -> typos-1.22.7-funtoo-crates-bundle-9036c5210f28867bd12bc0af211f635f13493a6d017e112f4104c6b71c60779e637a59de7f096cdd96b176fd10a4f4324d307428aab10b16248ac68768d38f43.tar.gz"

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