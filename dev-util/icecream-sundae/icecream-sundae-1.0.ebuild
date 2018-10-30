# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 meson ninja-utils user

DESCRIPTION="Icecream distributed compiler console-based monitor program."
HOMEPAGE="https://github.com/JPEWdev/icecream-sundae"
EGIT_REPO_URI="https://github.com/JPEWdev/icecream-sundae.git"
EGIT_COMMIT="b2eabed" 
# Commit b2eabed is upstream's v1.0 with a small spelling fix merged.


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/glib
	sys-devel/icecream
	sys-libs/ncurses
"
RDEPEND="
	${DEPEND}
"

src_configure () {
	local emesonargs=(
		--buildtype=release
	)
	meson_src_configure
}

src_compile () {
	cd ${WORKDIR}/${P}-build || die
	eninja
}

src_install() {
	cd ${WORKDIR}/${P}-build || die
	DESTDIR="${D}" eninja install
	find "${D}" -name '*.la' -delete || die
}
