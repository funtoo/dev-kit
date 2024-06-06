# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/49d37361a04c8119928f7463881fbc32a1c1abd0 -> typos-1.22.1-49d3736.tar.gz
https://direct.funtoo.org/b0/a9/4b/b0a94b87cbf307b1c7faca9cb651159b995df59b58bbf50b057c99cf382170667928da20a43d8d6ce40aa2d85b990e4d2a34ad60d3961191a0bff23aa872f84d -> typos-1.22.1-funtoo-crates-bundle-9036c5210f28867bd12bc0af211f635f13493a6d017e112f4104c6b71c60779e637a59de7f096cdd96b176fd10a4f4324d307428aab10b16248ac68768d38f43.tar.gz"

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