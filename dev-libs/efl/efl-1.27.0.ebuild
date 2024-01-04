# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCS_DIR="${S}/doc"

PYTHON_COMPAT=( python3+ )

inherit meson python-any-r1 xdg-utils

DESCRIPTION="Enlightenment Foundation Libraries all-in-one package"
HOMEPAGE="https://www.enlightenment.org"
SRC_URI="https://download.enlightenment.org/rel/libs/efl/efl-1.27.0.tar.xz -> efl-1.27.0.tar.xz"

LICENSE="BSD-2 GPL-2 LGPL-2.1 ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+X avif bmp connman cpu_flags_arm_neon dds debug doc drm +eet efl-one elogind examples fbcon
	+fontconfig fribidi gif glib +gstreamer harfbuzz heif hyphen ibus ico
	jpeg2k jpegxl json lua +luajit nls mono opengl +pdf physics pmaps postscript psd pulseaudio raw scim
	sdl +sound +svg +system-lz4 tga tgv tiff tslib unwind v4l vnc wayland webp xcf
	xim xpm xpresent zeroconf"

REQUIRED_USE="
	?? ( elogind )
	?? ( fbcon tslib )
	^^ ( lua luajit )
	examples? ( eet svg )
	ibus? ( glib )
	opengl? ( X )
	pulseaudio? ( sound )
	xim? ( X )
	xpresent? ( X )"

# Requires everything to be enabled unconditionally.
RESTRICT="test"

RDEPEND="
	dev-libs/check
	net-misc/curl
	media-libs/giflib:=
	media-libs/libpng:0=
	sys-apps/dbus
	sys-libs/zlib
	virtual/jpeg:0=
	X? (
		!opengl? ( media-libs/mesa[egl(+),gles2] )
		dev-libs/libinput
		media-libs/freetype
		x11-libs/libX11
		x11-libs/libXScrnSaver
		x11-libs/libXcomposite
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXtst
		x11-libs/libxkbcommon
		wayland? ( x11-libs/libxkbcommon[X] )
	)
	avif? ( media-libs/libavif )
	connman? ( net-misc/connman )
	drm? (
		dev-libs/libinput
		dev-libs/wayland
		media-libs/mesa[gbm]
		x11-libs/libdrm
		x11-libs/libxkbcommon
	)
	elogind? (
		sys-auth/elogind
		virtual/libudev
	)
	fontconfig? ( media-libs/fontconfig )
	fribidi? ( dev-libs/fribidi )
	glib? ( dev-libs/glib:2 )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
	)
	harfbuzz? ( media-libs/harfbuzz:= )
	heif? ( media-libs/libheif )
	hyphen? ( dev-libs/hyphen )
	ibus? ( app-i18n/ibus )
	jpeg2k? ( media-libs/openjpeg:= )
	jpegxl? ( media-libs/libjxl )
	json? ( >=media-libs/rlottie-0.2 )
	lua? ( <dev-lang/lua-5.3[deprecated] )
	luajit? ( dev-lang/luajit:* )
	mono? ( dev-lang/mono )
	opengl? ( virtual/opengl )
	pdf? ( app-text/poppler:=[cxx] )
	physics? ( sci-physics/bullet:= )
	postscript? ( app-text/libspectre )
	pulseaudio? ( media-sound/pulseaudio )
	raw? ( media-libs/libraw:= )
	scim? ( app-i18n/scim )
	sdl? ( media-libs/libsdl2 )
	sound? ( media-libs/libsndfile )
	svg? ( gnome-base/librsvg )
	system-lz4? ( app-arch/lz4 )
	tiff? ( media-libs/tiff:0= )
	tslib? ( x11-libs/tslib:= )
	unwind? ( sys-libs/libunwind )
	v4l? ( media-libs/libv4l )
	vnc? ( net-libs/libvncserver )
	wayland? (
		dev-libs/wayland
		media-libs/mesa[gles2,wayland]
		x11-libs/libxkbcommon
	)
	webp? ( media-libs/libwebp:= )
	xpm? ( x11-libs/libXpm )
	xpresent? ( x11-libs/libXpresent )
	zeroconf? ( net-dns/avahi )"
DEPEND="${RDEPEND}
		X? ( x11-base/xorg-proto )
		wayland? ( dev-libs/wayland-protocols )"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	doc? (
		app-doc/doxygen
		dev-texlive/texlive-fontutils
	)"
		

pkg_setup() {
	# Deprecated, provided for backward-compatibility. Everything is moved to libefreet.so.
	QA_FLAGS_IGNORED="/usr/$(get_libdir)/libefreet_trash.so.1.26.1
		/usr/$(get_libdir)/libefreet_mime.so.1.26.1"
		
	# Get clean environment, see Gentoo bug #557408
	xdg_environment_reset
	python-any-r1_pkg_setup
}

src_unpack() {
	default
}

src_prepare() {
	default

	# Remove automagic unwind configure option, Gentoo bug #743154
	if ! use unwind; then
		sed -i "/config_h.set('HAVE_UNWIND/,/eina_ext_deps += unwind/d" src/lib/eina/meson.build ||
			die "Failed to remove libunwind dep"
	fi

	# Fixup Doxyfile
	pushd "${DOCS_DIR}" || die
	cp Doxyfile.in Doxyfile || die
	sed -i \
		-e "s/@PACKAGE_VERSION@/${PV}/g" \
		-e "s/@top_builddir@/../g" \
		-e "s/@top_srcdir@/../g" \
		-e "s/@srcdir@/./g" \
		Doxyfile || die
	popd || die

	# Fix python shebangs for python-exec[-native-symlinks], Gentoo bug #764086
	local shebangs=($(grep -rl "#!/usr/bin/env python3" || die))
	python_fix_shebang -q ${shebangs[*]}
}

src_configure() {
	local emesonargs=(
		--buildtype=release

		-D buffer=false
		-D build-tests=false
		-D cocoa=false
		-D drm-deprecated=false
		-D g-mainloop=false
		-D mono-beta=false
		-D dotnet=false
		-D pixman=false
		-D wl-deprecated=false

		-D edje-sound-and-video=true
		-D eeze=true
		-D input=true
		-D install-eo-files=true
		-D libmount=true
		-D native-arch-optimization=true
		-D xinput2=true
		-D xinput22=true

		-D crypto=openssl
		-D dotnet-stylecop-severity=Warning

		$(meson_use X x11)
		$(meson_use debug debug-threads)
		$(meson_use drm)
		$(meson_use examples build-examples)
		$(meson_use fbcon fb)
		$(meson_use fontconfig)
		$(meson_use fribidi)
		$(meson_use glib)
		$(meson_use gstreamer)
		$(meson_use harfbuzz)
		$(meson_use hyphen)
		$(meson_use luajit elua)
		$(meson_use nls)
		$(meson_use physics)
		$(meson_use pulseaudio)
		$(meson_use sdl)
		$(meson_use sound audio)
		$(meson_use tslib)
		$(meson_use v4l v4l2)
		$(meson_use vnc vnc-server)
		$(meson_use wayland wl)
		$(meson_use xpresent)
		$(meson_use zeroconf avahi)

		$(meson_use !system-lz4 embedded-lz4)
	)

	if use elogind; then
		emesonargs+=( -D systemd=true )
	else
		emesonargs+=( -D systemd=false )
	fi

	if use wayland; then
		emesonargs+=( -D opengl=es-egl )
	elif ! use wayland && use opengl; then
		emesonargs+=( -D opengl=full )
	elif ! use wayland && use X && ! use opengl; then
		emesonargs+=( -D opengl=es-egl )
	else
		emesonargs+=( -D opengl=none )
	fi

	if use connman; then
		emesonargs+=( -D network-backend=connman )
	else
		emesonargs+=( -D network-backend=none )
	fi

	local disabledEvasLoaders=""
	! use avif && disabledEvasLoaders="avif,"
	! use bmp && disabledEvasLoaders+="bmp,wbmp,"
	! use dds && disabledEvasLoaders+="dds,"
	! use eet && disabledEvasLoaders+="eet,"
	! use gstreamer && disabledEvasLoaders+="gst,"
	! use heif && disabledEvasLoaders+="heif,"
	! use ico && disabledEvasLoaders+="ico,"
	! use jpeg2k && disabledEvasLoaders+="jp2k,"
	! use jpegxl && disabledEvasLoaders+="jxl,"
	! use json && disabledEvasLoaders+="json,"
	! use pdf && disabledEvasLoaders+="pdf,"
	! use pmaps && disabledEvasLoaders+="pmaps,"
	! use postscript && disabledEvasLoaders+="ps,"
	! use psd && disabledEvasLoaders+="psd,"
	! use raw && disabledEvasLoaders+="raw,"
	! use svg && disabledEvasLoaders+="rsvg,svg,"
	! use tga && disabledEvasLoaders+="tga,"
	! use tgv && disabledEvasLoaders+="tgv,"
	! use tiff && disabledEvasLoaders+="tiff,"
	! use webp && disabledEvasLoaders+="webp,"
	! use xcf && disabledEvasLoaders+="xcf,"
	! use xpm && disabledEvasLoaders+="xpm,"
	[[ ! -z "$disabledEvasLoaders" ]] && disabledEvasLoaders=${disabledEvasLoaders::-1}
	emesonargs+=( -D evas-loaders-disabler="${disabledEvasLoaders}" )

	local disabledImfLoaders=""
	! use ibus && disabledImfLoaders+="ibus,"
	! use scim && disabledImfLoaders+="scim,"
	! use xim && disabledImfLoaders+="xim,"
	[[ ! -z "$disabledImfLoaders" ]] && disabledImfLoaders=${disabledImfLoaders::-1}
	emesonargs+=( -D ecore-imf-loaders-disabler="${disabledImfLoaders}" )

	local bindingsList="cxx,"
	use luajit && bindingsList+="lua,"
	use mono && bindingsList+="mono,"
	[[ ! -z "$bindingsList" ]] && bindingsList=${bindingsList::-1}
	emesonargs+=( -D bindings="${bindingsList}" )

	local luaChoice=""
	if use luajit; then
		luaChoice+="luajit"
	else
		luaChoice+="lua"
	fi
	emesonargs+=( -D lua-interpreter="${luaChoice}" )

	# Not all arm CPU's have neon instruction set, Gentoo bug #722552
	if use arm && ! use cpu_flags_arm_neon; then
		emesonargs+=( -D native-arch-optimization=false )
	fi

	meson_src_configure
}

docs_compile() {
	# Shamelessly ripped from gentoo's docs.eclass and slightly modified for our purposes
	use doc || return

	local doxyfile="${DOCS_DIR}/Doxyfile"
	[[ -f ${doxyfile} ]] || die "${doxyfile} not found"

	local docs_outdir="${S}/_build/html"
	# doxygen wants the HTML_OUTPUT dir to already exist
	mkdir -p "${docs_outdir}" || die

	pushd "${DOCS_DIR}" || die
	(cat Doxyfile ; echo "HTML_OUTPUT=${docs_outdir}") | doxygen - || die "doxygen failed"
	popd || die
	
	HTML_DOCS+=( "${docs_outdir}/." )
}

src_compile() {
	docs_compile
	meson_src_compile
}

src_install() {
	meson_src_install
	einstalldocs
	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples/
		dodoc -r "${BUILD_DIR}"/src/examples/
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}