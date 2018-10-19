# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )
inherit distutils-r1

DESCRIPTION="Python client library for MariaDB/MySQL"
HOMEPAGE="https://dev.mysql.com/downloads/connector/python/"
SRC_URI="https://dev.mysql.com/get/Downloads/Connector-Python/${P}.tar.gz"

KEYWORDS="*"
LICENSE="GPL-2"
SLOT="0"
IUSE="examples"

# tests/mysqld.py does not like MariaDB version strings.
# See the regex MySQLServerBase._get_version.
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND} dev-python/protobuf-python[${PYTHON_USEDEP}]"

DOCS=( README.txt CHANGES.txt docs/README_DOCS.txt )

python_install_all(){
	distutils-r1_python_install_all
	if use examples ; then
		dodoc -r examples
	fi
}
