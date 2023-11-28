# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="JSON for Modern C++"
HOMEPAGE="https://github.com/nlohmann/json"
SRC_URI="
	https://api.github.com/repos/nlohmann/json/tarball/v3.11.3 -> json-3.11.3.tar.gz
	test? ( https://api.github.com/repos/nlohmann/json_test_data/tarball/v3.1.0 -> json_test_data-3.1.0.tar.gz )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="doc test"

BDEPEND="doc? ( app-doc/doxygen )"

DOCS=( ChangeLog.md README.md )

S="${WORKDIR}/json-3.11.3"

fix_src_dirs() {
	# We need this because the top dir in the tarballs use the first part of the
	# corresponding commit which changes every release
	
	pushd "${WORKDIR}"
	mv nlohmann-json-* json-3.11.3
	mv nlohmann-json_test_data-* json_test_data-3.1.0
	popd
}

src_unpack() {
	default
	fix_src_dirs
}

src_configure() {
	
	# Just remove cmake_fetch_content test because even after passing -LE git_required
	# per https://github.com/nlohmann/json/issues/2189 it still tries to run those tests for 
	# whatever reason.
	pushd "${S}/test"
	sed -i '/add_subdirectory(cmake_fetch_content)/'d CMakeLists.txt
	popd
	
	# Tests are built by default so we can't group the test logic below
	local mycmakeargs=(
		-DJSON_MultipleHeaders=ON
		-DJSON_BuildTests=$(usex test)
	)

	# Define test data directory here to avoid unused var QA warning, bug #747826
	use test && mycmakeargs+=( -DJSON_TestDataDirectory="${WORKDIR}"/json_test_data-3.1.0 )

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	if use doc; then
		emake -C doc
		HTML_DOCS=( doc/html/. )
	fi
}

src_test() {
	cd "${BUILD_DIR}/test" || die

	# Skip certain tests needing git per upstream
	# https://github.com/nlohmann/json/issues/2189
	local myctestargs=(
		"-LE git_required"
	)
	
	cmake_src_test
}