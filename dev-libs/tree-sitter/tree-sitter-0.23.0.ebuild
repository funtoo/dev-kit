# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tree-sitter is a parser generator tool and an incremental parsing library."
HOMEPAGE="https://github.com/tree-sitter/tree-sitter"

SRC_URI="https://api.github.com/repos/tree-sitter/tree-sitter/tarball/v0.23.0 -> tree-sitter-0.23.0.tar.gz"
KEYWORDS="*"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/tree-sitter-tree-sitter-* "${S}" || die
}

src_prepare() {
	sed -i 's@all: libtree-sitter.a libtree-sitter.$(SOEXTVER)@all: libtree-sitter.$(SOEXTVER)@' Makefile  || die
	sed -i '/install -m\(644\|755\) libtree-sitter\.a '\''\$(DESTDIR)\$(LIBDIR)'\''/d' Makefile  || die
	default
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/lib64" install
}