# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Protocol Buffers"
HOMEPAGE="https://developers.google.com/protocol-buffers/ https://pypi.org/project/protobuf/"
SRC_URI="https://files.pythonhosted.org/packages/37/52/4e40f7513b44671817a92dc566f4a6e8eba65bfc94f79da23186e6c127ce/protobuf-3.19.1.tar.gz
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

S="${WORKDIR}/protobuf-3.19.1"

S=${S}/python

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.pth' -delete || die
}
