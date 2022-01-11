# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Protocol Buffers"
HOMEPAGE="https://developers.google.com/protocol-buffers/ https://pypi.org/project/protobuf/"
SRC_URI="https://files.pythonhosted.org/packages/d9/d5/bf6c307f58b4c486f6517341d2f2673cd889b7d3a83cae78a9081233c679/protobuf-3.19.3.tar.gz
"

DEPEND="
	~dev-libs/protobuf-${PV}
	dev-python/namespace-google[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND=""

IUSE=""
SLOT="0"
LICENSE=""
KEYWORDS="*"

S="${WORKDIR}/protobuf-3.19.3"

S=${S}/python

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.pth' -delete || die
}
