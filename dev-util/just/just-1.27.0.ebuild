# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/663ceca936ebe37a2e5a8d2baafe0d124c7993d4 -> just-1.27.0-663ceca.tar.gz
https://direct.funtoo.org/28/f1/f2/28f1f25dd8817da7e7f35778e27405aee8dbd03a62a019657a866e20403852369713795188a2578d0f4a4bd00e4aa2b9c59d78b3e85062b94f50f53930b2bf39 -> just-1.27.0-funtoo-crates-bundle-0d3e35ad3650dec205e29bc2056830d2df35ea260a98cfaebd4c71be219d438917957c9d9c0cba0b9151309279b0fc394fdb6a6f73063fa492f6b7526f5d7dcd.tar.gz"

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