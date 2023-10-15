# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit cmake vala

DESCRIPTION="Ayatana Application Indicators (Shared Library)"
HOMEPAGE="https://github.com/AyatanaIndicators/libayatana-indicator"
SRC_URI="https://github.com/AyatanaIndicators/libayatana-indicator/tarball/611bb384b73fa6311777ba4c41381a06f5b99dad -> libayatana-indicator-0.9.4-611bb38.tar.gz"

LICENSE="GPL-3 LGPL-2 LGPL-3"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	dev-libs/glib:2
x11-libs/gtk+:3[introspection]
	dev-libs/ayatana-ido
dev-libs/dbus-glib"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
"
S="${WORKDIR}/AyatanaIndicators-libayatana-indicator-611bb38"

src_prepare() {
	default

	cmake_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs+=(
		-DVALA_COMPILER="${VALAC}"
		-DVAPI_GEN="${VAPIGEN}"
		-DENABLE_TESTS=OFF
		-DENABLE_IDO=ON
		-DENABLE_LOADER=ON
		-DFLAVOUR_GTK2=OFF
		-DFLAVOUR_GTK3=ON
	)

	cmake_src_configure
}
