# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/756974fb8962be45319fa3ad3bd9eb8033bdc76a -> cargo-c-0.10.1-756974f.tar.gz
https://direct.funtoo.org/f8/5c/51/f85c517a67cb8202d5ad7ca0d3dd077c4a09b4a1b38de7e4794731da20f44fffd52a8485932cea13244b099bcf99cde0f50742d43bed67f29b8b6eafb6707f96 -> cargo-c-0.10.1-funtoo-crates-bundle-51a95c68db06661282a63c15f999c4fa800e2c0f68dd0610a4c3d00e752f2e3113aa92b6fd20699626fda36603ba8c5310e4bbf42cc6cb629d3fef6ef26c1d6d.tar.gz"

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