# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/3ddcf00482aad5eb418a6cd1955ea2125d0785c1 -> typos-1.23.3-3ddcf00.tar.gz
https://direct.funtoo.org/0a/f6/e5/0af6e5b1576119845418a7512f9b70974f5f444943455ee2caad7ac0dcf3f1d5f54c11947efe48b3778f91c8717b2d78ac30e23fbe08a8d869f3cd5ff6450823 -> typos-1.23.3-funtoo-crates-bundle-577631637e02f939e4530005aea1ad7985c75d5e30e3bf59c81b98a641880fab820c5caa8774f6c21a6895c4060a3eab578aa9aecd85114f36dfc8624c25b158.tar.gz"

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