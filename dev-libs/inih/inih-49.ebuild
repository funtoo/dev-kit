# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson ninja-utils

DESCRIPTION="Simple .INI file parser for C/C++"
HOMEPAGE="https://github.com/benhoyt/inih"

SRC_URI="https://github.com/benhoyt/inih/archive/r${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="*"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-r${PV}"

src_configure() {
	local emesonargs=(
		-Ddistro_install=true
		-Dwith_INIReader=true
		--default-library=shared
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
