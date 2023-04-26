# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Wayland C++ bindings"
HOMEPAGE="https://github.com/NilsBrause/waylandpp"

LICENSE="MIT"
IUSE="doc"
SLOT="0/$(ver_cut 1-2)"

SRC_URI="https://github.com/NilsBrause/waylandpp/tarball/4321ed5c7b4bffa41b8a2a13dc7f3ece1191f4f3 -> waylandpp-1.0.0-4321ed5.tar.gz"
KEYWORDS="*"

RDEPEND="
	>=dev-libs/wayland-1.11.0
	media-libs/mesa[wayland]
	>=dev-libs/pugixml-1.9-r1
"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)
	"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCUMENTATION=$(usex doc)
	)

	cmake_src_configure
}