# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/c16dc8f5b4a7ad6211464ecf136c69c851e8e83c -> typos-1.22.9-c16dc8f.tar.gz
https://direct.funtoo.org/7c/69/a7/7c69a778a6035f36dd1a93aec89a0bc2cd28755cf5fe6357b75c33b76947cc0d3521729fb5382fb6a202d50fca71ee15e8fdc88e57d7da2a23eb9e76f9069fde -> typos-1.22.9-funtoo-crates-bundle-9036c5210f28867bd12bc0af211f635f13493a6d017e112f4104c6b71c60779e637a59de7f096cdd96b176fd10a4f4324d307428aab10b16248ac68768d38f43.tar.gz"

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