# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 cargo

DESCRIPTION="A modern alternative to ls"
HOMEPAGE="https://eza.rocks https://github.com/eza-community/eza"
SRC_URI="https://github.com/eza-community/eza/tarball/c1e583e5856ebff6dbc1c896ebbb92d3427c4b54 -> eza-0.20.14-c1e583e.tar.gz
https://direct.funtoo.org/de/60/93/de60930dd614fc2cfd6c83f1d6a3624954b70b0f29b55271189fdf92849fbc33e514225689566e93e9d95665b2e670c6f5093396e65eeb39011fee813a9a069a -> eza-0.20.14-funtoo-crates-bundle-47d379514b99758dd26a2c72add5ca69df51a7b804cea8f82c2a72a3c694221bffa58a54f3dcf32663e10b3edcbc35953e1ddc93826634097ab3e0f0137ee095.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+git"

DEPEND="
	git? (
		dev-libs/libgit2:=
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	|| ( app-text/pandoc-bin app-text/pandoc )
	virtual/rust
"

DOCS=( README.md CHANGELOG.md )

QA_FLAGS_IGNORED="/usr/bin/eza"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/eza-community-eza-* ${S} || die
}

src_configure() {
	local myfeatures=(
		$(usev git)
	)
	# https://bugs.funtoo.org/browse/FL-11956
	# Enabling vendoring of libgit2 as eza requires version >= 1.7.2
	# Once Funtoo has a new version this can be changed back to 1 for
	# linking against the Funtoo system libgit2
	export LIBGIT2_NO_VENDOR=0
	export PKG_CONFIG_ALLOW_CROSS=1
	cargo_src_configure --no-default-features

	find ${S}/man -iname "*.md" -type f -exec sh -c 'pandoc --standalone -f markdown -t man "${0}" -o "${0%.md} "' {} \; || die
	rm -f ${S}/man/*.md || die
	mv ${S}/man ${S}/man.tmp || die

}

src_install() {
	cargo_src_install
	einstalldocs

	newbashcomp completions/bash/eza eza

	insinto /usr/share/zsh/site-functions
	doins completions/fish/eza.fish

	insinto /usr/share/fish/vendor_completions.d
	doins completions/zsh/_eza

	doman man.tmp/*
}