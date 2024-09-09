# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN/-bin/}
S=${WORKDIR}/${MY_PN}-version-${PV}

DESCRIPTION="Optimizer and compiler/toolchain library for WebAssembly"
HOMEPAGE="https://github.com/WebAssembly/binaryen"
SRC_URI="amd64? (
  https://github.com/WebAssembly/binaryen/releases/download/version_119/binaryen-version_119-x86_64-linux.tar.gz -> binaryen-version_119-x86_64-linux.tar.gz
)
arm64? (
  https://github.com/WebAssembly/binaryen/releases/download/version_119/binaryen-version_119-aarch64-linux.tar.gz -> binaryen-version_119-aarch64-linux.tar.gz
)
"

LICENSE="Apache License v2.0"
SLOT="0"
KEYWORDS="-* amd64 arm64"
IUSE="amd64 arm64"

DEPEND=""
RDEPEND="${DEPEND}"

QA_PREBUILT="/usr/bin/wasm*"

QA_PRESTRIPPED="/usr/bin/binaryen-unittests"

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
	mv "${WORKDIR}"/${MY_PN}-version_${PV} "${S}" || die
	fi
}

src_install() {
	for b in binaryen-unittests wasm-as wasm-ctor-eval wasm-dis wasm-emscripten-finalize wasm-fuzz-lattices wasm-fuzz-types wasm-merge wasm-metadce wasm-opt wasm-reduce wasm-shell wasm-split wasm2js ; do
		dobin bin/${b}
	done

	insinto /usr/lib/${MY_PN}
	doins -r include
}