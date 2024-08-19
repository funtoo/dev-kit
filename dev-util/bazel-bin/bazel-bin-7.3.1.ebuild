# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_INSTALL_DIR="/opt/${PN}"
MY_EXEC="bazel"
DESCRIPTION="Fast and correct automated build system"
HOMEPAGE="https://bazel.build/"
SRC_URI="https://github.com/bazelbuild/bazel/releases/download/7.3.1/bazel_nojdk-7.3.1-linux-x86_64 -> bazel_nojdk-7.3.1-linux-x86_64"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* amd64"
# strip corrupts the bazel binary
RESTRICT="strip"
RDEPEND=">=virtual/jre-11"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}/${MY_EXEC}"
}

src_install() {
	into "${MY_INSTALL_DIR}"
	dobin "${MY_EXEC}"

	newenvd - "50{PN}" <<-_EOF_
	PATH="${EPREFIX}${MY_INSTALL_DIR}/bin"
	_EOF_
}