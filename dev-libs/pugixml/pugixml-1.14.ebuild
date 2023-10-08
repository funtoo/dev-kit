# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Light-weight, simple, and fast XML parser for C++ with XPath support"
HOMEPAGE="https://pugixml.org/ https://github.com/zeux/pugixml/"
SRC_URI="https://api.github.com/repos/zeux/pugixml/tarball/v1.14 -> pugixml-1.14.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

src_unpack() {
	default
	rm -rf "${S}"
	mv "${WORKDIR}"/zeux-pugixml-* "${S}" || die
}