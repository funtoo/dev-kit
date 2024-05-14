# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://github.com/casey/just/tarball/c7422c148b42c110dfd945840b468d51ff2b0919 -> just-1.26.0-c7422c1.tar.gz
https://direct.funtoo.org/09/f0/41/09f04183dffc11db1794c00eda5072c3eaad720a803cccd28efd4616b990d52491bb44e4b555162ae7e1dc5604febe4ed8b6d99ddb4cb0bb79b5e20dec04e3c8 -> just-1.26.0-funtoo-crates-bundle-c7f598635a67f527ae99ebcbb70773e6ab80a3b5aac4c09af593188cc7454926ba7079b9a31584f36e689f30cc7ce3490123c09989e999f62abe98b011c174d4.tar.gz"

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