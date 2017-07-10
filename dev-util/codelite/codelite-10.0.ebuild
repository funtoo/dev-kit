# Distributed under the terms of the GNU General Public License v2

EAPI="5"

WX_GTK_VER="3.0"

inherit cmake-utils wxwidgets

DESCRIPTION="A Free, open source, cross platform C, C++, PHP and Node.js IDE"
HOMEPAGE="http://www.codelite.org"
SRC_URI="https://github.com/eranif/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang flex mysql pch sftp webview"

DEPEND="
     dev-db/sqlite:*

     net-libs/libssh

     x11-libs/wxGTK:3.0

     mysql? ( virtual/mysql )
"

RDEPEND="${DEPEND}"

src_prepare() {
     epatch "${FILESDIR}/codelite_dont_strip.patch"
}

src_configure() {
     local mycmakeargs=(
          $(cmake-utils_use_enable clang CLANG)
          $(cmake-utils_use_with flex FLEX)
          $(cmake-utils_use_with mysql MYSQL)
          $(cmake-utils_use_with pch PCH)
          $(cmake-utils_use_enable sftp SFTP)
          $(cmake-utils_use_with webview WEBVIEW)
     )

     cmake-utils_src_configure
}
