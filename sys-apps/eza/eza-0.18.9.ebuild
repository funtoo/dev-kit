# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 cargo

DESCRIPTION="A modern, maintained replacement for ls"
HOMEPAGE="https://eza.rocks https://github.com/eza-community/eza"
SRC_URI="https://github.com/eza-community/eza/tarball/387742b526a6e79aa0a7bc7c2e7006ec691f4ad4 -> eza-0.18.9-387742b.tar.gz
https://direct.funtoo.org/a0/aa/70/a0aa700c574e30ecc8c6eb8a76143560cb7ffd475b7463deed9672a7155978eacb9db255cbf07781ac150e2fcd01c000a50ab2af616bb64b40ecc188fc9428b9 -> eza-0.18.9-funtoo-crates-bundle-be37240388a4f46c269f7467891a26f11b8bc2c4ffe3dfc5210e0747343c430799c0055183128c86d54713354ff533d28c6b2f9ec125677601b3661527857386.tar.gz"

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