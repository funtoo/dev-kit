# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS="cmake"
inherit cmake-multilib

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="https://github.com/jbeder/yaml-cpp"
SRC_URI="https://github.com/jbeder/yaml-cpp/tarball/0579ae3d976091d7d664aa9d2527e0d0cff25763 -> yaml-cpp-0.7.0-0579ae3.tar.gz"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="*"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-cpp/gtest[${MULTILIB_USEDEP}] )"

PATCHES=(
	"${FILESDIR}/${PN}-0.7.0-gtest.patch"
	"${FILESDIR}/${PN}-0.7.0-pkg-config.patch"
)

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv jbeder-yaml-cpp* "${S}" || die
	fi
}

src_prepare() {
	rm -r test/gtest-* || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DYAML_BUILD_SHARED_LIBS=ON
		-DYAML_CPP_BUILD_TOOLS=OFF # Don't have install rule
		-DYAML_CPP_BUILD_TESTS=$(usex test)
	)

	cmake-multilib_src_configure
}