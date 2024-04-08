# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Customize your git commit hashes!"
HOMEPAGE="https://github.com/not-an-aardvark/lucky-commit"
SRC_URI="https://github.com/not-an-aardvark/lucky-commit/tarball/00000002877d35de410890b322e3f76790706390 -> lucky-commit-2.2.3-0000000.tar.gz
https://direct.funtoo.org/d8/af/c9/d8afc90cf86ad84ca5dd94251ddb3ea456dcaad4d1305c117d9e0e0558fed01c1f6f9ab3ef5148d9b53eddfc3f6d69d4b9ad9930fa24efa07b7a8e2a3fb3268a -> lucky-commit-2.2.3-funtoo-crates-bundle-bb0f63a6cb9b09dbfea55b0fbc0f1d6d8b9a48c0546e8fa9cb2e6a5226cfc320bb4d6770c96e6fcfb042d8a2cd16affe49edab61cc179beadee2c7d4084a78a8.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/lucky-commit"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/not-an-aardvark-lucky-commit-* ${S} || die
}

src_compile() {
	cargo_src_compile --no-default-features
}

src_install() {
	cargo_src_install --no-default-features
}