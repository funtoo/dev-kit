# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/dde47868a506acfe1117a6ea9621271439d8c89b -> typos-1.22.8-dde4786.tar.gz
https://direct.funtoo.org/c6/43/ba/c643ba03a4f83454b48f994b1f927308d6edfb10c0d962575dd7d8cc6f786c3a22e05386421483b9776cd0911e7666854811c9cd28a9ac71e57f3e50e2080066 -> typos-1.22.8-funtoo-crates-bundle-9036c5210f28867bd12bc0af211f635f13493a6d017e112f4104c6b71c60779e637a59de7f096cdd96b176fd10a4f4324d307428aab10b16248ac68768d38f43.tar.gz"

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