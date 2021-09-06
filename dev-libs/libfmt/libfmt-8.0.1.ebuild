# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake
inherit cmake

DESCRIPTION="Small, safe and fast formatting library"
HOMEPAGE="https://github.com/fmtlib/fmt"

LICENSE="MIT"
IUSE="test"
SLOT="0"

SRC_URI="https://api.github.com/repos/fmtlib/fmt/tarball/8.0.1 -> fmt-8.0.1.tar.gz"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
RESTRICT="!test? ( test )"

post_src_unpack() {
	mv ${WORKDIR}/fmtlib-fmt-* ${S} || die
}

src_configure() {
	local mycmakeargs=(
		-DFMT_CMAKE_DIR="$(get_libdir)/cmake/fmt"
		-DFMT_LIB_DIR="$(get_libdir)"
		-DFMT_TEST=$(usex test)
	)
	cmake_src_configure
}