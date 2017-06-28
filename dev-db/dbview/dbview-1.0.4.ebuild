# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Dbview - view dBase files"
HOMEPAGE="http://www.infodrom.org/projects/dbview/"
SRC_URI="http://www.infodrom.org/projects/dbview/download/${P}.tar.gz"
LICENSE=""

SLOT="0"

KEYWORDS="~x86 amd64"

IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
