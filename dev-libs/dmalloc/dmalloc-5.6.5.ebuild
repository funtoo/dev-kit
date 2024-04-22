# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="A Debug Malloc Library"
HOMEPAGE="http://dmalloc.com"
SRC_URI="https://github.com/j256/dmalloc/tarball/cf4f98301a719a12bd39e51ac540d6ead4d970d4 -> dmalloc-5.6.5-cf4f983.tar.gz"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="threads"

DEPEND="sys-apps/texinfo"
RDEPEND=""

PATCHES=(
	"${FILESDIR}"/${PN}-5.6.5-add-destdir-support.patch
	"${FILESDIR}"/${PN}-5.6.5-allow-overriding-ar-and-ld.patch
	"${FILESDIR}"/${PN}-5.6.5-set-soname-version.patch
	"${FILESDIR}"/${PN}-5.6.5-configure-c99.patch
	"${FILESDIR}"/${PN}-5.6.5-fix-cxx-check.patch
)

post_src_unpack() {
	if [ ! -d "${WORKDIR}/${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	append-cflags $(test-flags-CC -fPIC)

	econf \
		--enable-cxx \
		--enable-shlib \
		$(use_enable threads)
}

src_install() {
	default

	soname_link() {
		dosym ${1}.so.${PV} /usr/$(get_libdir)/${1}.so.${PV%%.*}
		dosym ${1}.so.${PV%%.*} /usr/$(get_libdir)/${1}.so
	}

	soname_link libdmalloc
	soname_link libdmallocxx

	if use threads; then
		soname_link libdmallocth
		soname_link libdmallocthcxx
	fi

	rm "${ED}"/usr/$(get_libdir)/lib${PN}*.a || die
}