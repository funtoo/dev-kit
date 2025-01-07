# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Command-line Git information tool"
HOMEPAGE="https://github.com/o2sh/onefetch"
SRC_URI="https://github.com/o2sh/onefetch/tarball/9d5131feb8874fa7d2bdea71b31b4875510b0824 -> onefetch-2.23.1-9d5131f.tar.gz
https://direct.funtoo.org/bf/66/01/bf66015616effd1664c16191ffba689a4090f2e0a74958504c007942a145018d6f101de751ba2cb7e736a294628c20b755e236ab5e3856a3990c33705d021a5a -> onefetch-2.23.1-funtoo-crates-bundle-f859acdcd1e966ec5f83303f70818d499c8ce68073e3b10efc5b893569dd4f92896152788947afc3e6ae7467e23d1c81015353112119588cf69f3ada80d9e0ce.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/onefetch"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/o2sh-onefetch-* ${S} || die
}