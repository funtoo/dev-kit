# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/62e72d44915675b2678f32e701bc1503d32881bb -> cargo-c-0.10.0-62e72d4.tar.gz
https://direct.funtoo.org/55/93/df/5593dfa67acfb21f8348621ed6726ed52b3ddd5325dea3952e6c6baf37c257d259f95df533ef6bcfd4f540cd7651b769c92894e435891d11cfe81b76b296a27a -> cargo-c-0.10.0-funtoo-crates-bundle-72c878b6210e30ca78eabb7381bebd64b193666aa06ddd03d4d2875c1fe147b7066bc17733cd846d405b72711b587784f46dcbb7c05787008cf80d0dc7ca9381.tar.gz"

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