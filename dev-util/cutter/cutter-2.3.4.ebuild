# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit qmake-utils xdg-utils python-single-r1

DESCRIPTION="A Qt and C++ GUI for radare2 reverse engineering framework"
HOMEPAGE="https://cutter.re https://github.com/rizinorg/cutter/"
SRC_URI="https://github.com/rizinorg/cutter/archive/v2.3.4.tar.gz -> cutter-2.3.4.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-util/radare2
"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.10.3-python3-config.patch"
)

src_configure() {
	local myqmakeargs=(
		CUTTER_ENABLE_PYTHON=true
		PREFIX=\'${EPREFIX}/usr\'
	)

	eqmake5 "${myqmakeargs[@]}" src
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
