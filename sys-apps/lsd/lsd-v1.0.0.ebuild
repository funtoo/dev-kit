# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.18
ansi_term-0.12.1
assert_cmd-1.0.8
assert_fs-1.0.7
autocfg-1.1.0
bitflags-1.3.2
bstr-0.2.17
bumpalo-3.12.0
cc-1.0.79
cfg-if-1.0.0
chrono-0.4.19
chrono-humanize-0.1.2
clap-4.1.8
clap_complete-4.1.4
clap_derive-4.1.8
clap_lex-0.3.2
crossbeam-utils-0.8.8
crossterm-0.24.0
crossterm_winapi-0.9.0
difference-2.0.0
difflib-0.4.0
dirs-3.0.2
dirs-sys-0.3.7
doc-comment-0.3.3
either-1.6.1
errno-0.2.8
errno-dragonfly-0.1.2
fastrand-1.7.0
float-cmp-0.8.0
fnv-1.0.7
getrandom-0.2.5
git2-0.16.1
glob-0.3.0
globset-0.4.8
globwalk-0.8.1
hashbrown-0.11.2
heck-0.4.1
hermit-abi-0.2.6
human-sort-0.2.2
idna-0.2.3
ignore-0.4.18
indexmap-1.8.0
instant-0.1.12
io-lifetimes-1.0.4
is-terminal-0.4.2
itertools-0.10.3
jobserver-0.1.26
js-sys-0.3.58
lazy_static-1.4.0
libc-0.2.139
libgit2-sys-0.14.2+1.5.1
libz-sys-1.1.8
linked-hash-map-0.5.4
linux-raw-sys-0.1.4
lock_api-0.4.6
log-0.4.16
lscolors-0.9.0
matches-0.1.9
memchr-2.4.1
mio-0.8.4
normalize-line-endings-0.3.0
num-integer-0.1.44
num-traits-0.2.14
once_cell-1.17.1
os_str_bytes-6.3.0
parking_lot-0.11.2
parking_lot-0.12.1
parking_lot_core-0.8.5
parking_lot_core-0.9.3
percent-encoding-2.1.0
pkg-config-0.3.26
predicates-1.0.8
predicates-2.1.1
predicates-core-1.0.3
predicates-tree-1.0.5
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.51
pure-rust-locales-0.5.6
quote-1.0.17
redox_syscall-0.2.12
redox_users-0.4.2
regex-1.7.3
regex-automata-0.1.10
regex-syntax-0.6.29
remove_dir_all-0.5.3
rustix-0.36.7
ryu-1.0.9
same-file-1.0.6
scopeguard-1.1.0
serde-1.0.136
serde_derive-1.0.136
serde_yaml-0.8.23
serial_test-0.5.1
serial_test_derive-0.5.1
signal-hook-0.3.14
signal-hook-mio-0.2.3
signal-hook-registry-1.4.0
smallvec-1.8.0
strsim-0.10.0
syn-1.0.89
sys-locale-0.2.4
tempfile-3.3.0
term_grid-0.1.7
termcolor-1.1.3
terminal_size-0.1.17
terminal_size-0.2.3
termtree-0.2.4
thiserror-1.0.30
thiserror-impl-1.0.30
thread_local-1.1.4
time-0.1.43
tinyvec-1.6.0
tinyvec_macros-0.1.0
unicode-bidi-0.3.8
unicode-ident-1.0.6
unicode-normalization-0.1.19
unicode-width-0.1.9
unicode-xid-0.2.2
url-2.1.1
users-0.11.0
vcpkg-0.2.15
version_check-0.9.4
vsort-0.1.0
wait-timeout-0.2.0
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
wasi-0.11.0+wasi-snapshot-preview1
wasm-bindgen-0.2.81
wasm-bindgen-backend-0.2.81
wasm-bindgen-macro-0.2.81
wasm-bindgen-macro-support-0.2.81
wasm-bindgen-shared-0.2.81
web-sys-0.3.58
wild-2.0.4
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
windows-0.43.0
windows-sys-0.36.1
windows-sys-0.42.0
windows-sys-0.45.0
windows-targets-0.42.1
windows_aarch64_gnullvm-0.42.1
windows_aarch64_msvc-0.36.1
windows_aarch64_msvc-0.42.1
windows_i686_gnu-0.36.1
windows_i686_gnu-0.42.1
windows_i686_msvc-0.36.1
windows_i686_msvc-0.42.1
windows_x86_64_gnu-0.36.1
windows_x86_64_gnu-0.42.1
windows_x86_64_gnullvm-0.42.1
windows_x86_64_msvc-0.36.1
windows_x86_64_msvc-0.42.1
xattr-0.2.2
xdg-2.1.0
yaml-rust-0.4.5
"

inherit cargo

DESCRIPTION="A modern ls with a lot of pretty colors and awesome icons"
HOMEPAGE="https://github.com/lsd-rs/lsd"
SRC_URI="https://api.github.com/repos/lsd-rs/lsd/tarball/v1.0.0 -> lsd-v1.0.0.tar.gz
https://crates.io/api/v1/crates/aho-corasick/0.7.18/download -> aho-corasick-0.7.18.crate
https://crates.io/api/v1/crates/ansi_term/0.12.1/download -> ansi_term-0.12.1.crate
https://crates.io/api/v1/crates/assert_cmd/1.0.8/download -> assert_cmd-1.0.8.crate
https://crates.io/api/v1/crates/assert_fs/1.0.7/download -> assert_fs-1.0.7.crate
https://crates.io/api/v1/crates/autocfg/1.1.0/download -> autocfg-1.1.0.crate
https://crates.io/api/v1/crates/bitflags/1.3.2/download -> bitflags-1.3.2.crate
https://crates.io/api/v1/crates/bstr/0.2.17/download -> bstr-0.2.17.crate
https://crates.io/api/v1/crates/bumpalo/3.12.0/download -> bumpalo-3.12.0.crate
https://crates.io/api/v1/crates/cc/1.0.79/download -> cc-1.0.79.crate
https://crates.io/api/v1/crates/cfg-if/1.0.0/download -> cfg-if-1.0.0.crate
https://crates.io/api/v1/crates/chrono/0.4.19/download -> chrono-0.4.19.crate
https://crates.io/api/v1/crates/chrono-humanize/0.1.2/download -> chrono-humanize-0.1.2.crate
https://crates.io/api/v1/crates/clap/4.1.8/download -> clap-4.1.8.crate
https://crates.io/api/v1/crates/clap_complete/4.1.4/download -> clap_complete-4.1.4.crate
https://crates.io/api/v1/crates/clap_derive/4.1.8/download -> clap_derive-4.1.8.crate
https://crates.io/api/v1/crates/clap_lex/0.3.2/download -> clap_lex-0.3.2.crate
https://crates.io/api/v1/crates/crossbeam-utils/0.8.8/download -> crossbeam-utils-0.8.8.crate
https://crates.io/api/v1/crates/crossterm/0.24.0/download -> crossterm-0.24.0.crate
https://crates.io/api/v1/crates/crossterm_winapi/0.9.0/download -> crossterm_winapi-0.9.0.crate
https://crates.io/api/v1/crates/difference/2.0.0/download -> difference-2.0.0.crate
https://crates.io/api/v1/crates/difflib/0.4.0/download -> difflib-0.4.0.crate
https://crates.io/api/v1/crates/dirs/3.0.2/download -> dirs-3.0.2.crate
https://crates.io/api/v1/crates/dirs-sys/0.3.7/download -> dirs-sys-0.3.7.crate
https://crates.io/api/v1/crates/doc-comment/0.3.3/download -> doc-comment-0.3.3.crate
https://crates.io/api/v1/crates/either/1.6.1/download -> either-1.6.1.crate
https://crates.io/api/v1/crates/errno/0.2.8/download -> errno-0.2.8.crate
https://crates.io/api/v1/crates/errno-dragonfly/0.1.2/download -> errno-dragonfly-0.1.2.crate
https://crates.io/api/v1/crates/fastrand/1.7.0/download -> fastrand-1.7.0.crate
https://crates.io/api/v1/crates/float-cmp/0.8.0/download -> float-cmp-0.8.0.crate
https://crates.io/api/v1/crates/fnv/1.0.7/download -> fnv-1.0.7.crate
https://crates.io/api/v1/crates/getrandom/0.2.5/download -> getrandom-0.2.5.crate
https://crates.io/api/v1/crates/git2/0.16.1/download -> git2-0.16.1.crate
https://crates.io/api/v1/crates/glob/0.3.0/download -> glob-0.3.0.crate
https://crates.io/api/v1/crates/globset/0.4.8/download -> globset-0.4.8.crate
https://crates.io/api/v1/crates/globwalk/0.8.1/download -> globwalk-0.8.1.crate
https://crates.io/api/v1/crates/hashbrown/0.11.2/download -> hashbrown-0.11.2.crate
https://crates.io/api/v1/crates/heck/0.4.1/download -> heck-0.4.1.crate
https://crates.io/api/v1/crates/hermit-abi/0.2.6/download -> hermit-abi-0.2.6.crate
https://crates.io/api/v1/crates/human-sort/0.2.2/download -> human-sort-0.2.2.crate
https://crates.io/api/v1/crates/idna/0.2.3/download -> idna-0.2.3.crate
https://crates.io/api/v1/crates/ignore/0.4.18/download -> ignore-0.4.18.crate
https://crates.io/api/v1/crates/indexmap/1.8.0/download -> indexmap-1.8.0.crate
https://crates.io/api/v1/crates/instant/0.1.12/download -> instant-0.1.12.crate
https://crates.io/api/v1/crates/io-lifetimes/1.0.4/download -> io-lifetimes-1.0.4.crate
https://crates.io/api/v1/crates/is-terminal/0.4.2/download -> is-terminal-0.4.2.crate
https://crates.io/api/v1/crates/itertools/0.10.3/download -> itertools-0.10.3.crate
https://crates.io/api/v1/crates/jobserver/0.1.26/download -> jobserver-0.1.26.crate
https://crates.io/api/v1/crates/js-sys/0.3.58/download -> js-sys-0.3.58.crate
https://crates.io/api/v1/crates/lazy_static/1.4.0/download -> lazy_static-1.4.0.crate
https://crates.io/api/v1/crates/libc/0.2.139/download -> libc-0.2.139.crate
https://crates.io/api/v1/crates/libgit2-sys/0.14.2+1.5.1/download -> libgit2-sys-0.14.2+1.5.1.crate
https://crates.io/api/v1/crates/libz-sys/1.1.8/download -> libz-sys-1.1.8.crate
https://crates.io/api/v1/crates/linked-hash-map/0.5.4/download -> linked-hash-map-0.5.4.crate
https://crates.io/api/v1/crates/linux-raw-sys/0.1.4/download -> linux-raw-sys-0.1.4.crate
https://crates.io/api/v1/crates/lock_api/0.4.6/download -> lock_api-0.4.6.crate
https://crates.io/api/v1/crates/log/0.4.16/download -> log-0.4.16.crate
https://crates.io/api/v1/crates/lscolors/0.9.0/download -> lscolors-0.9.0.crate
https://crates.io/api/v1/crates/matches/0.1.9/download -> matches-0.1.9.crate
https://crates.io/api/v1/crates/memchr/2.4.1/download -> memchr-2.4.1.crate
https://crates.io/api/v1/crates/mio/0.8.4/download -> mio-0.8.4.crate
https://crates.io/api/v1/crates/normalize-line-endings/0.3.0/download -> normalize-line-endings-0.3.0.crate
https://crates.io/api/v1/crates/num-integer/0.1.44/download -> num-integer-0.1.44.crate
https://crates.io/api/v1/crates/num-traits/0.2.14/download -> num-traits-0.2.14.crate
https://crates.io/api/v1/crates/once_cell/1.17.1/download -> once_cell-1.17.1.crate
https://crates.io/api/v1/crates/os_str_bytes/6.3.0/download -> os_str_bytes-6.3.0.crate
https://crates.io/api/v1/crates/parking_lot/0.11.2/download -> parking_lot-0.11.2.crate
https://crates.io/api/v1/crates/parking_lot/0.12.1/download -> parking_lot-0.12.1.crate
https://crates.io/api/v1/crates/parking_lot_core/0.8.5/download -> parking_lot_core-0.8.5.crate
https://crates.io/api/v1/crates/parking_lot_core/0.9.3/download -> parking_lot_core-0.9.3.crate
https://crates.io/api/v1/crates/percent-encoding/2.1.0/download -> percent-encoding-2.1.0.crate
https://crates.io/api/v1/crates/pkg-config/0.3.26/download -> pkg-config-0.3.26.crate
https://crates.io/api/v1/crates/predicates/1.0.8/download -> predicates-1.0.8.crate
https://crates.io/api/v1/crates/predicates/2.1.1/download -> predicates-2.1.1.crate
https://crates.io/api/v1/crates/predicates-core/1.0.3/download -> predicates-core-1.0.3.crate
https://crates.io/api/v1/crates/predicates-tree/1.0.5/download -> predicates-tree-1.0.5.crate
https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download -> proc-macro-error-1.0.4.crate
https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download -> proc-macro-error-attr-1.0.4.crate
https://crates.io/api/v1/crates/proc-macro2/1.0.51/download -> proc-macro2-1.0.51.crate
https://crates.io/api/v1/crates/pure-rust-locales/0.5.6/download -> pure-rust-locales-0.5.6.crate
https://crates.io/api/v1/crates/quote/1.0.17/download -> quote-1.0.17.crate
https://crates.io/api/v1/crates/redox_syscall/0.2.12/download -> redox_syscall-0.2.12.crate
https://crates.io/api/v1/crates/redox_users/0.4.2/download -> redox_users-0.4.2.crate
https://crates.io/api/v1/crates/regex/1.7.3/download -> regex-1.7.3.crate
https://crates.io/api/v1/crates/regex-automata/0.1.10/download -> regex-automata-0.1.10.crate
https://crates.io/api/v1/crates/regex-syntax/0.6.29/download -> regex-syntax-0.6.29.crate
https://crates.io/api/v1/crates/remove_dir_all/0.5.3/download -> remove_dir_all-0.5.3.crate
https://crates.io/api/v1/crates/rustix/0.36.7/download -> rustix-0.36.7.crate
https://crates.io/api/v1/crates/ryu/1.0.9/download -> ryu-1.0.9.crate
https://crates.io/api/v1/crates/same-file/1.0.6/download -> same-file-1.0.6.crate
https://crates.io/api/v1/crates/scopeguard/1.1.0/download -> scopeguard-1.1.0.crate
https://crates.io/api/v1/crates/serde/1.0.136/download -> serde-1.0.136.crate
https://crates.io/api/v1/crates/serde_derive/1.0.136/download -> serde_derive-1.0.136.crate
https://crates.io/api/v1/crates/serde_yaml/0.8.23/download -> serde_yaml-0.8.23.crate
https://crates.io/api/v1/crates/serial_test/0.5.1/download -> serial_test-0.5.1.crate
https://crates.io/api/v1/crates/serial_test_derive/0.5.1/download -> serial_test_derive-0.5.1.crate
https://crates.io/api/v1/crates/signal-hook/0.3.14/download -> signal-hook-0.3.14.crate
https://crates.io/api/v1/crates/signal-hook-mio/0.2.3/download -> signal-hook-mio-0.2.3.crate
https://crates.io/api/v1/crates/signal-hook-registry/1.4.0/download -> signal-hook-registry-1.4.0.crate
https://crates.io/api/v1/crates/smallvec/1.8.0/download -> smallvec-1.8.0.crate
https://crates.io/api/v1/crates/strsim/0.10.0/download -> strsim-0.10.0.crate
https://crates.io/api/v1/crates/syn/1.0.89/download -> syn-1.0.89.crate
https://crates.io/api/v1/crates/sys-locale/0.2.4/download -> sys-locale-0.2.4.crate
https://crates.io/api/v1/crates/tempfile/3.3.0/download -> tempfile-3.3.0.crate
https://crates.io/api/v1/crates/term_grid/0.1.7/download -> term_grid-0.1.7.crate
https://crates.io/api/v1/crates/termcolor/1.1.3/download -> termcolor-1.1.3.crate
https://crates.io/api/v1/crates/terminal_size/0.1.17/download -> terminal_size-0.1.17.crate
https://crates.io/api/v1/crates/terminal_size/0.2.3/download -> terminal_size-0.2.3.crate
https://crates.io/api/v1/crates/termtree/0.2.4/download -> termtree-0.2.4.crate
https://crates.io/api/v1/crates/thiserror/1.0.30/download -> thiserror-1.0.30.crate
https://crates.io/api/v1/crates/thiserror-impl/1.0.30/download -> thiserror-impl-1.0.30.crate
https://crates.io/api/v1/crates/thread_local/1.1.4/download -> thread_local-1.1.4.crate
https://crates.io/api/v1/crates/time/0.1.43/download -> time-0.1.43.crate
https://crates.io/api/v1/crates/tinyvec/1.6.0/download -> tinyvec-1.6.0.crate
https://crates.io/api/v1/crates/tinyvec_macros/0.1.0/download -> tinyvec_macros-0.1.0.crate
https://crates.io/api/v1/crates/unicode-bidi/0.3.8/download -> unicode-bidi-0.3.8.crate
https://crates.io/api/v1/crates/unicode-ident/1.0.6/download -> unicode-ident-1.0.6.crate
https://crates.io/api/v1/crates/unicode-normalization/0.1.19/download -> unicode-normalization-0.1.19.crate
https://crates.io/api/v1/crates/unicode-width/0.1.9/download -> unicode-width-0.1.9.crate
https://crates.io/api/v1/crates/unicode-xid/0.2.2/download -> unicode-xid-0.2.2.crate
https://crates.io/api/v1/crates/url/2.1.1/download -> url-2.1.1.crate
https://crates.io/api/v1/crates/users/0.11.0/download -> users-0.11.0.crate
https://crates.io/api/v1/crates/vcpkg/0.2.15/download -> vcpkg-0.2.15.crate
https://crates.io/api/v1/crates/version_check/0.9.4/download -> version_check-0.9.4.crate
https://crates.io/api/v1/crates/vsort/0.1.0/download -> vsort-0.1.0.crate
https://crates.io/api/v1/crates/wait-timeout/0.2.0/download -> wait-timeout-0.2.0.crate
https://crates.io/api/v1/crates/walkdir/2.3.2/download -> walkdir-2.3.2.crate
https://crates.io/api/v1/crates/wasi/0.10.2+wasi-snapshot-preview1/download -> wasi-0.10.2+wasi-snapshot-preview1.crate
https://crates.io/api/v1/crates/wasi/0.11.0+wasi-snapshot-preview1/download -> wasi-0.11.0+wasi-snapshot-preview1.crate
https://crates.io/api/v1/crates/wasm-bindgen/0.2.81/download -> wasm-bindgen-0.2.81.crate
https://crates.io/api/v1/crates/wasm-bindgen-backend/0.2.81/download -> wasm-bindgen-backend-0.2.81.crate
https://crates.io/api/v1/crates/wasm-bindgen-macro/0.2.81/download -> wasm-bindgen-macro-0.2.81.crate
https://crates.io/api/v1/crates/wasm-bindgen-macro-support/0.2.81/download -> wasm-bindgen-macro-support-0.2.81.crate
https://crates.io/api/v1/crates/wasm-bindgen-shared/0.2.81/download -> wasm-bindgen-shared-0.2.81.crate
https://crates.io/api/v1/crates/web-sys/0.3.58/download -> web-sys-0.3.58.crate
https://crates.io/api/v1/crates/wild/2.0.4/download -> wild-2.0.4.crate
https://crates.io/api/v1/crates/winapi/0.3.9/download -> winapi-0.3.9.crate
https://crates.io/api/v1/crates/winapi-i686-pc-windows-gnu/0.4.0/download -> winapi-i686-pc-windows-gnu-0.4.0.crate
https://crates.io/api/v1/crates/winapi-util/0.1.5/download -> winapi-util-0.1.5.crate
https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download -> winapi-x86_64-pc-windows-gnu-0.4.0.crate
https://crates.io/api/v1/crates/windows/0.43.0/download -> windows-0.43.0.crate
https://crates.io/api/v1/crates/windows-sys/0.36.1/download -> windows-sys-0.36.1.crate
https://crates.io/api/v1/crates/windows-sys/0.42.0/download -> windows-sys-0.42.0.crate
https://crates.io/api/v1/crates/windows-sys/0.45.0/download -> windows-sys-0.45.0.crate
https://crates.io/api/v1/crates/windows-targets/0.42.1/download -> windows-targets-0.42.1.crate
https://crates.io/api/v1/crates/windows_aarch64_gnullvm/0.42.1/download -> windows_aarch64_gnullvm-0.42.1.crate
https://crates.io/api/v1/crates/windows_aarch64_msvc/0.36.1/download -> windows_aarch64_msvc-0.36.1.crate
https://crates.io/api/v1/crates/windows_aarch64_msvc/0.42.1/download -> windows_aarch64_msvc-0.42.1.crate
https://crates.io/api/v1/crates/windows_i686_gnu/0.36.1/download -> windows_i686_gnu-0.36.1.crate
https://crates.io/api/v1/crates/windows_i686_gnu/0.42.1/download -> windows_i686_gnu-0.42.1.crate
https://crates.io/api/v1/crates/windows_i686_msvc/0.36.1/download -> windows_i686_msvc-0.36.1.crate
https://crates.io/api/v1/crates/windows_i686_msvc/0.42.1/download -> windows_i686_msvc-0.42.1.crate
https://crates.io/api/v1/crates/windows_x86_64_gnu/0.36.1/download -> windows_x86_64_gnu-0.36.1.crate
https://crates.io/api/v1/crates/windows_x86_64_gnu/0.42.1/download -> windows_x86_64_gnu-0.42.1.crate
https://crates.io/api/v1/crates/windows_x86_64_gnullvm/0.42.1/download -> windows_x86_64_gnullvm-0.42.1.crate
https://crates.io/api/v1/crates/windows_x86_64_msvc/0.36.1/download -> windows_x86_64_msvc-0.36.1.crate
https://crates.io/api/v1/crates/windows_x86_64_msvc/0.42.1/download -> windows_x86_64_msvc-0.42.1.crate
https://crates.io/api/v1/crates/xattr/0.2.2/download -> xattr-0.2.2.crate
https://crates.io/api/v1/crates/xdg/2.1.0/download -> xdg-2.1.0.crate
https://crates.io/api/v1/crates/yaml-rust/0.4.5/download -> yaml-rust-0.4.5.crate
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
	mv ${WORKDIR}/lsd-rs-lsd-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}