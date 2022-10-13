# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="C library for the MaxMind DB file format."
HOMEPAGE="https://maxmind.github.io/libmaxminddb/"
SRC_URI="https://github.com/maxmind/libmaxminddb/tarball/ac4d0d2480032a8664e251588e57d7b306ca630c -> libmaxminddb-1.7.1-ac4d0d2.tar.gz"

KEYWORDS="*"

IUSE="static-libs"

LICENSE="Apache-2.0"
SLOT="0"

DOCS=( Changes.md )

post_src_unpack() {
	mv "${WORKDIR}"/* "${S}" || die
}

src_prepare() {
	default
	sh ${S}/bootstrap || die
	eautoreconf
}

src_configure() {
	# Tests need libtap, which we don't have.
	econf --disable-tests \
		$( use_enable static-libs static )
}