# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="An efficient, principled regular expression library"
HOMEPAGE="https://github.com/google/re2"
SRC_URI="https://github.com/google/re2/tarball/1834cd0cb196b1c6f7225df97c0550cf00f7f8e2 -> re2-2022.12.01-1834cd0.tar.gz"

LICENSE="BSD"
# NOTE: Always run libre2 through abi-compliance-checker!
# https://abi-laboratory.pro/tracker/timeline/re2/

SLOT="0/10"
KEYWORDS="*"
IUSE="icu"

BDEPEND="icu? ( virtual/pkgconfig )"
DEPEND="icu? ( dev-libs/icu )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS CONTRIBUTORS README doc/syntax.txt )
HTML_DOCS=( doc/syntax.html )

post_src_unpack() {
	mv google-re2-* re2-2022.12.01
}

src_prepare() {
	default
	grep -q "^SONAME=10\$" Makefile || die "SONAME mismatch"
	if use icu; then
		sed -i -e 's:^# \(\(CC\|LD\)ICU=.*\):\1:' Makefile || die
	fi
}

src_configure() {
	tc-export AR CXX
}

src_compile() {
	emake SONAME="10" shared
}

src_install() {
	emake SONAME="10" DESTDIR="${D}" prefix="${EPREFIX}/usr" libdir="\$(exec_prefix)/$(get_libdir)" shared-install
}