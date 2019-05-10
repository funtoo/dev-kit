# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=0

DESCRIPTION="Generate C function prototypes from C source code"
HOMEPAGE="https://invisible-island.net/cproto/"
SRC_URI="ftp://ftp.invisible-island.net/cproto//${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="sys-devel/flex
	virtual/yacc"
RDEPEND=""

S=${WORKDIR}/${P/./_}

src_install() {
	dobin cproto || die
	doman cproto.1
	dodoc README CHANGES
}
