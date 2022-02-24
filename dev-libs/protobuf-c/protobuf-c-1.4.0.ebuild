# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Protocol Buffers implementation in C"
HOMEPAGE="https://github.com/protobuf-c/protobuf-c"
SRC_URI="https://github.com/protobuf-c/protobuf-c/tarball/f224ab2eeb648a818eb20687d7150a285442c907 -> protobuf-c-1.4.0-f224ab2.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
# Subslot == SONAME version
SLOT="0/"
KEYWORDS="*"
IUSE="static-libs"
RESTRICT="test"

DEPEND=">=dev-libs/protobuf-3:0="
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -type f -delete || die
	einstalldocs
}