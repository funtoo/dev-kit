# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/3a2b7cfc1e9eb4fb9054d23dd816b59d10a2f49e -> cargo-c-0.10.2-3a2b7cf.tar.gz
https://direct.funtoo.org/a9/2b/79/a92b7980a8ee7878f3f0a70e83867a26555ae47b4c9d86e3d8a559803ed712f131840151d1e9b340c12ce2830d7459bba09b008789a5c043c3a6d536386f2f31 -> cargo-c-0.10.2-funtoo-crates-bundle-75a4e23d9296e4f1581fb9c3d2c53ca6e19d000dae0cc0350102a1ed08c13c02c5a90db1428d5af42eadd6ecaf656a62f0f047bec52f216c3f3a9e5cd4340ca7.tar.gz"

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