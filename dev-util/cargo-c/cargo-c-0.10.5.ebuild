# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/b6081a47813aab0175645e332b14282c651c893d -> cargo-c-0.10.5-b6081a4.tar.gz
https://direct.funtoo.org/52/3d/d3/523dd30751018f91ac9fcaa0d1ef3ebae1bcc7c74d617854c47af59d548505a962a3318e5856cfc009a4546cdbca22d04a1f6e54294c882f58a71ba8f6f79b2c -> cargo-c-0.10.5-funtoo-crates-bundle-e3ee9c50a169a9564535893d14b2f92b240460b6a78a303c0fff0f54a43fb7437abfac8951bf6484d9de9b1974ab53a76abec25e6ea9f0d8c170641541eb1d62.tar.gz"

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