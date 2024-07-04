# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Library routines related to building,parsing and iterating BSON documents"
HOMEPAGE="https://github.com/mongodb/mongo-c-driver/tree/master/src/libbson"
SRC_URI="https://github.com/mongodb/mongo-c-driver/tarball/45ff1625a2543bcd293b27749b92d3f0dfe09fe7 -> mongo-c-driver-1.27.4-45ff162.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="examples static-libs"

DEPEND="dev-python/sphinx"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}

src_prepare() {
	cmake_src_prepare

	# remove doc files
	sed -i '/^\s*install\s*(FILES COPYING NEWS/,/^\s*)/ {d}' CMakeLists.txt || die

	sed -i -e 's|${PROJECT_SOURCE_DIR}/src/bson/bcon.h|${PROJECT_SOURCE_DIR}/src/bson/bcon.h\n   $\{PROJECT_SOURCE_DIR\}/../common/bson-dsl.h|g' \
	src/libbson/CMakeLists.txt || die

	# It seems that the docs python script using py3.10 syntax but
	# the library works with py3.9 too.
	sed -i -e 's/str | None/str/g' build/sphinx/mongoc_common.py || die

	# Override upstream script using git to retrieve tag.
	echo "#!/usr/bin/env python
print('${PV}')
" > build/calc_release_version.py
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_LIBBSON=FALSE
		-DENABLE_EXAMPLES=OFF
		-DENABLE_MAN_PAGES=ON
		-DENABLE_MONGOC=OFF
		-DENABLE_TESTS=OFF
		-DENABLE_STATIC="$(usex static-libs ON OFF)"
		-DENABLE_UNINSTALL=OFF
	)

	cmake_src_configure
}

src_install() {
	if use examples; then
		docinto examples
		dodoc src/libbson/examples/*.c
	fi

	cmake_src_install
}