# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/8914ddfa8d45a0c27abdb48708138a5bc32e5bd6 -> cargo-c-0.10.7-8914ddf.tar.gz
https://direct.funtoo.org/48/c2/f8/48c2f81fd12d31b554aa5efc53a366e688f064a908c80246fae006a65a1854a58a861e4b453d17f300d6e5aa5909c6dcc5696af43bf3b57f4330bb171840952b -> cargo-c-0.10.7-funtoo-crates-bundle-dc50f7750c4ff7d1bcc25e7a6ff0d1719306ae83973d2c1c84dc5af49d580710919d592aeb8806acb77db0000005fdd914627641878553e5fe6f5c5bf70340ae.tar.gz"

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