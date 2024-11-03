# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="UTF-8 C++ library"
HOMEPAGE="https://github.com/nemtrif/utfcpp"
SRC_URI="https://github.com/nemtrif/utfcpp/tarball/b26a5f718f4f370af1852a0d5c6ae8fa031ba7d0 -> utfcpp-4.0.6-b26a5f7.tar.gz"

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