# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/8914ddfa8d45a0c27abdb48708138a5bc32e5bd6 -> cargo-c-0.10.7-8914ddf.tar.gz
https://direct.funtoo.org/0a/32/bc/0a32bc5ce5c8ba56c2c78c0a3ba07f12b243842b6428f316d20bdde6e43f017432b6894024c053991cb9fb6438bd03f320fb8252eeef1ccd7d0a5edb67bd87e0 -> cargo-c-0.10.7-funtoo-crates-bundle-1789619ccbb43a2e58c44dc46c320bfc3246fb6a9068dfc4159b813ca05417b64be9326c85df7c962f25851e95ccf1310582d9440c1fe70fb559ea353303e89b.tar.gz"

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