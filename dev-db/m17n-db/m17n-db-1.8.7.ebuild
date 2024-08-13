# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Database for the m17n library"
HOMEPAGE="https://savannah.nongnu.org/projects/m17n"
SRC_URI="https://download-mirror.savannah.nongnu.org/releases/m17n/m17n-db-1.8.7.tar.gz -> m17n-db-1.8.7.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="sys-devel/gettext"
RDEPEND="!dev-db/m17n-contrib
	virtual/libintl"

src_install() {
	default

	docinto FORMATS
	dodoc FORMATS/*

	docinto UNIDATA
	dodoc UNIDATA/*
}
