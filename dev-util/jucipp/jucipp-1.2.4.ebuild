# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

EGIT_REPO_URI="https://github.com/cppit/jucipp.git"

M_COMMIT="1ef04246b8f77f823fc2ddb19b4562c7b6d8261b"
TINY_COMMIT="8025c4582384333afd22c988861b70cddae0e633"
DESCRIPTION="A lightweight, cross-platform C++ IDE supporting C++11, C++14 and experimental C++17 features"
HOMEPAGE="https://github.com/cppit/jucipp"
#SRC_URI="https://github.com/cppit/jucipp/archive/v${PV}.tar.gz
#https://github.com/cppit/libclangmm/archive/${M_COMMIT}.tar.gz
#https://github.com/eidheim/tiny-process-library/archive/${TINY_COMMIT}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
#~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libgit2
dev-util/lldb
sys-devel/clang-runtime
dev-cpp/gtkmm:3.0
dev-cpp/gtksourceviewmm:3.0
app-text/aspell
dev-libs/boost"
RDEPEND="${DEPEND}"

src_configure() {
    local mycmakeargs=(
         -Wno-dev
		 -DLIBCLANG_LIBRARY=/usr/lib64/clang/4.0.0/lib/linux
		 -DLIBCLANG_INCLUDE_DIR=/usr/lib64/clang/4.0.0/include
    )
    cmake-utils_src_configure
}
