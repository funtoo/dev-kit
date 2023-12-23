# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools multilib-minimal

SRC_URI="https://github.com/sass/libsass/tarball/7037f03fabeb2b18b5efa84403f5a6d7a990f460 -> libsass-3.6.6-7037f03.tar.gz"

DESCRIPTION="A C/C++ implementation of a Sass compiler"
HOMEPAGE="https://github.com/sass/libsass"
LICENSE="MIT"
SLOT="0/1" # libsass soname
IUSE="static-libs"
KEYWORDS="*"

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=( Readme.md SECURITY.md )

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv sass-libsass* "${S}" || die
	fi
}

src_prepare() {
	default

	[[ -f VERSION ]] || echo "${PV}" > VERSION
	eautoreconf

	# only sane way to deal with various version-related scripts, env variables etc.
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-shared
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	find "${D}" -name '*.la' -delete || die
}

multilib_src_install_all() {
	einstalldocs
	dodoc -r "${S}/docs"
}