# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.18
ansi_term-0.11.0
ansi_term-0.12.1
assert_cmd-1.0.8
assert_fs-1.0.3
atty-0.2.14
autocfg-1.0.1
bitflags-1.2.1
bstr-0.2.16
cfg-if-1.0.0
chrono-0.4.19
chrono-humanize-0.1.2
clap-2.33.3
crossbeam-utils-0.8.5
crossterm-0.21.0
crossterm_winapi-0.8.0
difference-2.0.0
difflib-0.4.0
dirs-3.0.2
dirs-sys-0.3.6
doc-comment-0.3.3
dtoa-0.4.8
either-1.6.1
float-cmp-0.8.0
fnv-1.0.7
getrandom-0.2.3
glob-0.3.0
globset-0.4.8
globwalk-0.8.1
hashbrown-0.11.2
hermit-abi-0.1.19
human-sort-0.2.2
ignore-0.4.18
indexmap-1.7.0
instant-0.1.10
itertools-0.10.1
lazy_static-1.4.0
libc-0.2.100
linked-hash-map-0.5.4
lock_api-0.4.4
log-0.4.14
lscolors-0.7.1
memchr-2.4.1
mio-0.7.13
miow-0.3.7
normalize-line-endings-0.3.0
ntapi-0.3.6
num-integer-0.1.44
num-traits-0.2.14
once_cell-1.8.0
parking_lot-0.11.1
parking_lot_core-0.8.3
ppv-lite86-0.2.10
predicates-1.0.8
predicates-2.0.2
predicates-core-1.0.2
predicates-tree-1.0.3
proc-macro2-1.0.28
quote-1.0.9
rand-0.8.4
rand_chacha-0.3.1
rand_core-0.6.3
rand_hc-0.3.1
redox_syscall-0.2.10
redox_users-0.4.0
regex-1.5.4
regex-automata-0.1.10
regex-syntax-0.6.25
remove_dir_all-0.5.3
same-file-1.0.6
scopeguard-1.1.0
serde-1.0.129
serde_derive-1.0.129
serde_yaml-0.8.19
serial_test-0.5.1
serial_test_derive-0.5.1
signal-hook-0.3.9
signal-hook-mio-0.2.1
signal-hook-registry-1.4.0
smallvec-1.6.1
strsim-0.8.0
syn-1.0.75
tempfile-3.2.0
term_grid-0.1.7
term_size-0.3.2
terminal_size-0.1.17
textwrap-0.11.0
thread_local-1.1.3
time-0.1.43
treeline-0.1.0
unicode-width-0.1.8
unicode-xid-0.2.2
users-0.11.0
vec_map-0.8.2
version_check-0.9.3
wait-timeout-0.2.0
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
wild-2.0.4
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
xdg-2.1.0
yaml-rust-0.4.5
"

inherit cargo

DESCRIPTION="A modern ls with a lot of pretty colors and awesome icons"
HOMEPAGE="https://github.com/Peltoche/lsd"
SRC_URI="https://api.github.com/repos/Peltoche/lsd/tarball/0.21.0 -> lsd-0.21.0.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+git"

DEPEND=""
RDEPEND=""
BDEPEND=">=virtual/rust-1.31.0"

QA_FLAGS_IGNORED="/usr/bin/lsd"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/Peltoche-lsd-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}