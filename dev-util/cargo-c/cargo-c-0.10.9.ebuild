# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/578b4ed8a8baa9faa42a072ca40b7267b125fc15 -> cargo-c-0.10.9-578b4ed.tar.gz
https://direct.funtoo.org/ed/77/4f/ed774f311d3c4e530924eb1ac929aa6f6e77e3abd22b8883eac6b621c4211563300eff137ed8acf563ce31857e0e5279e1638c795736dae472d9b2d323039525 -> cargo-c-0.10.9-funtoo-crates-bundle-6840430aa1f57c171df2e83a52d4190d1155c1cf8cd15ff1bca87620810b4e23fa930ec4db9027284587873d1f553203b5baa1fdd51938b8cd263956edd3c755.tar.gz"
# https://forums.gentoo.org/viewtopic-t-1131762-start-0.html
# https://forums.gentoo.org/viewtopic-t-1111448.html
# This is a confirmed fix, but it doesn't appear related to 32-bit time. Some other sandbox crap:
RESTRICT="sandbox usersandbox"

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