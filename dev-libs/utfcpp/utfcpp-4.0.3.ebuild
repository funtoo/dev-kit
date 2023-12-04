# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="UTF-8 C++ library"
HOMEPAGE="https://github.com/nemtrif/utfcpp"
SRC_URI="https://github.com/nemtrif/utfcpp/tarball/c9733bbe49d32c7ed35a3a19c05da10ed61dd94f -> utfcpp-4.0.3-c9733bb.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="*"
IUSE=""
RESTRICT=""

BDEPEND=""
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack "${A}"
	mv *"${PN}"* ${S}
}

src_configure() {
	local mycmakeargs=(
		-DUTF8_SAMPLES=OFF
		-DUTF8_TESTS=OFF
	)

	cmake_src_configure
}