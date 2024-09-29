# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/46bd413718501a24afaf60fa36bad799d5e296d6 -> cargo-c-0.10.4-46bd413.tar.gz
https://direct.funtoo.org/ca/96/4e/ca964efc39ed9c2c1ae025714cbd7873d63ba76df3e5d580491eb227601a744ac8301a431f28dad5cae02a3998b0e1974adfddc3570a32286a0dbac6b950a4db -> cargo-c-0.10.4-funtoo-crates-bundle-624c252a81a9b1587f2a3560a8034b7a4c1e84f53ec2a3f7730c05d40fd9891ee24d2fe7a2b5d93ce146ad8a013e634a93cae8d5b5b81ba471d6eeb2a3d09b15.tar.gz"

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