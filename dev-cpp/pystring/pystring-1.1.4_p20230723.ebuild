# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++ functions matching the interface and behavior of python string methods"
HOMEPAGE="https://github.com/imageworks/pystring"
SRC_URI="https://github.com/imageworks/pystring/archive/76a2024e132bcc83bec1ecfebeacd5d20d490bfe.tar.gz -> pystring-1.1.4_p20230723.tar.gz"

BDEPEND="
	virtual/libc
	sys-devel/libtool
"
RESTRICT="test"

KEYWORDS="*"
LICENSE="BSD"
SLOT="0"


PATCHES=(
	# https://bugs.funtoo.org/browse/FL-10883
	# Upstream recently added a simple CMakeLists.txt but it does not install pystring header files
	# https://github.com/imageworks/pystring/pull/29
	"${FILESDIR}/cmake.patch"
)


post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/pystring-* "${S}" || die
	fi
}