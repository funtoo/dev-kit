# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Blocking, shuffling and lossless compression library"
HOMEPAGE="https://www.blosc.org/"
SRC_URI="https://api.github.com/repos/Blosc/c-blosc/tarball/v1.21.6 -> c-blosc-1.21.6.tar.gz"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="*"
IUSE="+lz4 +snappy test zlib zstd"
RESTRICT="!test? ( test )"

RDEPEND="
	lz4? ( >=app-arch/lz4-1.7.5:= )
	snappy? ( app-arch/snappy )
	zlib? ( sys-libs/zlib )
	zstd? ( app-arch/zstd )"
DEPEND="${RDEPEND}"

src_unpack() {
	default
	rm -rf "${S}"
	mv "${WORKDIR}"/Blosc-c-blosc-* "${S}" || die
}

src_prepare() {
	cmake_src_prepare
	# remove bundled libs
	rm -rf internal-complibs || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC=OFF
		-DBUILD_TESTS=$(usex test)
		-DBUILD_BENCHMARKS=OFF
		-DBUILD_FUZZERS=OFF
		-DDEACTIVATE_LZ4=$(usex !lz4)
		-DDEACTIVATE_SNAPPY=$(usex !snappy)
		-DDEACTIVATE_ZLIB=$(usex !zlib)
		-DDEACTIVATE_ZSTD=$(usex !zstd)
		-DPREFER_EXTERNAL_LZ4=ON
		# snappy is always external
		-DPREFER_EXTERNAL_ZLIB=ON
		-DPREFER_EXTERNAL_ZSTD=ON
	)
	cmake_src_configure
}