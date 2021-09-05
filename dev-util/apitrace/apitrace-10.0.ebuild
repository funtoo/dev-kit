# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit cmake-utils python-single-r1

DESCRIPTION="Tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT !system-snappy? ( BSD CC-BY-3.0 CC-BY-4.0 public-domain )" #bundled snappy
SLOT="0"
KEYWORDS="*"
IUSE="+cli egl qt5 system-snappy"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	app-arch/brotli:=
	media-libs/libpng:0=
	media-libs/mesa[egl?]
	sys-libs/zlib
	sys-process/procps:=
	x11-libs/libX11
	egl? (
		>=media-libs/mesa-8.0[gles1,gles2]
		media-libs/waffle[egl]
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[-gles2-only]
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5[-gles2-only]
	)
	system-snappy? ( >=app-arch/snappy-1.1.1 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {    
	if use qt5; then
		export QT_MIN_VERSION=5.3.0
	fi
	
	python_setup 'python3*'
	
	CMAKE_BUILD_TYPE=RelWithDebInfo \
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1.2
	
	rm docs/INSTALL.markdown || die
	dodoc docs/* README.markdown
	
	exeinto /usr/$(get_libdir)/${PN}/scripts
	doexe $(find scripts -type f -executable)
}
