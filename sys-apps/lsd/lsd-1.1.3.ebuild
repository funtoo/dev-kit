# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern ls with a lot of pretty colors and awesome icons"
HOMEPAGE="https://github.com/lsd-rs/lsd"
SRC_URI="https://github.com/lsd-rs/lsd/tarball/6953ecbfe20ffee2c1dd07b8b8ae562250f371cd -> lsd-1.1.3-6953ecb.tar.gz
https://direct.funtoo.org/03/03/88/0303880e79ec9571a2116877092dfdc1b7a6c7e2c62a275e84e96ac0c368fcdb7567122122592cd475d3c583a2f38a4e3fb6826644dcaf1aa266098d232426e0 -> lsd-1.1.3-funtoo-crates-bundle-038f5c9405aabedffd7bca2c1c67b3fe500f05a3a6e9e8bb660778f84d4e751bb70cfb981775e459ec0099d7bb6af9774f5c81fbee30d8ed557f0eb21c57bfcc.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+git"

DEPEND=""
RDEPEND=""
BDEPEND=">=virtual/rust-1.31.0"

QA_FLAGS_IGNORED="/usr/bin/lsd"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lsd-rs-lsd-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}