# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

S="${S}"/python
DESCRIPTION="Protocol Buffers - Google's data interchange format"
HOMEPAGE="https://developers.google.com/protocol-buffers/ https://github.com/protocolbuffers/protobuf"
SRC_URI="https://github.com/protocolbuffers/protobuf/tarball/f0dc78d7e6e331b8c6bb2d5283e06aa26883ca7c -> protobuf-21.12-f0dc78d.tar.gz"

DEPEND="
	~dev-libs/protobuf-${PV}
	dev-python/namespace-google
	dev-python/six"
RDEPEND="${DEPEND}"

IUSE=""
SLOT="0"
LICENSE=""
KEYWORDS="*"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/protocolbuffers-protobuf-* "${WORKDIR}/${P}" || die
	fi
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.pth' -delete || die
}