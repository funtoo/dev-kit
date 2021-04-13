# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
ansi_term-0.12.1
autocfg-1.0.1
bitflags-1.2.1
byteorder-1.4.3
cc-1.0.67
cfg-if-1.0.0
datetime-0.5.2
form_urlencoded-1.0.1
git2-0.13.17
glob-0.3.0
hermit-abi-0.1.18
idna-0.2.2
jobserver-0.1.21
lazy_static-1.4.0
libc-0.2.93
libgit2-sys-0.12.18+1.1.0
libz-sys-1.1.2
locale-0.2.2
log-0.4.14
matches-0.1.8
natord-1.0.9
num_cpus-1.13.0
number_prefix-0.4.0
openssl-src-111.15.0+1.1.1k
openssl-sys-0.9.61
pad-0.1.6
percent-encoding-2.1.0
pkg-config-0.3.19
redox_syscall-0.1.57
scoped_threadpool-0.1.9
term_grid-0.1.7
term_size-0.3.2
tinyvec-1.2.0
tinyvec_macros-0.1.0
unicode-bidi-0.3.5
unicode-normalization-0.1.17
unicode-width-0.1.8
url-2.2.1
users-0.11.0
vcpkg-0.2.11
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
zoneinfo_compiled-0.5.1
"

inherit bash-completion-r1 cargo

DESCRIPTION="A modern replacement for 'ls' written in Rust"
HOMEPAGE="https://the.exa.website/ https://github.com/ogham/exa"
SRC_URI="https://api.github.com/repos/ogham/exa/tarball/v0.10.1 -> exa-0.10.1.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+git"

BDEPEND="|| ( app-text/pandoc-bin app-text/pandoc )"

DEPEND="
	git? (
		dev-libs/libgit2:=
		net-libs/http-parser:=
	)
"

RDEPEND="${DEPEND}"

RESTRICT="test"

QA_FLAGS_IGNORED="/usr/bin/exa"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/ogham-exa-* ${S} || die
}

src_compile() {
	cargo_src_compile $(usex git "" --no-default-features)
	find ${S}/man -iname "*.md" -type f -exec sh -c 'pandoc --standalone -f markdown -t man "${0}" -o "${0%.md} "' {} \; || die
	rm -f ${S}/man/*.md || die
	mv ${S}/man ${S}/man.tmp || die
}

src_install() {
	cargo_src_install $(usex git "" --no-default-features)

	newbashcomp completions/completions.bash exa

	insinto /usr/share/zsh/site-functions
	newins completions/completions.zsh _exa

	insinto /usr/share/fish/vendor_completions.d
	newins completions/completions.fish exa.fish

	doman man.tmp/*
}