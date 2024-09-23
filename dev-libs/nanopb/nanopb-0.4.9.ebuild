# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

DESCRIPTION="plain-C Protocol Buffers for embedded/memory-constrained systems"
HOMEPAGE="https://jpa.kapsi.fi/nanopb/ https://github.com/nanopb/nanopb"
SRC_URI="https://github.com/nanopb/nanopb/tarball/98bf4db69897b53434f3d0ba72e0a3ab1a902824 -> nanopb-0.4.9-98bf4db.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="doc examples +pb-malloc"

RDEPEND="
	dev-libs/protobuf
"
DEPEND="
	dev-util/scons
	${RDEPEND}
"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/nanopb-nanopb-* "${S}"
}

src_configure() {
	use pb-malloc && append-cppflags "-DPB_ENABLE_MALLOC"
	cmake_src_configure
}