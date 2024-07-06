# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/81a34f1ca2d0bfdcc3470c0f279a20333cb94878 -> typos-1.23.1-81a34f1.tar.gz
https://direct.funtoo.org/67/53/46/675346bc48b1f8f7d91d789838b91a5b9e210def4ee4cb9f2f1219ec7c3010497407311ac0cdfb6738d2ea9119ae6934f04af922f82313c513c11f6849fbcd6c -> typos-1.23.1-funtoo-crates-bundle-e7ce1e865f26a88c8a8384b51417c6d5e512c64564aece060ed3e60d1480b7d15db8c3532114c241e7ded3b320efc0d561f473866f20c272d19c317212622ad5.tar.gz"

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