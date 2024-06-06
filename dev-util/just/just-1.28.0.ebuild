# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/a295ee9d428fc4f46ff9327a320fd0a2144edf34 -> just-1.28.0-a295ee9.tar.gz
https://direct.funtoo.org/bb/54/97/bb5497f3fe0f5328cc3a2398fb7a7bf5e5f632bcbd179de29d15a6441e857ce537becb78b01ddbfe9daaba1f0030f90c200299225c301f5d3d8216b43654b1e3 -> just-1.28.0-funtoo-crates-bundle-d5e57add869b365b4fbcdbc0b9ea004f121cc331b7144449a34ffdce637abe9188045a4bbf63b894afba66d2c7068c035449872766336c697266952b026e27aa.tar.gz"

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