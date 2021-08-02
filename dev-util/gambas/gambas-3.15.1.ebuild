# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools desktop eutils gnome2-utils xdg-utils

SLOT="3"
MY_PN="${PN}${SLOT}"

DESCRIPTION="A free development environment based on a Basic interpreter"
HOMEPAGE="http://gambas.sourceforge.net"

SRC_URI="https://gitlab.com/gambas/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="*"

IUSE="+curl +net +qt5 +x11
	bzip2 cairo crypt dbus examples gmp gnome gsl gstreamer gtk2 gtk3 httpd image-imlib image-io jit libxml mime
	mysql ncurses odbc openal opengl openssl pcre pdf pop3 postgres sdl sdl-sound sdl2 sqlite v4l xml zlib"

# gambas3 have the only one gui. it is based on qt5.
# these use flags (modules/plugins) require this qt5 gui to be present at the system to work properly:
# cairo gnome gstreamer gtk2 gtk3 imageimlib imageio opengl pdf sdl sdl2 v4l

REQUIRED_USE="
	cairo? ( qt5 x11 )
	gnome? ( qt5 x11 )
	gstreamer? ( qt5 x11 )
	gtk2? ( qt5 x11 )
	gtk3? ( qt5 x11 )
	image-imlib? ( qt5 x11 )
	image-io? ( qt5 x11 )
	net? (
		curl
		pop3? ( mime ) 
	)
	opengl? ( qt5 x11 )
	pdf? ( qt5 x11 )
	qt5? ( x11 )
	sdl? ( qt5 x11 )
	sdl-sound? ( sdl )
	sdl2? ( qt5 x11 )
	v4l? ( qt5 x11 )
"

RDEPEND="
	bzip2? ( app-arch/bzip2 )
	cairo? ( x11-libs/cairo )
	curl? ( net-misc/curl )
	dbus? ( sys-apps/dbus )
	gnome? ( gnome-base/gnome-keyring )
	gmp? ( dev-libs/gmp )
	gsl? ( sci-libs/gsl )
	gstreamer? (
		media-libs/gst-plugins-base
		media-libs/gstreamer
	)
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	jit? ( sys-devel/llvm:= )
	image-imlib? ( media-libs/imlib2 )
	image-io? (
		dev-libs/glib
		x11-libs/gdk-pixbuf
	)
	libxml? ( dev-libs/libxml2 )
	mime? ( dev-libs/gmime:3.0 )
	mysql?  ( virtual/mysql )
	ncurses? ( sys-libs/ncurses )
	odbc? ( dev-db/unixODBC )
	openal? ( media-libs/openal )
	opengl? ( media-libs/mesa )
	openssl? ( dev-libs/openssl )
	pcre? ( dev-libs/libpcre )
	pdf? ( app-text/poppler )
	postgres? ( dev-db/postgresql )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtopengl:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsvg:5
		dev-qt/qtwebkit:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
		dev-qt/qtxml:5
	)
	sdl? (
		media-libs/libsdl[opengl]
		media-libs/sdl-image
		media-libs/sdl-ttf
	)
	sdl-sound? ( media-libs/sdl-mixer )
	sdl2? (
		media-libs/libsdl2
		media-libs/sdl2-image
		media-libs/sdl2-mixer
	)
	v4l? (
		virtual/jpeg:0
		media-libs/libpng
	)
	x11? (
		x11-libs/libX11
		x11-libs/libXtst
	)
	xml? (
		dev-libs/libxml2
		dev-libs/libxslt
	)
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	virtual/libintl"

PATCHES=(
	"${FILESDIR}/${PN}-3.13.x-xdgutils.patch"
)

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	default
	eaclocal
	eautoreconf
}

src_configure() {
	econf $(use_enable bzip2 bzlib2) \
		$(use_enable cairo) \
		$(use_enable crypt) \
		$(use_enable curl) \
		$(use_enable dbus) \
		$(use_enable examples) \
		$(use_enable gmp) \
		$(use_enable gnome keyring) \
		$(use_enable gsl) \
		$(use_enable gstreamer media) \
		$(use_enable gtk2) \
		$(use_enable gtk3) \
		$(use_enable httpd) \
		$(use_enable image-imlib imageimlib) \
		$(use_enable image-io imageio) \
		$(use_enable jit) \
		$(use_enable libxml) \
		$(use_enable mime) \
		$(use_enable mysql) \
		$(use_enable ncurses) \
		$(use_enable net) \
		$(use_enable odbc) \
		$(use_enable openal) \
		$(use_enable opengl) \
		$(use_enable openssl) \
		$(use_enable pcre) \
		$(use_enable pdf poppler) \
		$(use_enable postgres postgresql) \
		$(use_enable qt5) \
		$(use_enable sdl) \
		$(use_enable sdl-sound sdlsound) \
		$(use_enable sdl2) \
		$(use_enable sqlite sqlite3) \
		$(use_enable v4l) \
		$(use_enable x11) \
		$(use_enable xml) \
		$(use_enable zlib) \
		--disable-pdf \
		--disable-qt4 \
		--disable-sqlite2
}

src_install() {
	emake DESTDIR="${ED}" install

	einstalldocs

	if use net ; then
		newdoc gb.net/src/doc/README gb.net-README
		newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog
	fi

	if use pcre ; then
		newdoc gb.pcre/src/README gb.pcre-README
	fi

	if use qt5 ; then
		doicon "${S}/app/desktop/${MY_PN}.svg"
		domenu "${S}/app/desktop/${MY_PN}.desktop"

		doicon -s 64 -c mimetypes \
			"${S}/app/mime/application-x-gambasscript.png" \
			"${S}/app/mime/application-x-gambasserverpage.png" \
			"${S}/main/mime/application-x-gambas3.png"

		insinto /usr/share/mime/application
		doins "${S}/app/mime/application-x-gambasscript.xml" \
			"${S}/app/mime/application-x-gambasserverpage.xml" \
			"${S}/main/mime/application-x-gambas3.xml"
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	use qt5 && xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	use qt5 && xdg_icon_cache_update
}
