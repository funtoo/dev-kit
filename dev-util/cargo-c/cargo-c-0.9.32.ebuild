# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/45/75/22/457522c45f253ee077fb92cd91768ba93acea594fb5c288cfdce20ace5139a1e8057867d77dba4688de08989c269e290447fe083a768f7b5c31fa362dfe7c7df -> cargo-c-0.9.32-funtoo-crates-bundle-fc78ef338f4e1a8e11f5f0ecf02da530a2a6715ebb6e32fca1b55cd33bbc7272d4a49f7df1b7ae6ddfda448eae9c2904a97f34a3ae92220620afa1227e9f6856.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="sys-libs/zlib
	dev-libs/openssl:0=
	dev-vcs/git
	net-misc/curl[ssl]
"
BDEPEND="virtual/rust"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lu-zero-cargo-c-* ${S} || die
}