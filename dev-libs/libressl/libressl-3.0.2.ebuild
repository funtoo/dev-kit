# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libtool

DESCRIPTION="Free version of the SSL/TLS protocol forked from OpenSSL"
HOMEPAGE="https://www.libressl.org/"
SRC_URI="https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${P}.tar.gz"

LICENSE="ISC openssl"
# Reflects ABI of libcrypto.so and libssl.so.  Since these can differ,
# we'll try to use the max of either.  However, if either change between
# versions, we have to change the subslot to trigger rebuild of consumers.
SLOT="0/47"
KEYWORDS=""
IUSE="+asm static-libs test"
REQUIRED_USE="test? ( static-libs )"

RDEPEND=""
DEPEND="${RDEPEND}"
PDEPEND="app-misc/ca-certificates"

src_prepare() {
	touch crypto/Makefile.in

	sed -i \
		-e '/^[ \t]*CFLAGS=/s#-g ##' \
		-e '/^[ \t]*CFLAGS=/s#-g"#"#' \
		-e '/^[ \t]*CFLAGS=/s#-O2 ##' \
		-e '/^[ \t]*CFLAGS=/s#-O2"#"#' \
		-e '/^[ \t]*USER_CFLAGS=/s#-O2 ##' \
		-e '/^[ \t]*USER_CFLAGS=/s#-O2"#"#' \
		configure || die "fixing CFLAGS failed"

	if ! use test ; then
	sed -i \
		-e '/^[ \t]*SUBDIRS =/s#tests##' \
		Makefile.in || die "Removing tests failed"
	fi

	# eapply "${FILESDIR}"/${P}-non-glibc.patch
	eapply_user
}

src_configure() {
	econf \
		--prefix=/usr \
		--with-openssldir=/etc/libressl \
		--libdir=/usr/lib/libressl \
		--includedir=/usr/include/libressl \
		--program-prefix "libressl-"
}

src_install() {
	default

	# Remove symlink man pages, that actually points to OpenSSL
	# ones since the prefix is not accounted for
	for manlink in $(find -L "${D}"usr/share/man/man3/ -type l) ;
	do
		einfo "Removing ${manlink}..." ;
		rm "${manlink}" || die "Failed to remove ${manlink}";
	done
}
