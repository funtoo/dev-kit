# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${P%.*}-${P##*.}"
DESCRIPTION="A library of curses widgets"
HOMEPAGE="https://dickey.his.com/cdk/cdk.html https://github.com/ThomasDickey/cdk-snapshots"
SRC_URI="https://invisible-mirror.net/archives/cdk/cdk-5.0-20240619.tgz -> cdk-5.0-20240619.tgz"
S="${WORKDIR}"/${MY_P}

LICENSE="MIT"
SLOT="0/6" # subslot = soname version
KEYWORDS="*"
IUSE="examples unicode"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	if [[ ${CHOST} == *-*-darwin* ]] ; then
		export ac_cv_prog_LIBTOOL=glibtool
	fi

	# --with-libtool dropped for now because of broken Makefile
	# bug #790773
	econf \
		--disable-rpath-hack \
		--with-shared \
		--with-pkg-config \
		--with-ncurses$(usex unicode "w" "")
}

src_install() {
	# parallel make installs duplicate libs
	emake -j1 \
		DESTDIR="${D}" \
		DOCUMENT_DIR="${ED}/usr/share/doc/${PF}" \
		install

	if use examples ; then
		local x
		for x in include c++ demos examples cli cli/utils cli/samples ; do
			docinto ${x}
			find ${x} -maxdepth 1 -mindepth 1 -type f -print0 | xargs -0 dodoc || die
		done
	fi

	find "${ED}" \( -name '*.a' -or -name '*.la' \) -delete || die
}