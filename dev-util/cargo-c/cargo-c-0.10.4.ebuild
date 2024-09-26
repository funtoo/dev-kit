# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/46bd413718501a24afaf60fa36bad799d5e296d6 -> cargo-c-0.10.4-46bd413.tar.gz
https://direct.funtoo.org/0d/52/8d/0d528d7a9ceda2e7203ec7c5ce889a5f7f3ed21de34bdc4ee2a1d5d2777af87e60e1d5f26fd7bb435d096fc205d7be98b45e117ba64c96e3f350be48b5c6a3dc -> cargo-c-0.10.4-funtoo-crates-bundle-700bb7eb588cb68b85b3f97a776a89853e4f3404a656fe65db1ddd9c262afb9675f4099f971097eee5111f464996c727f37776b9c86956d282e2c092ff94374c.tar.gz"

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