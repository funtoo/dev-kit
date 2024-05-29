# Distributed under the terms of the GNU General Public License v2

EAPI="7"
GNOME_ORG_MODULE="${PN/pp/++}"

inherit gnome3 meson

DESCRIPTION="C++ wrapper for the libxml2 XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="https://github.com/libxmlplusplus/libxmlplusplus/releases/download/2.42.3/libxml%2B%2B-2.42.3.tar.xz -> libxml++-2.42.3.tar.xz"
LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="*"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/libxml2-2.7.7
	>=dev-cpp/glibmm-2.32.0:2
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local emesonargs=(
		-Dmaintainer-mode=false
		-Dwarnings=min
		-Ddist-warnings=max
		-Dbuild-deprecated-api=true
		-Dbuild-documentation=false
		-Dvalidation=false
		-Dbuild-pdf=false
		-Dbuild-examples=false
		$(meson_use test build-tests)
		-Dmsvc14x-parallel-installable=false
	)
	meson_src_configure
}