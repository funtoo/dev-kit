# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tree-sitter is a parser generator tool and an incremental parsing library."
HOMEPAGE="https://github.com/tree-sitter/tree-sitter"

SRC_URI="https://api.github.com/repos/tree-sitter/tree-sitter/tarball/v0.20.6 -> tree-sitter-0.20.6.tar.gz"
KEYWORDS="*"

LICENSE="MIT"
SLOT="0"

PATCHES=(
	"${FILESDIR}/${PN}-no-static-libs.patch"
)

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/tree-sitter-tree-sitter-* "${S}" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/lib64" install
}