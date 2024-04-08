# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A simple, fast and user-friendly alternative to 'find'"
HOMEPAGE="https://github.com/sharkdp/fd"
SRC_URI="https://github.com/sharkdp/fd/tarball/d9c4e6239fc1807bce1bb6aca4426f3880230a84 -> fd-9.0.0-d9c4e62.tar.gz
https://direct.funtoo.org/b4/8a/ad/b48aadfe9e51233b5899df46b4f3f493666a4a98c83f85fc7833708dc8e2c74cca6982956a80c7db42456bebce48d7f63a476b161bd8e7e7bf3702386da2381d -> fd-9.0.0-funtoo-crates-bundle-f5712a17040fcc9f1ab33ccce3758d94d842dec738278184e1081115338757f040603ceb888c6942a426d08977a12475a88c568262ccfb5a37ce5fb5e72b230f.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
DEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/fd"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/sharkdp-fd-* ${S} || die
}

src_compile() {
	# https://bugs.funtoo.org/browse/FL-10663
	# If we want bash and fish shell completions we have to
	# reverse engineer components of this Makefile from upstream
	# into this ebuild: https://github.com/sharkdp/fd/blob/master/Makefile
	#
	# After fd v8.5.0, bash and fish shell completion is being handled directly
	# by the fd Rust binary itself, specifically the clap_complete feature of the clap Crate
	#
	# These shell completion files can now be dynamically generated  with:
	# fd --gen-completions bash
	# fd --gen-completions fish
	#
	# The problem is the absolute pathing to the fd binary in those auto-generated
	# completion files needs to be correct relative to the Funtoo install in this ebuild
	cargo_src_compile
}

src_install() {
	cargo_src_install

	insinto /usr/share/zsh/site-functions
	doins contrib/completion/_fd
	dodoc README.md
	doman doc/fd.1
}