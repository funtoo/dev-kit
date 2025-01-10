# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="C library for the MaxMind DB file format."
HOMEPAGE="https://maxmind.github.io/libmaxminddb/"
SRC_URI="https://github.com/maxmind/libmaxminddb/tarball/0ff5a5bfb3bc8f7da1e1d1a7c3398b9d3fcf7493 -> libmaxminddb-1.12.1-0ff5a5b.tar.gz"

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