# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/d1/ce/69/d1ce6975715ad76621e89dd9b12a3dd4e8fa1df56111970a82855441bccdaa0e9e5f6a7f6288ebde2547165740adbab60ba822f1394d75075bb8aa2c7f6f42c3 -> cargo-c-0.9.32-funtoo-crates-bundle-f55278b52c4d55741a2dddd7afbd7847c1819c29dc29f264e32329eeafd90178a011f72abf315d0fa3a2e0dd9330280a674ea4bdcea815e766f4b815bf53ed20.tar.gz"

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