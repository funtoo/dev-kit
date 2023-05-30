# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools

DESCRIPTION="On-screen input pad to send characters with mouse"
HOMEPAGE="https://github.com/fujiwarat/input-pad/wiki"
SRC_URI="https://github.com/fujiwarat/input-pad/tarball/451db10570ef93b5d508653e9e0e471729453fb1 -> input-pad-1.0.99.20210817-451db10.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="eekboard +introspection static-libs xtest"

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxkbfile
	x11-libs/libxklavier
	virtual/libintl
	eekboard? ( dev-libs/eekboard )
	introspection? ( dev-libs/gobject-introspection )
	xtest? ( x11-libs/libXtst )"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/*-input-pad-* "${S}"
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable eekboard eek) \
		$(use_enable introspection) \
		$(use_enable static-libs static) \
		$(use_enable xtest)
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -delete || die
}
