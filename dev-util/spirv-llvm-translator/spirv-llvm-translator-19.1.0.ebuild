# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic llvm


DESCRIPTION="Bi-directional translator between SPIR-V and LLVM IR"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-LLVM-Translator"
SRC_URI="https://api.github.com/repos/KhronosGroup/SPIRV-LLVM-Translator/tarball/v19.1.0 -> spirv-llvm-translator-19.1.0.tar.gz"

LICENSE="UoI-NCSA"
SLOT="$(ver_cut 1)"
KEYWORDS="*"
IUSE="tools"

RESTRICT="test"

DEPEND="sys-devel/clang:${SLOT}="
RDEPEND="${DEPEND}"

LLVM_MAX_SLOT=${SLOT}

PATCHES=(
	"${FILESDIR}"/${PN}-8.0.0.1-no_pkgconfig_files.patch
)

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/KhronosGroup-SPIRV-LLVM-Translator-* "${S}" || die
}

src_prepare() {
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="$(get_llvm_prefix ${LLVM_MAX_SLOT})"
		-DLLVM_BUILD_TOOLS=$(usex tools "ON" "OFF")
	)
	cmake-utils_src_configure
}