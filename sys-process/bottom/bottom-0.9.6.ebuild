# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Yet another cross-platform graphical process/system monitor."
HOMEPAGE="https://github.com/ClementTsang/bottom"
SRC_URI="https://github.com/ClementTsang/bottom/tarball/6d251098710f3119af11ecdd8761929acb010fab -> bottom-0.9.6-6d25109.tar.gz
https://direct.funtoo.org/4b/1e/19/4b1e195e8744e662d26e49edba3e24ecc3c32f8a3f4b69b38711c0fea90478a84a9229f05d850d5e19b7f435bb9f753a66864b4b093af2a2776644ffbcdb6fbd -> bottom-0.9.6-funtoo-crates-bundle-d035a407a5a09ca6b19b7db36f8b8b156c55604e17b04c04899b66150fdaf8aa9b2eea8d15f9a68d246a125d414e6b778dd40adc79227820c17d7e44b7e318b7.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

DOCS=( README.md CHANGELOG.md )

QA_FLAGS_IGNORED="/usr/bin/btm"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/ClementTsang-bottom-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}