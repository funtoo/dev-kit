# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/0802dba610d351685b04154ffd559a3462e59adb -> just-1.34.0-0802dba.tar.gz
https://direct.funtoo.org/39/83/ad/3983ad4d348ed103dc2a480bcddc8ad7234a1ef792f27a852849e7eff8342df99378dc37233490948dff55ffb3b02072fac1d57587ffebec68712ba133d80b34 -> just-1.34.0-funtoo-crates-bundle-544c317ed2ae9c3ad5fb206293a35be54450272d9051532237d30590685e16f0b28752bebd1a4c330ac5b715aba228e88bac8e60ffef63f5c5e2c63cba1c3767.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/just"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/casey-just-* ${S} || die
}

src_install() {
	cargo_src_install

	mkdir ${S}/man
	${S}/target/release/just --man > ${S}/man/just.1
	doman man/just.1

	dodoc README.md
	einstalldocs
}