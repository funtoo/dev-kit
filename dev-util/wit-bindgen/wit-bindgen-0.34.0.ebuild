# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A language binding generator for WebAssembly interface types"
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
SRC_URI="https://github.com/bytecodealliance/wit-bindgen/tarball/98b26cf9e011940b008351b93e7098dab1a5ff86 -> wit-bindgen-0.34.0-98b26cf.tar.gz
https://direct.funtoo.org/42/ed/fd/42edfd67665aa55e440716c888c3232747f6a58e0f9ce73e9c757141b1dd5683cbabb8a34b3ffd56dfe172199c40a18a833a560e727a364a9958e4f06abb64c3 -> wit-bindgen-0.34.0-funtoo-crates-bundle-900b9c1c98f11cedceab684925e3d9b6236cf8e45f8e49c92bbf418ddad1c5af2b300fa5d7064a14131b64c147e823537ce7617a2f737009dc121a07fde0727d.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DOCS=( README.md )

QA_FLAGS_IGNORED="/usr/bin/wit-bindgen"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/bytecodealliance-wit-bindgen-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}