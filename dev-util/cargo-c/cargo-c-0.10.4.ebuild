# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/46bd413718501a24afaf60fa36bad799d5e296d6 -> cargo-c-0.10.4-46bd413.tar.gz
https://direct.funtoo.org/be/9d/e7/be9de7437e02cc96f034ae991e99e728a793404495ea01734d71f25585b838eaaa6067586bd72a3bcc9cdce37606d3ffacfa58604ea1d3c3b6d44e52d9f290b9 -> cargo-c-0.10.4-funtoo-crates-bundle-873a13b5ee548154ef11d737ce6ce50c1128ecb3b33d831f1365104a150e9804fd57941e5e07a8320f2f2e1d4b071b38ad929c614b4a5cde98d942ef87300baf.tar.gz"

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