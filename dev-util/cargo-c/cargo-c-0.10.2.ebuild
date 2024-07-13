# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/94/db/fe/94dbfe5baed84fdda978dffdec1f397a24a5c181394b47aff8e3a1c2f2f2e65d0d2e41a722acb8375a37345ba75e18602339bd5b7e514d9f85f5436a85e44af5 -> cargo-c-0.10.2-funtoo-crates-bundle-7941932f864e390e79e276dc4161ceff3f5b38399ca6e1b107425bfe74fe719725bbc30ee62d4029d79af0b9111f3c12c1e22b69bb7956e9d169d2bdacb46c22.tar.gz"

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