# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake cuda

DESCRIPTION="C++ template library for linear algebra"
HOMEPAGE="http://eigen.tuxfamily.org/index.php?title=Main_Page"
SRC_URI="https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.tar.bz2"

LICENSE="MPL-2.0"
SLOT="3"
KEYWORDS="*"
IUSE="cuda doc" #zvector

RESTRICT="test"

BDEPEND="
	doc? (
		app-doc/doxygen[dot]
		dev-texlive/texlive-bibtexextra
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-fontutils
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexextra
	)
"
DEPEND="
	cuda? ( dev-util/nvidia-cuda-toolkit )
"

PATCHES=(
	"${FILESDIR}"/${PN}-3.3.7-gentoo-cmake.patch
)

src_prepare() {
	cmake_src_prepare

	cmake_comment_add_subdirectory demos test blas lapack

	use cuda && cuda_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKEPACKAGE_INSTALL_DIR=$(get_libdir)/cmake/${PN}${SLOT}
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		cmake_src_compile doc
		HTML_DOCS=( "${BUILD_DIR}"/doc/html/. )
	fi
}