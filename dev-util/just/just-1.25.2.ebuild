# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/c64424476a3ac674e28eead5350729f3b1c55984 -> just-1.25.2-c644244.tar.gz
https://direct.funtoo.org/c4/14/df/c414df141f0e4ff0ad16ff4bbfa6bcbcc3116329383d4fc71f5d809288581f18b5db59721f29981940e02a300ce40b6c24dcb95a123a0f5cbe38a381ecab94b1 -> just-1.25.2-funtoo-crates-bundle-f8d12e0ee9e114c20f70cd89f7d793ee4b0b42a6afb81218ba2b386e0b66157d4531e8171522ed0f729100762faa524c4f4d333d3450d70da5a90589896b4707.tar.gz"

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

src_configure() {
	# FL-10339 workaround
	# upstream man directory for some reason errors with the doman eclass function:
	# install-xattr: failed to stat /var/tmp/portage/dev-util/just-1.25.2/image/usr/share/man/man2/man: No such file or directory
	mv ${S}/man ${S}/man.tmp || die
}

src_install() {
	cargo_src_install

	doman man.tmp/*

	dodoc README.md
	einstalldocs
}