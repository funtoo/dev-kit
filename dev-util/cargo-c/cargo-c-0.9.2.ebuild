# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="adler-1.0.2
aho-corasick-0.7.18
ansi_term-0.11.0
anyhow-1.0.43
arrayvec-0.5.2
atty-0.2.14
autocfg-1.0.1
bitflags-1.3.2
bitmaps-2.1.0
bstr-0.2.16
bytesize-1.1.0
cargo-0.55.0
cargo-platform-0.1.2
cargo-util-0.1.1
cbindgen-0.20.0
cc-1.0.70
cfg-if-1.0.0
clap-2.33.3
commoncrypto-0.2.0
commoncrypto-sys-0.2.0
core-foundation-0.9.1
core-foundation-sys-0.8.2
crates-io-0.33.0
crc32fast-1.2.1
crossbeam-utils-0.8.5
crypto-hash-0.3.4
curl-0.4.38
curl-sys-0.4.45+curl-7.78.0
either-1.6.1
env_logger-0.8.4
filetime-0.2.15
flate2-1.0.21
fnv-1.0.7
foreign-types-0.3.2
foreign-types-shared-0.1.1
form_urlencoded-1.0.1
fwdansi-1.1.0
getrandom-0.2.3
git2-0.13.22
git2-curl-0.14.1
glob-0.3.0
globset-0.4.8
hashbrown-0.11.2
heck-0.3.3
hermit-abi-0.1.19
hex-0.3.2
hex-0.4.3
home-0.5.3
humantime-2.1.0
idna-0.2.3
ignore-0.4.18
im-rc-15.0.0
indexmap-1.7.0
itertools-0.10.1
itoa-0.4.8
jobserver-0.1.24
lazy_static-1.4.0
lazycell-1.3.0
libc-0.2.101
libgit2-sys-0.12.23+1.2.0
libnghttp2-sys-0.1.6+1.43.0
libssh2-sys-0.2.21
libz-sys-1.1.3
log-0.4.14
matches-0.1.9
memchr-2.4.1
miniz_oxide-0.4.4
miow-0.3.7
num_cpus-1.13.0
once_cell-1.8.0
opener-0.4.1
openssl-0.10.36
openssl-probe-0.1.4
openssl-src-111.16.0+1.1.1l
openssl-sys-0.9.66
percent-encoding-2.1.0
pkg-config-0.3.19
ppv-lite86-0.2.10
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.29
quote-1.0.9
rand-0.8.4
rand_chacha-0.3.1
rand_core-0.5.1
rand_core-0.6.3
rand_hc-0.3.1
rand_xoshiro-0.4.0
redox_syscall-0.2.10
regex-1.5.4
regex-syntax-0.6.25
remove_dir_all-0.5.3
rustc-workspace-hack-1.0.0
rustfix-0.5.1
ryu-1.0.5
same-file-1.0.6
schannel-0.1.19
semver-1.0.4
serde-1.0.130
serde_derive-1.0.130
serde_ignored-0.1.2
serde_json-1.0.67
shell-escape-0.1.5
sized-chunks-0.6.5
socket2-0.4.1
strip-ansi-escapes-0.1.1
strsim-0.8.0
structopt-0.3.23
structopt-derive-0.4.16
syn-1.0.76
tar-0.4.37
tempfile-3.2.0
termcolor-1.1.2
textwrap-0.11.0
thread_local-1.1.3
tinyvec-1.3.1
tinyvec_macros-0.1.0
toml-0.5.8
typenum-1.14.0
unicode-bidi-0.3.6
unicode-normalization-0.1.19
unicode-segmentation-1.8.0
unicode-width-0.1.8
unicode-xid-0.2.2
url-2.2.2
utf8parse-0.2.0
vcpkg-0.2.15
vec_map-0.8.2
version_check-0.9.3
vte-0.10.1
vte_generate_state_changes-0.1.1
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Helper program to build and install c-like libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://api.github.com/repos/lu-zero/cargo-c/tarball/v0.9.2 -> cargo-c-0.9.2.tar.gz
	$(cargo_crate_uris ${CRATES})"

RESTRICT="mirror"
# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="*"

BDEPEND="
	>=virtual/rust-1.51.0
"

RDEPEND="sys-libs/zlib
	dev-libs/openssl:0=
	net-libs/libssh2
	net-misc/curl[ssl]
"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lu-zero-cargo-c-* ${S} || die
}