# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.19
android_system_properties-0.1.5
ansi_term-0.12.1
anyhow-1.0.66
argmax-0.3.1
atty-0.2.14
autocfg-1.1.0
bitflags-1.3.2
bstr-0.2.17
bumpalo-3.11.1
cc-1.0.73
cfg-if-1.0.0
chrono-0.4.22
clap-4.0.18
clap_complete-4.0.3
clap_derive-4.0.18
clap_lex-0.3.0
codespan-reporting-0.11.1
core-foundation-sys-0.8.3
crossbeam-channel-0.5.6
crossbeam-utils-0.8.12
ctrlc-3.2.3
cxx-1.0.80
cxx-build-1.0.80
cxxbridge-flags-1.0.80
cxxbridge-macro-1.0.80
diff-0.1.13
dirs-next-2.0.0
dirs-sys-next-0.1.2
errno-0.2.8
errno-dragonfly-0.1.2
faccess-0.2.4
filetime-0.2.18
fnv-1.0.7
fs_extra-1.2.0
fuchsia-cprng-0.1.1
getrandom-0.2.8
globset-0.4.9
heck-0.4.0
hermit-abi-0.1.19
humantime-2.1.0
iana-time-zone-0.1.51
iana-time-zone-haiku-0.1.1
ignore-0.4.18
io-lifetimes-0.7.4
jemalloc-sys-0.5.2+5.3.0-patched
jemallocator-0.5.0
js-sys-0.3.60
lazy_static-1.4.0
libc-0.2.136
link-cplusplus-1.0.7
linux-raw-sys-0.0.46
log-0.4.17
lscolors-0.12.0
memchr-2.5.0
nix-0.24.2
nix-0.25.0
normpath-0.3.2
num-integer-0.1.45
num-traits-0.2.15
num_cpus-1.13.1
once_cell-1.15.0
os_str_bytes-6.3.0
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.47
quote-1.0.21
rand-0.4.6
rand_core-0.3.1
rand_core-0.4.2
rdrand-0.4.0
redox_syscall-0.2.16
redox_users-0.4.3
regex-1.6.0
regex-syntax-0.6.27
remove_dir_all-0.5.3
rustix-0.35.12
same-file-1.0.6
scratch-1.0.2
strsim-0.10.0
syn-1.0.103
tempdir-0.3.7
termcolor-1.1.3
terminal_size-0.2.1
test-case-2.2.2
test-case-macros-2.2.2
thiserror-1.0.37
thiserror-impl-1.0.37
thread_local-1.1.4
time-0.1.44
unicode-ident-1.0.5
unicode-width-0.1.10
users-0.11.0
version_check-0.9.4
walkdir-2.3.2
wasi-0.10.0+wasi-snapshot-preview1
wasi-0.11.0+wasi-snapshot-preview1
wasm-bindgen-0.2.83
wasm-bindgen-backend-0.2.83
wasm-bindgen-macro-0.2.83
wasm-bindgen-macro-support-0.2.83
wasm-bindgen-shared-0.2.83
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
windows-sys-0.36.1
windows-sys-0.42.0
windows_aarch64_gnullvm-0.42.0
windows_aarch64_msvc-0.36.1
windows_aarch64_msvc-0.42.0
windows_i686_gnu-0.36.1
windows_i686_gnu-0.42.0
windows_i686_msvc-0.36.1
windows_i686_msvc-0.42.0
windows_x86_64_gnu-0.36.1
windows_x86_64_gnu-0.42.0
windows_x86_64_gnullvm-0.42.0
windows_x86_64_msvc-0.36.1
windows_x86_64_msvc-0.42.0
"

inherit bash-completion-r1 cargo

DESCRIPTION="Alternative to find that provides sensible defaults for 80% of the use cases"
HOMEPAGE="https://github.com/sharkdp/fd"
SRC_URI="https://api.github.com/repos/sharkdp/fd/tarball/v8.5.2 -> fd-8.5.2.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=">=virtual/rust-1.31.0"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="/usr/bin/fd"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/sharkdp-fd-* ${S} || die
}

src_compile() {
	export SHELL_COMPLETIONS_DIR="${T}/shell_completions"
	cargo_src_compile
}

src_install() {
	cargo_src_install

	newbashcomp "${T}"/shell_completions/fd.bash fd
	insinto /usr/share/zsh/site-functions
	doins "${S}"/contrib/completion/_fd
	insinto /usr/share/fish/vendor_completions.d
	doins "${T}"/shell_completions/fd.fish
	dodoc README.md
	doman doc/*.1
}