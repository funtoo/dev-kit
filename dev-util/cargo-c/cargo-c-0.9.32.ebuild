# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/71/4a/38/714a38b0547bc5028c5bd71d4e1d288b85b588efc07ffa74c7e042b7a160af39ac5230733ca2a6478ce94221a51a9c2573e924a09a412550d97e7c312e4065c2 -> cargo-c-0.9.32-funtoo-crates-bundle-e67ce4712982d78c88628e75022af15a02204c728760b9abfd5699290ebf0bd20ffad8be54848357c462dc0525baf359c98f328562c2801fb08ef9f7db03ebe8.tar.gz"

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