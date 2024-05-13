# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/56dfe34ce1281f6ae5eb5517f7cf03f87bec352c -> cargo-c-0.9.32-56dfe34.tar.gz
https://direct.funtoo.org/49/e0/72/49e072b96d2c72c4ef7069aef7b80ce0704f724416e5ce01e7a5e7ea658b7cc84430fce44eeeeb0c865fe12e1fe2654ea6a49ec04f16fd40bbf32f7707f526fd -> cargo-c-0.9.32-funtoo-crates-bundle-3caadbdf86994dc9b3a65607817abdfaa6e7c82ec9ef821aba592cff762939473a57c06b7b97c939a238dee01a089107618d2d03846a398c7dc98dedf24202ff.tar.gz"

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