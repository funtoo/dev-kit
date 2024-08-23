# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/ee7d7ef74b9c1fa00c6780da41a838752c76b3eb -> cargo-c-0.10.3-ee7d7ef.tar.gz
https://direct.funtoo.org/48/62/a8/4862a854e6ef0acb2de2cbba7971903d7a3690a555f93088a6b033a107a0236cf408720412b6d9fa5fd79f4f41a4f3be0e5c6ea1358dadb1ff309bfd04ff1f30 -> cargo-c-0.10.3-funtoo-crates-bundle-d86b9da3c501f203f019bf3f53c5e9cdade665a8b126c2cd26ff8e311741e3dd96399588c0b42a511d95f4c7623b54668f93679b889b49cafd030f9157b15760.tar.gz"

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