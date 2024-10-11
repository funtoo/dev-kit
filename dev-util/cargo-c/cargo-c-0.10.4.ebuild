# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/46bd413718501a24afaf60fa36bad799d5e296d6 -> cargo-c-0.10.4-46bd413.tar.gz
https://direct.funtoo.org/1d/a4/29/1da429760a9b65899aaf84dc93029e488055140b81ce59b5ba43aa02b2c648406b18d8ad7476355d12bab24746d0ee6bf5ed771ba0a20444064ca430ef69fb12 -> cargo-c-0.10.4-funtoo-crates-bundle-833d4318e4d25c84ae234abd75843aa06a59d8788610e13556c17a06356b9920418f61313702d8b24add13eb8658db2777193723bc53dd0592ce374e69e5a83a.tar.gz"

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