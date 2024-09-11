# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/46bd413718501a24afaf60fa36bad799d5e296d6 -> cargo-c-0.10.4-46bd413.tar.gz
https://direct.funtoo.org/8f/4a/d3/8f4ad3e89e659ac8b1c480bd91af3ae984c3f3b8f5b4a189c60095d65dabd4d4f817e64cdd8ebf4dc8254a073c86b385089ef6b2796af7b68352bbc2d47e95a7 -> cargo-c-0.10.4-funtoo-crates-bundle-ed55c3e5b951e9be4b60bfd628e558ae00c59af90bfabda8e68b03a5c75406834b481a77c8161eeff98776430fb6de71991a30020d8eba83e946863bf437ca72.tar.gz"

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