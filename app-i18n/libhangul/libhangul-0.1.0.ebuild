# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Library for hangul input method logic, hanja dictionary"
HOMEPAGE="https://github.com/libhangul/libhangul"
SRC_URI="https://api.github.com/repos/libhangul/libhangul/tarball/refs/tags/libhangul-0.1.0 -> libhangul-0.1.0.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0/1"
KEYWORDS="*"
IUSE="+nls static-libs"

BDEPEND="virtual/pkgconfig
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/libiconv
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/"${PN}"-* "${S}"
}

src_prepare() {
	default
	./autogen.sh
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable static-libs static)

	cp $(type -p gettextize) "${T}"/ || die
	sed -i -e 's:read dummy < /dev/tty::' "${T}/gettextize" || die
	"${T}"/gettextize -f --no-changelog > /dev/null || die
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}