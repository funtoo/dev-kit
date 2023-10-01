# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3+ )

inherit toolchain-funcs

DESCRIPTION="C++ class library of cryptographic schemes"
HOMEPAGE="https://cryptopp.com"
SRC_URI="https://github.com/weidai11/cryptopp/tarball/041cf66ed64f28d89cc50b762cde0353cf85657c -> cryptopp-8.9.0-041cf66.tar.gz"
LICENSE="BSL-1.0"
SLOT="0"
KEYWORDS="*"
IUSE="+asm static-libs"

S=${WORKDIR}/weidai11-cryptopp-041cf66

BDEPEND="
	app-arch/unzip
"

config_uncomment() {
	sed -i -e "s://\s*\(#define\s*$1\):\1:" config.h || die
}

src_prepare() {
	default

	use asm || config_uncomment CRYPTOPP_DISABLE_ASM

	# ASM isn't Darwin/Mach-O ready, #479554, buildsys doesn't grok CPPFLAGS
	[[ ${CHOST} == *-darwin* ]] && config_uncomment CRYPTOPP_DISABLE_ASM
}

src_configure() {
	export CXX="$(tc-getCXX)"
	export LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	export PREFIX="${EPREFIX}/usr"
	tc-export AR RANLIB
	default
}

src_compile() {
	emake -f GNUmakefile all shared libcryptopp.pc
}

src_install() {
	default

	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/*.a
}