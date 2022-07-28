# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++ functions matching the interface and behavior of python string methods"
HOMEPAGE="https://github.com/imageworks/pystring"
SRC_URI="https://github.com/imageworks/pystring/archive/089194ddaf62a9cd536caf0e9ed7f0054979efa5.tar.gz -> pystring-1.1.3_p20220724.tar.gz"

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