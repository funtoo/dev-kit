# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++ fast hash map and hash set using robin hood hashing"
HOMEPAGE="https://github.com/Tessil/robin-map"
SRC_URI="https://api.github.com/repos/Tessil/robin-map/tarball/v1.0.1 -> robin-map-1.0.1.tar.gz"

KEYWORDS="*"
LICENSE="MIT"
SLOT="0"

src_unpack() {
	default
	rm -rf "${S}"
	mv "${WORKDIR}"/Tessil-robin-map-* "${S}" || die
}