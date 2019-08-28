# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

WX_GTK_VER="3.0"

inherit autotools eutils multilib wxwidgets

DESCRIPTION="C++ wrapper around the public domain SQLite 3.x database"
HOMEPAGE="http://utelle.github.io/wxsqlite3"
SRC_URI="https://github.com/utelle/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="
	x11-libs/wxGTK:${WX_GTK_VER}[X]
	dev-db/sqlite:3
    doc? ( 
        app-doc/doxygen[dot]
    )"

DEPEND="${RDEPEND}"

DOCS=( readme.md )

pkg_setup() {
    setup-wxwidgets
}

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    local myeconfargs=(
        --prefix="${EPREFIX}/usr"
		--enable-shared
		--with-wx-config="${WX_CONFIG}"
	)
    default
}

src_compile() {
    default
    if use doc; then
        pushd docs
        doxygen Doxyfile || die
        popd
    fi
}

src_install() {
    default
	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc

    if use doc; then
        dohtml -r docs/html/*
    fi
}
