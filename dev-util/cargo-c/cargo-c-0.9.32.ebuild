# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/6f/e5/d9/6fe5d99184f828b6dc15211d1e6c53e06aae2b17911535cee1add56f1435cd4131459bd0661b7344fa92e887a6c47ab6d8c48b5883501a1d5c9331df47cf5c78 -> cargo-c-0.9.32-funtoo-crates-bundle-952de61ffdfdedefdfb5c0436dc57385177b72097dafc2e40d05f364aa77b2d9c633a38a069ff1ec672c86bec61dd1d3849228bf9de7a5d22aee0840dbf958d3.tar.gz"

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