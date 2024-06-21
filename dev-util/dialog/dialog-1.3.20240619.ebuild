# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=${PN}-$(ver_rs 2 -)
S="${WORKDIR}"/${MY_P}
DESCRIPTION="Tool to display dialog boxes from a shell"
HOMEPAGE="https://invisible-island.net/dialog/"
SRC_URI="https://invisible-mirror.net/archives/dialog/dialog-1.3-20240619.tgz -> dialog-1.3-20240619.tgz"

LICENSE="LGPL-2.1"
SLOT="0/15"
KEYWORDS="*"
IUSE="examples minimal nls unicode"

RDEPEND="sys-libs/ncurses"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"
BDEPEND="
	virtual/pkgconfig
	!minimal? ( sys-devel/libtool )
"

src_prepare() {
	default

	sed -i -e '/LIB_CREATE=/s:${CC}:& ${LDFLAGS}:g' configure || die
	sed -i '/$(LIBTOOL_COMPILE)/s:$: $(LIBTOOL_OPTS):' makefile.in || die
}

src_configure() {
	if [[ ${CHOST} == *-darwin* ]] ; then
		export ac_cv_prog_LIBTOOL=glibtool
	fi

	econf \
		--disable-rpath-hack \
		--with-pkg-config \
		--enable-pc-files \
		$(use_enable nls) \
		$(use_with !minimal libtool) \
		--with-libtool-opts='-shared' \
		--with-ncurses$(usev unicode w)

	sed -i "s:\(-lncurses\):\1 -ltinfo:" makefile
}

src_install() {
	use minimal && default || emake DESTDIR="${D}" install-full

	use examples && dodoc -r samples

	dodoc CHANGES README

	find "${ED}" -name '*.la' -delete || die
}