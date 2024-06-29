# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/756974fb8962be45319fa3ad3bd9eb8033bdc76a -> cargo-c-0.10.1-756974f.tar.gz
https://direct.funtoo.org/b2/ed/d9/b2edd99804267e95dc423b577c1da51fb387f9661a1b975c04b935681d0bbe2ceea2295fab4875c8d0ab0da50d1dc1f425e6192b6ff913c6dbc730b80bf6a7d6 -> cargo-c-0.10.1-funtoo-crates-bundle-d1c6b9f36cca21737364b5ef9a863d7db5c08ea6c8de93f8d2ed9b12b9d8a8ae85d478e7220e31629dc29ed07f0ab02121f36095e623df18eb976a00cac900d4.tar.gz"

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