# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Source code spell checker"
HOMEPAGE="https://github.com/crate-ci/typos"
SRC_URI="https://github.com/crate-ci/typos/tarball/d503507db9c5d116c79135435b149cd0f27d726e -> typos-1.21.0-d503507.tar.gz
https://direct.funtoo.org/48/bd/a1/48bda1ca05eeee3bd324149c9ab480a0cec36e7bf27bb463adaa5be995b539ee2ada1e4927661a9f4d32a6b98962cbd4b65098bf1cfd85bdafeb9e14c6408def -> typos-1.21.0-funtoo-crates-bundle-e8429bc936b008fa408a89419e21e3b9bb82193ccf158c4a9131b623a2e36d19fcf0180fe95120c73c1c9e2245f7e5bb6d11f05a832dae3a24034483cd414c2b.tar.gz"

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