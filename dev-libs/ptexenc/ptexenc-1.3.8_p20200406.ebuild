# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit libtool

DESCRIPTION="Library for Japanese pTeX providing a better way of handling character encodings"
HOMEPAGE="http://tutimura.ath.cx/ptexlive/?ptexenc"
SRC_URI="mirror://gentoo/texlive-${PV#*_p}-source.tar.xz"
# http://tutimura.ath.cx/~nob/tex/ptexlive/ptexenc/${P}.tar.xz

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="iconv static-libs"

DEPEND="iconv? ( virtual/libiconv )
	dev-libs/kpathsea"
RDEPEND="${DEPEND}"

S=${WORKDIR}/texlive-${PV#*_p}-source/texk/${PN}

src_prepare() {
	default

	# https://bugs.gentoo.org/show_bug.cgi?id=377141
	sed -i '/^LIBS/s:@LIBS@:@LIBS@ @KPATHSEA_LIBS@:' "${S}"/Makefile.in || die

	cd "${WORKDIR}/texlive-${PV#*_p}-source"
	S="${WORKDIR}/texlive-${PV#*_p}-source" elibtoolize #sane .so versionning on gfbsd
}

src_configure() {
	econf \
		--with-system-kpathsea \
		$(use_enable static-libs static) \
		$(use_enable iconv kanji-iconv)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die

	insinto /usr/include/ptexenc
	doins ptexenc/unicode-jp.h
	use iconv && doins ptexenc/kanjicnv.h

	dodoc ChangeLog README
}
