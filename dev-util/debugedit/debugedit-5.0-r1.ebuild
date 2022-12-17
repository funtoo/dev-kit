# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Create debuginfo and source file distributions"
HOMEPAGE="https://sourceware.org/debugedit/"

SRC_URI=" https://sourceware.org/ftp/debugedit//5.0/debugedit-5.0.tar.xz -> debugedit-5.0.tar.xz
"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	>=dev-libs/elfutils-0.176-r1
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-apps/help2man
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/debugedit-5.0-funtoo-patch-collection.patch
	"${FILESDIR}"/debugedit-5.0-musl-error.h-fix.patch

)

src_prepare() {
	default
	eautoreconf
}