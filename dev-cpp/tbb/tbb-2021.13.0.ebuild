# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="High level abstract threading library"
HOMEPAGE="https://www.threadingbuildingblocks.org"
SRC_URI="https://api.github.com/repos/oneapi-src/oneTBB/tarball/v2021.13.0 -> tbb-2021.13.0.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="*"
IUSE="hwloc tests valgrind"

REQUIRED_USE="tests? ( ^^ ( hwloc valgrind ) )"

DEPEND="
	hwloc? ( || (
		=sys-apps/hwloc-1.11*
		=sys-apps/hwloc-2.0*
		=sys-apps/hwloc-2.4*
	) )
	valgrind? ( dev-util/valgrind )
"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	rm -rf "${S}"
	mv "${WORKDIR}"/oneapi-src-oneTBB-* "${S}" || die
}

src_configure() {
	local mycmakeargs=(
		-DTBB_TEST=$(usex tests ON OFF)
		-DTBB_VALGRIND_MEMCHECK=$(usex valgrind ON OFF)
		-DTBBBIND_BUILD=$(usex hwloc ON OFF)
	)
	if use hwloc ; then
		has_version =sys-apps/hwloc-1.11* && HWLOC_VERSION='1_11'
		has_version =sys-apps/hwloc-2.0* && HWLOC_VERSION='2'
		has_version =sys-apps/hwloc-2.4* && HWLOC_VERSION='2_4'
		[[ -n "${HWLOC_VERSION}" ]] && mycmakeargs+=(
			"-DCMAKE_HWLOC_${HWLOC_VERSION}_LIBRARY_PATH=${EROOT}/usr/$(get_libdir)/libhwloc.so"
			"-DCMAKE_HWLOC_${HWLOC_VERSION}_INCLUDE_PATH=${EROOT}/usr/include/"
		)
	fi

	cmake_src_configure "${mycmakeargs[@]}"
}