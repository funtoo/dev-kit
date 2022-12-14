# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit toolchain-funcs

DESCRIPTION="libspnav is a replacement for the magellan library with a cleaner API"
HOMEPAGE="http://spacenav.sourceforge.net/"
SRC_URI="https://api.github.com/repos/FreeSpacenav/libspnav/tarball/v1.1 -> libspnav-1.1.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs X"

CDEPEND="X? ( x11-libs/libX11 )"
RDEPEND="app-misc/spacenavd[X?]
	${CDEPEND}"
DEPEND="${CDEPEND}"

src_unpack() {
	default
	rm -rf "${S}"
	mv "${WORKDIR}"/FreeSpacenav-libspnav-* "${S}" || die
}

src_prepare() {
	eapply_user
}

src_configure() {
	local args=(
		--disable-opt
		--disable-debug
		$(use_enable X x11)
	)
	econf "${args[@]}"
}

src_compile() {
	emake AR="$(tc-getAR)" CC="$(tc-getCC)"
}

src_install() {
	local args=(
		DESTDIR="${D}"
		libdir="$(get_libdir)"
	)
	emake "${args[@]}" install

	# The custom configure script does not support --disable-static
	# and conditionally patching $(lib_a) out of Makefile.in does not
	# seem like a very maintainable option, hence we delete the .a file
	# after "make install", instead.
	use static-libs || find "${D}" -type f -name \*.a -delete
}