# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit cmake vala

DESCRIPTION="Ayatana Application Indicators (Shared Library)"
HOMEPAGE="https://github.com/AyatanaIndicators/libayatana-appindicator"
SRC_URI="https://github.com/AyatanaIndicators/libayatana-appindicator/tarball/d214fe3e7a6b1ba8faea68d70586310b34dc643c -> libayatana-appindicator-0.5.92-d214fe3.tar.gz"

LICENSE="GPL-3 LGPL-2 LGPL-3"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	dev-libs/glib:2
x11-libs/gtk+:3[introspection]
	dev-libs/libdbusmenu[gtk3]
dev-libs/libayatana-indicator"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
"
S="${WORKDIR}/AyatanaIndicators-libayatana-appindicator-d214fe3"

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
		-DFLAVOUR_GTK3=ON
		-DENABLE_GTKDOC=OFF
		-DENABLE_BINDINGS_MONO=OFF
		-DFLAVOUR_GTK2=OFF
	)

	cmake_src_configure
}
