# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Protocol Buffers"
HOMEPAGE="https://developers.google.com/protocol-buffers/ https://pypi.org/project/protobuf/"
SRC_URI="https://files.pythonhosted.org/packages/6c/49/f864b9fd6310d9a15ddae5b37d78dff1df0e2e1da476442fee062c6032b2/protobuf-3.19.4.tar.gz
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

S="${WORKDIR}/protobuf-3.19.4"

S=${S}/python

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.pth' -delete || die
}
