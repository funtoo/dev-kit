# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION=""
HOMEPAGE="https://github.com/protobuf-c/protobuf-c"
SRC_URI="https://github.com/protobuf-c/protobuf-c/archive/v1.4.1.tar.gz -> protobuf-c-1.4.1.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
# Subslot == SONAME version
SLOT="0/1.0.0"
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