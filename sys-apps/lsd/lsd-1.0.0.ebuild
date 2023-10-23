# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern ls with a lot of pretty colors and awesome icons"
HOMEPAGE="https://github.com/lsd-rs/lsd"
SRC_URI="https://github.com/lsd-rs/lsd/tarball/1a528cb69df475511fee7493811a353698fa47b9 -> lsd-1.0.0-1a528cb.tar.gz
https://direct.funtoo.org/f4/36/20/f43620ce5cf849aa30fa9b5f0f177465eba76223df4e78a1ba1efa5e4d6fd6f27bc28c0d3c2d018d8c9c1df9dfdfb6562d5257942c76d95d32bd323e2879c354 -> lsd-1.0.0-funtoo-crates-bundle-fa5a87fd443a95ba93b8ded918c937e7b5c3cf0ade236f75fe64f6667bf67ccc53d807b8788156012c938c73c96b53e4d780dc5ba3dfe55dfbc8d30944a04dae.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+git"

DEPEND=""
RDEPEND=""
BDEPEND=">=virtual/rust-1.31.0"

QA_FLAGS_IGNORED="/usr/bin/lsd"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lsd-rs-lsd-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}