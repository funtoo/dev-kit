# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="https://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="1/${PV%.*}"
KEYWORDS="*"
IUSE="doc selinux static-libs +urandom valgrind"

DEPEND="elibc_glibc? ( >=sys-apps/util-linux-2.16 )"
RDEPEND="
	${DEPEND}
	selinux? ( sec-policy/selinux-base-policy )
"
DEPEND+=" valgrind? ( dev-util/valgrind )"
BDEPEND="
	>=sys-devel/libtool-2.4.2
	doc? ( app-doc/doxygen )
"

DOCS=( CHANGES NOTICE README )

PATCHES=(
	"${FILESDIR}"/${PN}-1.6.3-skip-known-failing-tests.patch
	"${FILESDIR}"/${PN}-1.7.2-libtool.patch
	"${FILESDIR}"/${PN}-1.7.2-sysroot.patch # bug #385775
	"${FILESDIR}"/${PN}-1.7.2-fix-pkgconfig-libs.patch
	"${FILESDIR}"/${PN}-1.7.2-respect-flags.patch
	"${FILESDIR}"/${PN}-1.7.2-autoconf-2.72.patch
	"${FILESDIR}"/config.layout.patch
)

src_prepare() {
	default

	mv configure.in configure.ac || die
	AT_M4DIR="build" eautoreconf
}

src_configure() {
	tc-export AS CC CPP

	local myconf=(
		--enable-layout=gentoo
		--enable-nonportable-atomics
		--enable-posix-shm
		--enable-threads
		$(use_enable static-libs static)
		$(use_with valgrind)
		--with-installbuilddir="${EPREFIX}"/usr/share/${PN}/build
	)

	tc-is-static-only && myconf+=( --disable-dso )

	if use urandom; then
		myconf+=( --with-devrandom=/dev/urandom )
	else
		myconf+=( --with-devrandom=/dev/random )
	fi
	econf "${myconf[@]}"
}

src_compile() {
	emake all $(usev doc dox)
}

src_test() {
	# Building tests in parallel is broken
	emake -j1 check
}

src_install() {
	default

	if ! use static-libs; then
		find "${ED}" -name '*.la' -delete || die
	fi

	if use doc; then
		docinto html
		dodoc -r docs/dox/html/*
	fi

	# This file is only used on AIX systems, which Gentoo is not,
	# and causes collisions between the SLOTs, so remove it.
	# Even in Prefix, we don't need this on AIX.
	rm "${ED}/usr/$(get_libdir)/apr.exp" || die
}
