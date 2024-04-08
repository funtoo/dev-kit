# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit cmake vala

DESCRIPTION="Ayatana Application Indicators (Shared Library)"
HOMEPAGE="https://github.com/AyatanaIndicators/ayatana-ido"
SRC_URI="https://github.com/AyatanaIndicators/ayatana-ido/tarball/2bb2f321c64b903b6e4b5c581d79602632c851c5 -> ayatana-ido-0.10.2-2bb2f32.tar.gz"

LICENSE="GPL-3 LGPL-2 LGPL-3"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	dev-libs/glib:2
x11-libs/gtk+:3[introspection]
	"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
"
S="${WORKDIR}/AyatanaIndicators-ayatana-ido-2bb2f32"

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
	)

	cmake_src_configure
}
