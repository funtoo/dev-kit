# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

DESCRIPTION="plain-C Protocol Buffers for embedded/memory-constrained systems"
HOMEPAGE="https://jpa.kapsi.fi/nanopb/ https://github.com/nanopb/nanopb"
SRC_URI="https://github.com/nanopb/nanopb/tarball/6cfe48d6f1593f8fa5c0f90437f5e6522587745e -> nanopb-0.4.8-6cfe48d.tar.gz"

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