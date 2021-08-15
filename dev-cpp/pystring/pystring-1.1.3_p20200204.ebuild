# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++ functions matching the interface and behavior of python string methods"
HOMEPAGE="https://github.com/imageworks/pystring"
SRC_URI="https://github.com/imageworks/pystring/archive/281419de2f91f9e0f2df6acddfea3b06a43436be.tar.gz -> pystring-1.1.3_p20200204.tar.gz"

BDEPEND="
	virtual/libc
	sys-devel/libtool
"
RESTRICT="test"

KEYWORDS="*"
LICENSE="BSD"
SLOT="0"

PATCHES=(
	# Patch to convert the project into cmake. Taken from:
	# https://github.com/imageworks/pystring/pull/29
	"${FILESDIR}/cmake.patch"
)

src_unpack() {
	default
	rm -rf "${S}"
	mv "${WORKDIR}"/pystring-* "${S}" || die
}