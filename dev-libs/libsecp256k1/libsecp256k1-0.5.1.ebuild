# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Optimized C library for EC operations on curve secp256k1"
HOMEPAGE="https://github.com/bitcoin-core/secp256k1"
SRC_URI="https://github.com/bitcoin-core/secp256k1/tarball/ed4c4ad548e798b8612e01cf80770053f51f15b5 -> secp256k1-0.5.1-ed4c4ad.tar.gz"

LICENSE="MIT"
SLOT="0/1"  # subslot is "$((_LIB_VERSION_CURRENT-_LIB_VERSION_AGE))" from configure.ac
KEYWORDS="*"
IUSE="+asm +ecdh experimental +extrakeys lowmem +recovery +schnorr test valgrind"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	asm? ( || ( amd64 arm ) arm? ( experimental ) )
	schnorr? ( extrakeys )
"
BDEPEND="
	sys-devel/autoconf-archive
	virtual/pkgconfig
	valgrind? ( dev-util/valgrind )
"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/bitcoin-core-secp256k1* "${S}" || die
	fi
}

src_prepare() {
	default
	eautoreconf

	# Generate during build
	rm -f src/precomputed_ecmult.c src/precomputed_ecmult_gen.c || die
}

src_configure() {
	local myeconfargs=(
		--disable-benchmark
		$(use_enable experimental)
		$(use_enable test tests)
		$(use_enable test exhaustive-tests)
		$(use_enable {,module-}ecdh)
		$(use_enable {,module-}extrakeys)
		$(use_enable {,module-}recovery)
		$(use_enable schnorr module-schnorrsig)
		$(usev lowmem '--with-ecmult-window=4 --with-ecmult-gen-precision=2')
		$(use_with valgrind)
	)
	if use asm; then
		if use arm; then
			myeconfargs+=( --with-asm=arm )
		else
			myeconfargs+=( --with-asm=auto )
		fi
	else
		myeconfargs+=( --with-asm=no )
	fi

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}