# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit meson python-any-r1 xdg

DESCRIPTION="Library to help create and query binary XML blobs"
HOMEPAGE="https://github.com/hughsie/libxmlb"
SRC_URI="https://github.com/hughsie/libxmlb/tarball/4393955fb7c8bbcb6a2c65ff54f16c39dc165e59 -> libxmlb-0.3.19-4393955.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0/2" # libxmlb.so version

KEYWORDS="*"
IUSE="doc introspection stemmer test"

RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/xz-utils
	dev-libs/glib:2
	sys-apps/util-linux
	stemmer? ( dev-libs/snowball-stemmer:= )
"

DEPEND="
	${RDEPEND}
	doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
"

BDEPEND="
	${PYTHON_DEPS}
	>=dev-util/meson-0.47.0
	virtual/pkgconfig
	introspection? (
		$(python_gen_any_dep 'dev-python/setuptools[${PYTHON_USEDEP}]')
	)
"

python_check_deps() {
	has_version -b "dev-python/setuptools[${PYTHON_USEDEP}]"
}

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/hughsie-libxmlb-* "${S}" || die
	fi
}

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	local emesonargs=(
		$(meson_use doc gtkdoc)
		$(meson_use introspection)
		$(meson_use stemmer)
		$(meson_use test tests)
	)
	meson_src_configure
}