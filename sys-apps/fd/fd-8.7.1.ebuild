# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-1.1.2
android-tzdata-0.1.1
android_system_properties-0.1.5
anstream-0.6.4
anstyle-1.0.4
anstyle-parse-0.2.2
anstyle-query-1.0.0
anstyle-wincon-3.0.1
anyhow-1.0.75
argmax-0.3.1
autocfg-1.1.0
bitflags-1.3.2
bitflags-2.4.1
bstr-1.7.0
bumpalo-3.14.0
cc-1.0.83
cfg-if-1.0.0
chrono-0.4.31
clap-4.4.6
clap_builder-4.4.6
clap_complete-4.4.3
clap_derive-4.4.2
clap_lex-0.5.1
colorchoice-1.0.0
core-foundation-sys-0.8.4
crossbeam-channel-0.5.8
crossbeam-utils-0.8.16
ctrlc-3.4.1
diff-0.1.13
errno-0.3.5
etcetera-0.8.0
faccess-0.2.4
fastrand-2.0.1
filetime-0.2.22
fnv-1.0.7
globset-0.4.13
heck-0.4.1
hermit-abi-0.3.3
home-0.5.5
humantime-2.1.0
iana-time-zone-0.1.58
iana-time-zone-haiku-0.1.2
ignore-0.4.20
jemalloc-sys-0.5.4+5.3.0-patched
jemallocator-0.5.4
js-sys-0.3.64
lazy_static-1.4.0
libc-0.2.149
linux-raw-sys-0.4.10
log-0.4.20
lscolors-0.15.0
memchr-2.6.4
nix-0.24.3
nix-0.26.4
nix-0.27.1
normpath-1.1.1
nu-ansi-term-0.49.0
num-traits-0.2.17
num_cpus-1.16.0
once_cell-1.18.0
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.69
quote-1.0.33
redox_syscall-0.3.5
regex-1.10.2
regex-automata-0.4.3
regex-syntax-0.7.5
regex-syntax-0.8.2
rustix-0.38.19
same-file-1.0.6
serde-1.0.189
serde_derive-1.0.189
strsim-0.10.0
syn-1.0.109
syn-2.0.38
tempfile-3.8.0
terminal_size-0.3.0
test-case-3.2.1
test-case-core-3.2.1
test-case-macros-3.2.1
thread_local-1.1.7
unicode-ident-1.0.12
users-0.11.0
utf8parse-0.2.1
version_check-0.9.4
walkdir-2.4.0
wasm-bindgen-0.2.87
wasm-bindgen-backend-0.2.87
wasm-bindgen-macro-0.2.87
wasm-bindgen-macro-support-0.2.87
wasm-bindgen-shared-0.2.87
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.6
winapi-x86_64-pc-windows-gnu-0.4.0
windows-core-0.51.1
windows-sys-0.48.0
windows-targets-0.48.5
windows_aarch64_gnullvm-0.48.5
windows_aarch64_msvc-0.48.5
windows_i686_gnu-0.48.5
windows_i686_msvc-0.48.5
windows_x86_64_gnu-0.48.5
windows_x86_64_gnullvm-0.48.5
windows_x86_64_msvc-0.48.5
"

inherit cargo

DESCRIPTION="Alternative to find that provides sensible defaults for 80% of the use cases"
HOMEPAGE="https://github.com/sharkdp/fd"
SRC_URI="https://api.github.com/repos/sharkdp/fd/tarball/v8.7.1 -> fd-8.7.1.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=">=virtual/rust-1.54.0"
RDEPEND="${DEPEND}"

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
	doins "${S}"/contrib/completion/_fd
	dodoc README.md
	doman doc/*.1
}