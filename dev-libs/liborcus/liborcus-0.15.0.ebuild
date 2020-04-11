# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit python-single-r1

DESCRIPTION="Standalone file import filter library for spreadsheet documents"
HOMEPAGE="https://gitlab.com/orcus/orcus/blob/master/README.md"
SRC_URI="https://kohei.us/files/orcus/src/${P}.tar.xz"
KEYWORDS="*"
LICENSE="MIT"
SLOT="0/0.15" # based on SONAME of liborcus.so
IUSE="python +spreadsheet-model static-libs tools"

RDEPEND="
	dev-libs/boost:=
	sys-libs/zlib
	python? ( ${PYTHON_DEPS} )
	spreadsheet-model? ( >=dev-libs/libixion-0.14.0:= )
"
DEPEND="${RDEPEND}
	dev-util/mdds:1.5
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
}

src_configure() {
	econf \
		--disable-werror \
		$(use_enable python) \
		$(use_enable spreadsheet-model) \
		$(use_enable static-libs static) \
		$(use_with tools)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
